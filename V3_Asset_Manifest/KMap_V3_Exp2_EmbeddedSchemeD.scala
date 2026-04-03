package regular

import chisel3._
import chisel3.util._

class KMap_V3_Exp2_EmbeddedSchemeD extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(8.W))
    val b = Input(UInt(8.W))
    val product = Output(SInt(16.W))
  })

  val a_signed = io.a.asSInt
  val b_extended = Cat(io.b, 0.U(1.W))

  val rows = Wire(Vec(4, UInt(16.W)))
  val neg_bits = Wire(Vec(4, Bool()))

  for (i <- 0 until 4) {
    val b_bits = b_extended(2 * i + 2, 2 * i)
    val neg = b_bits(2)
    val zero = (b_bits === 0.U) || (b_bits === 7.U)
    
    neg_bits(i) := neg && !zero 
    
    val pp_bits = Wire(Vec(9, Bool()))
    
    if (i == 0) {
      val is_100 = b_bits === 4.U
      for (j <- 0 until 9) {
        val a_bit = if (j < 8) io.a(j) else io.a(7)
        val a_bit_2 = if (j == 0) false.B else if (j <= 8) io.a(j-1) else io.a(7) 
        
        val approx_bit = (!zero) & (a_bit ^ neg)
        val exact_bit = (!zero) & (a_bit_2 ^ neg)
        
        pp_bits(j) := Mux(is_100, exact_bit, approx_bit)
      }
    } else {
      for (j <- 0 until 9) {
        val a_bit = if (j < 8) io.a(j) else io.a(7)
        pp_bits(j) := (!zero) & (a_bit ^ neg)
      }
    }
    
    val pp_ext = pp_bits.asUInt.asSInt.pad(16).asUInt
    rows(i) := pp_ext << (2 * i)
  }

  // Embedded 手动回填: 把分布在4个行的neg_bits组合成第5个操作数，代替原本的8个操作数
  val op0 = rows(0)
  val op1 = rows(1)
  val op2 = rows(2)
  val op3 = rows(3)
  val op4 = (neg_bits(3).asUInt << 6) | (neg_bits(2).asUInt << 4) | (neg_bits(1).asUInt << 2) | neg_bits(0).asUInt

  val sum = op0 + op1 + op2 + op3 + op4
            
  io.product := sum.asSInt
}

object KMap_V3_Exp2_EmbeddedSchemeD extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new KMap_V3_Exp2_EmbeddedSchemeD)
}
