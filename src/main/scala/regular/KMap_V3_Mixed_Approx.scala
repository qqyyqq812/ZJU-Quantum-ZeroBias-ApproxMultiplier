package regular

import chisel3._
import chisel3.util._

// 基于 V3 (Scheme D / 扁平树 / 无内部零门控) 架构的纯血统混合参数化成器
// 这将确保我们在消融近似行数时，所有变体(1,2,3,4行) 共享着完全一样的最优化算子骨架。
class KMap_V3_Mixed_Approx(numApproxRows: Int) extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(8.W))
    val b = Input(UInt(8.W))
    val product = Output(SInt(16.W))
  })

  val a_signed = io.a.asSInt
  val b_extended = Cat(io.b, 0.U(1.W))

  val rows = Wire(Vec(4, UInt(16.W)))
  val neg_bits = Wire(Vec(4, Bool()))

  // 严格控制需要的 EXACT 编码器数量
  val numExactRows = 4 - numApproxRows
  val encoders = Seq.tabulate(numExactRows)(_ => Module(new ExactEncoder))

  for (i <- 0 until 4) {
    val b_bits = b_extended(2 * i + 2, 2 * i)
    val neg = b_bits(2)
    val zero = (b_bits === 0.U) || (b_bits === 7.U)

    val pp_bits = Wire(Vec(9, Bool()))

    if (i < numApproxRows) {
      // -------------------------------------------------------------
      // 近似行: V3 架构 (无 a_is_zero 检测)
      // -------------------------------------------------------------
      neg_bits(i) := neg && !zero
      
      if (i == 0) {
        // 第一行且被近似: 触发 V3 Scheme D 特赦护盾
        val is_100 = b_bits === 4.U
        for (j <- 0 until 9) {
          val a_bit = if (j < 8) io.a(j) else io.a(7)
          val a_bit_2 = if (j == 0) false.B else if (j <= 8) io.a(j-1) else io.a(7) 
          
          val approx_bit = (!zero) & (a_bit ^ neg)
          val exact_bit = (!zero) & (a_bit_2 ^ neg)
          
          pp_bits(j) := Mux(is_100, exact_bit, approx_bit)
        }
      } else {
        // 其他被近似的行: 纯纯的近似逻辑
        for (j <- 0 until 9) {
          val a_bit = if (j < 8) io.a(j) else io.a(7)
          pp_bits(j) := (!zero) & (a_bit ^ neg)
        }
      }
    } else {
      // -------------------------------------------------------------
      // 精确行: 严格的 Exact Encoder
      // -------------------------------------------------------------
      val exactIdx = i - numApproxRows
      encoders(exactIdx).io.b_bits := b_bits
      val e_neg  = encoders(exactIdx).io.neg
      val e_zero = encoders(exactIdx).io.zero
      val e_two  = encoders(exactIdx).io.two
      val e_one  = encoders(exactIdx).io.one

      neg_bits(i) := e_neg && !e_zero

      for (j <- 0 until 9) {
        val a_bit   = if (j < 8) io.a(j) else io.a(7)
        val a_bit_2 = if (j == 0) false.B else if (j <= 8) io.a(j-1) else io.a(7)
        
        val sel_a  = a_bit & e_one
        val sel_2a = a_bit_2 & e_two
        val data_bit = sel_a | sel_2a
        
        pp_bits(j) := (data_bit ^ e_neg) & !e_zero
      }
    }
    
    val pp_ext = pp_bits.asUInt.asSInt.pad(16).asUInt
    rows(i) := pp_ext << (2 * i)
  }

  // -------------------------------------------------------------
  // V3 架构的扁平化自由加法树（交由 DC 构建 Dadda/Wallace）
  // -------------------------------------------------------------
  val operands = Seq(
    rows(0),
    rows(1),
    rows(2),
    rows(3),
    neg_bits(0).asUInt,
    neg_bits(1).asUInt << 2,
    neg_bits(2).asUInt << 4,
    neg_bits(3).asUInt << 6
  )

  val sum = operands.reduce(_ + _)
  io.product := sum.asSInt
}

class KMap_V3_1Row_Approx extends KMap_V3_Mixed_Approx(1)
class KMap_V3_2Row_Approx extends KMap_V3_Mixed_Approx(2)
class KMap_V3_3Row_Approx extends KMap_V3_Mixed_Approx(3)
class KMap_V3_4Row_Approx extends KMap_V3_Mixed_Approx(4)

object EmitV3Mixed extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new KMap_V3_1Row_Approx, Array("-td", "generated_rtl"))
  (new chisel3.stage.ChiselStage).emitVerilog(new KMap_V3_2Row_Approx, Array("-td", "generated_rtl"))
  (new chisel3.stage.ChiselStage).emitVerilog(new KMap_V3_3Row_Approx, Array("-td", "generated_rtl"))
  (new chisel3.stage.ChiselStage).emitVerilog(new KMap_V3_4Row_Approx, Array("-td", "generated_rtl"))
}
