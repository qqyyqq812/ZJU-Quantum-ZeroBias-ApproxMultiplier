package regular

import chisel3._
import chisel3.util._

// V3 最终版: 绝对物理与学术极限
// 1. 无宏观零门控 (NoZG) - 将屏蔽策略外包给系统 Latch，保障纯加法树最优化
// 2. 极简 Naive 阵列 - 放弃人工空隙回填，直接追加操作数，借助 DC Ultra 的 Flatten 全局拓扑重排
// 3. Scheme D 特赦 0偏 - 仅在 Row 0 的 100 编码下恢复 -2A 路径代价，换取 0.00 平均偏差
class KMap_V3_Final_SchemeD extends Module {
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
    
    // V3 重大改动: 彻底移除了 a_is_zero 宏观判断，回归组合逻辑极简纯净
    neg_bits(i) := neg && !zero 
    
    val pp_bits = Wire(Vec(9, Bool()))
    
    if (i == 0) {
      val is_100 = b_bits === 4.U
      for (j <- 0 until 9) {
        val a_bit = if (j < 8) io.a(j) else io.a(7)
        // x2 左移一位
        val a_bit_2 = if (j == 0) false.B else if (j <= 8) io.a(j-1) else io.a(7) 
        
        val approx_bit = (!zero) & (a_bit ^ neg)
        val exact_bit = (!zero) & (a_bit_2 ^ neg)
        
        // Scheme D 零面积成本的特赦复用补偿
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

  // V3 重大改动: 放弃 Embedded 空位缝合硬连线，回归极简并行，让位于 EDA 最优进位跳跃重组
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

object KMap_V3_Final_SchemeD extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new KMap_V3_Final_SchemeD)
}
