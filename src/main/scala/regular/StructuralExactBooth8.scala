package regular

import chisel3._
import chisel3.util._

// Exact Radix-4 Encoder
class ExactEncoder extends Module {
  val io = IO(new Bundle {
    val b_bits = Input(UInt(3.W))
    val neg  = Output(Bool())
    val zero = Output(Bool())
    val two  = Output(Bool())
    val one  = Output(Bool())
  })
  
  val b2 = io.b_bits(2)
  val b1 = io.b_bits(1)
  val b0 = io.b_bits(0)
  
  io.neg  := b2
  io.zero := (io.b_bits === 0.U) || (io.b_bits === 7.U)
  io.two  := (io.b_bits === 3.U) || (io.b_bits === 4.U)
  io.one  := (b1 ^ b0)
}

// 路线 A: 控制变量的基准精确乘法器
// 采用与我们近似乘法器完全相同的结构和布尔逻辑风格，以公平测量面积。
class StructuralExactBooth8 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(8.W))
    val b = Input(UInt(8.W))
    val product = Output(SInt(16.W))
  })

  val a_signed = io.a.asSInt
  val b_extended = Cat(io.b, 0.U(1.W))

  val rows = Wire(Vec(4, UInt(16.W)))
  val negs = Wire(Vec(4, Bool()))

  val encoders = Seq.tabulate(4)(_ => Module(new ExactEncoder))

  for (i <- 0 until 4) {
    encoders(i).io.b_bits := b_extended(2 * i + 2, 2 * i)
    val neg  = encoders(i).io.neg
    val zero = encoders(i).io.zero
    val two  = encoders(i).io.two
    val one  = encoders(i).io.one

    negs(i) := neg && !zero

    // 结构化纯布尔代数 PPG
    val pp_bits = Wire(Vec(9, Bool()))
    for (j <- 0 until 9) {
      val a_bit   = if (j < 8) io.a(j) else io.a(7)
      val a_bit_2 = if (j == 0) false.B else if (j <= 8) io.a(j-1) else io.a(7)
      
      val sel_a  = a_bit & one
      val sel_2a = a_bit_2 & two
      val data_bit = sel_a | sel_2a
      
      pp_bits(j) := (data_bit ^ neg) & !zero
    }

    val pp_uint = pp_bits.asUInt
    // 原生符号拓展机制（底层自动优化）
    val pp_sint = pp_uint.asSInt
    val pp_ext = pp_sint.pad(16).asUInt
    
    rows(i) := pp_ext << (2 * i)
  }

  // ExactBooth 必须作为 8-operand addition 进入到 DC，让 DC 的算术单元发力
  val sum = rows(0) + rows(1) + rows(2) + rows(3) + 
            negs(0).asUInt + (negs(1).asUInt << 2) + 
            (negs(2).asUInt << 4) + (negs(3).asUInt << 6)

  io.product := sum.asSInt
}

object StructuralExactBooth8 extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new StructuralExactBooth8)
}
