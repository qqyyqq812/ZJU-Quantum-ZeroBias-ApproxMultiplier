package empty

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

/**
 * 动态精度可配置 R4ABM2 乘法器 (DynamicApproxMultiplier)
 * 
 * 整合了原有的 R4ABE2, PartialProductGenerator, ApproxWallaceTree 模块。
 * 新增 io.approx_level 接口，支持运行时动态切换近似程度。
 * 
 * 设计目标：
 * 满足 "动态精度重构架构" 的需求，允许上层控制器根据神经网络层级敏感度
 * 动态调整乘法器的精度/能效权衡。
 */

// ============================================================================
// 1. R4ABE2_Dynamic (动态 Booth 编码器)
// ============================================================================
/**
 * R4ABE2_Dynamic: 支持动态切换精度的 Radix-4 Booth 编码器
 * 
 * update: 
 * - 移除 val isApprox 参数，改为 io.is_approx 输入信号。
 * - 内部逻辑使用 Mux 根据 io.is_approx 实时切换行为。
 */
class R4ABE2_Dynamic extends Module {
  val io = IO(new Bundle {
    val b_bits    = Input(UInt(3.W)) // {b_{i+1}, b_i, b_{i-1}}
    val is_approx = Input(Bool())    // [NEW] 动态控制信号：是否开启近似模式
    
    val negate    = Output(Bool())   // 取反信号
    val zero      = Output(Bool())   // 置零信号
    val two       = Output(Bool())   // 2倍信号
  })

  // 1. Negate: 无论近似与否，由最高位决定 (MSB)
  io.negate := io.b_bits(2)
  
  // 2. Zero: 无论近似与否，000(0) 或 111(0) 都视为零
  // (原代码中近似模式和精确模式对此处理一致)
  io.zero   := (io.b_bits === 0.U) || (io.b_bits === 7.U)
  
  // 3. Two: 动态切换
  // 精确模式: 011(2), 100(-2) -> two=1
  // 近似模式: 忽略 2A 信号 (two=0) 以简化 PPG 逻辑
  val two_exact = (io.b_bits === 3.U) || (io.b_bits === 4.U)
  io.two := Mux(io.is_approx, false.B, two_exact)
}

// ============================================================================
// 2. PartialProductGenerator (部分积生成器)
// ============================================================================
/**
 * PartialProductGenerator
 * 保持不变，负责根据 negate 信号生成 +A 或 -A。
 * 2A 的移位通过外部 logic 实现。
 */
class PartialProductGenerator extends Module {
  val io = IO(new Bundle {
    val a               = Input(SInt(8.W))  // 被乘数 A
    val negate          = Input(Bool())     // 来自 R4ABE2 的取反信号
    val partial_product = Output(SInt(9.W))
  })

  // 必须先扩展到 9 位再取反，防止 -128 (8-bit) 取反溢出仍为 -128
  val a_ext = Wire(SInt(9.W))
  a_ext := io.a
  
  // Mux(条件, a, b) -> 如果条件为真，返回 -A，否则返回 +A
  io.partial_product := Mux(io.negate, -a_ext, a_ext)
}

// ============================================================================
// 3. ApproxWallaceTree (近似/精确通用累加树)
// ============================================================================
/**
 * ApproxWallaceTree
 * 保持不变，是一个精确的 CSA/Wallace 树结构。
 * 近似性体现在输入的 partial_products 已经包含了近似误差。
 */
class ApproxWallaceTree extends Module {
  val io = IO(new Bundle {
    val shifted_partial_products = Input(Vec(4, SInt(16.W)))
    val final_product            = Output(SInt(16.W))
  })

  // 使用 reduceTree efficient summation
  io.final_product := io.shifted_partial_products.reduceTree(_ +& _)
}

// ============================================================================
// 4. DynamicApproxMultiplier (顶层动态乘法器)
// ============================================================================
/**
 * DynamicApproxMultiplier
 * 
 * 整合所有子模块，并添加全局控制逻辑。
 * 
 * io.approx_level (2-bit):
 *  0 (00): 全精确模式 (Exact) - 等效于标准 Booth Multiplier
 *  1 (01): 低近似度 (Row 0 近似)
 *  2 (10): 中近似度 (Row 0, 1 近似) - 等效于经典 R4ABM2
 *  3 (11): 高近似度 (Row 0, 1, 2 近似)
 */
