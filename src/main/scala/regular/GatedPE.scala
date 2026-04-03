package regular

import chisel3._
import chisel3.util._

// V3 破局级架构: 零感知操作数隔离保护壳 (Operand Isolation Shell)
// 1. Latch-Based / Register-Based Isolation: 探测到 A 或 B 为 0 时，或者启用门控条件时，即刻冻结送入 KMap 阵列的内部寄存器。
// 2. Mux 旁路补偿: 输入被冻结期间，阵列保持静电状态（Toggle=0），输出直接通过 Mux 强拉为 0 送出。
// 3. 完美继承: 内部依旧例化 V3_Final_SchemeD，无需触碰它已被 DC 极限优化的扁平网表。
class GatedMultiplier extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(8.W))
    val b = Input(UInt(8.W))
    val product = Output(SInt(16.W))
  })

  // 1. 轻量级全零探测 (Zero Probe) - 耗费面积极小
  // 由于 0 * x = 0，只要 a 或 b 中有任何一个为 0，乘积即为 0。
  val a_is_zero = io.a === 0.U
  val b_is_zero = io.b === 0.U
  val is_zero = a_is_zero || b_is_zero

  // 2. 输入冻结结界 (Operand Isolation Registers)
  // 核心机制：当 is_zero 为 true 时，不使能输入寄存器。
  // 这会把乘法器前一拍的非0输入"锁死"在阵列的入口，从而阻止内部巨大的组合逻辑全加树发生跳变！
  val a_isolated = RegEnable(io.a, !is_zero)
  val b_isolated = RegEnable(io.b, !is_zero)

  // 3. 例化 V3-0Bias 核心算子
  val core_multiplier = Module(new KMap_V3_Final_SchemeD())
  core_multiplier.io.a := a_isolated
  core_multiplier.io.b := b_isolated

  // 4. 时序对齐与旁路清零 (Mux Bypass)
  // 因为 a_isolated/b_isolated 相对 io.a/io.b 晚了一拍，
  // 为了确保外部看起来这是一个 "带 1 拍延迟" 的流水线乘法器，探测信号也必须打一拍。
  val is_zero_reg = RegNext(is_zero, init = false.B)
  
  // 获得核心跳变静止的旧值
  val prod_wire = core_multiplier.io.product
  
  // Mux 在最后一级切回真实结果 (0.S)
  // 综合器会将这个16bit的Mux放在最后，相较于 8x8 Wallace 阵列的开关功耗可以忽略不计。
  io.product := Mux(is_zero_reg, 0.S(16.W), prod_wire)
}

object GatedMultiplier extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new GatedMultiplier)
}