class DynamicApproxMultiplier extends Module {
  val io = IO(new Bundle {
    val multiplicand = Input(SInt(8.W))  // A
    val multiplier   = Input(SInt(8.W))  // B
    val approx_level = Input(UInt(2.W))  // [NEW] 精度控制级别 (0-3)
    val product      = Output(SInt(16.W)) // P
  })

  // 1. 扩展乘数 B (补0方便Booth编码)
  val b_extended = Cat(io.multiplier, 0.U(1.W))

  // 2. 实例化子模块
  val encoders = Seq.fill(4)(Module(new R4ABE2_Dynamic))
  val ppgs     = Seq.fill(4)(Module(new PartialProductGenerator))
  
  val partial_products = Wire(Vec(4, SInt(16.W)))

  // 全局 A 端零值检测 (用于优化和防止 -1 噪声)
  val a_is_zero = (io.multiplicand === 0.S)

  // [NEW] 解码 approx_level 为每行的近似控制信号
  // row_is_approx(i) 为 true 表示第 i 行启用近似模式
  val row_is_approx = Wire(Vec(4, Bool()))
  
  // 简单的阈值控制逻辑: level n 意味着前 n 行近似
  // Level 0: 0000 (Exact)
  // Level 1: 0001 (Row 0 approx)
  // Level 2: 0011 (Row 0,1 approx)
  // Level 3: 0111 (Row 0,1,2 approx)
  for (i <- 0 until 4) {
    row_is_approx(i) := (i.U < io.approx_level)
  }

  for (i <- 0 until 4) {
    // === 连接 Encoder ===
    encoders(i).io.b_bits    := b_extended(2 * i + 2, 2 * i)
    encoders(i).io.is_approx := row_is_approx(i)  // [NEW] 动态连线

    // === 连接 PPG ===
    ppgs(i).io.a      := io.multiplicand
    ppgs(i).io.negate := encoders(i).io.negate
    
    // === 处理部分积逻辑 ===
    // 1. Zero Gating Check
    // row_is_zero 条件: Encoder检测到B为0/7，或者输入A为0
    val row_is_zero = encoders(i).io.zero || a_is_zero

    // 2. 获取 PPG 输出 (+A/-A)
    val pp_raw = ppgs(i).io.partial_product

    // 3. 处理 2*A (依赖 encoder.two)
    // 如果是近似模式，encoder.two 自动为 false，所以这里逻辑通用
    // 需使用 10 位以容纳 2*A (最大 +256)
    val pp_signed = Wire(SInt(10.W))
    pp_signed := Mux(encoders(i).io.two, (pp_raw << 1).asSInt, pp_raw)

    // 4. Zero Gating 应用
    val pp_gated = Wire(SInt(10.W))
    pp_gated := Mux(row_is_zero, 0.S.asSInt, pp_signed)

    // 5. 符号扩展到 16 位
    val pp_extended = Wire(SInt(16.W))
    pp_extended := pp_gated.asSInt

    // 6. 修正位 (Correction Bit)
    // 修正: PPG 内部已经使用了算术取反 (-io.a)，这已经是 2's complement。
    // 因此不需要额外的 +1 修正。原代码中的 (+1) 逻辑是冗余且错误的（针对 arithmetic neg 而言）。
    // 我们将 correction_bit 永久置为 0，或者直接从加法中移除。
    val correction_bit = 0.S(16.W)

    // 7. 计算最终移位部分积
    partial_products(i) := (pp_extended << (2 * i)).asSInt + (correction_bit << (2 * i)).asSInt
  }

  // 3. 累加树求和
  val wallace_tree = Module(new ApproxWallaceTree)
  wallace_tree.io.shifted_partial_products := partial_products
  io.product := wallace_tree.io.final_product
}

// 生成 Verilog 的 Wrapper
object DynamicApproxMultiplier extends App {
  println("Generating Verilog for DynamicApproxMultiplier...")
  new ChiselStage().emitVerilog(
    new DynamicApproxMultiplier,
    Array("--target-dir", "verilog_output")
  )
}
