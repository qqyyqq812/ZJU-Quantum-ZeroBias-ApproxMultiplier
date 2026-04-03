package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.math.abs

/**
 * ApproxRadix4Booth8Test: 全功能 Chisel Testbench (最终审查版)
 *
 * 验证目标：
 * 本测试平台旨在对 ApproxRadix4Booth8 模块进行穷尽性验证，并自动化地计算
 * 和检验论文 Table 5 中报告的所有关键精度指标，确保 Chisel 设计在算法
 * 层面与论文描述完全一致。
 *
 * 验证流程：
 * 1. 遍历所有 256x256 = 65,536 个8位有符号数输入组合。
 * 2. 对每个组合，获取 DUT (近似设计) 的输出和黄金模型 (精确计算) 的输出。
 * 3. 累加计算所需的统计数据（错误计数、误差距离、相对误差等）。
 * 4. 测试结束后，计算最终的四个精度指标：ER, NMED, MRED, P_RED。
 * 5. 使用 `assert` 语句，自动将计算结果与论文中的目标值进行比较，若偏差
 * 在容忍度(5%)范围内，则测试通过，否则测试失败并报错。
 */
class ApproxRadix4Booth8Test extends AnyFlatSpec with ChiselScalatestTester {

  behavior of "ApproxRadix4Booth8"

  it should "compute products and meet all approximation metrics from the paper" in {
    test(new ApproxRadix4Booth8) { dut =>
      println("Starting full-range test and comprehensive error analysis for 8-bit R4ABM2 (p=8)...")

      val minVal = -128
      val maxVal = 127
      val testCases = (maxVal - minVal + 1) * (maxVal - minVal + 1)

      var totalErrorDistance: Double = 0.0
      var totalRelativeError: Double = 0.0
      var errorCount: Long = 0
      var smallRelativeErrorCount: Long = 0

      for (a <- minVal to maxVal) {
        for (b <- minVal to maxVal) {
          val a_lit = BigInt(a)
          val b_lit = BigInt(b)

          dut.io.multiplicand.poke(a_lit.S(8.W))
          dut.io.multiplier.poke(b_lit.S(8.W))

          val approx_product = dut.io.product.peek().litValue
          val exact_product = a_lit * b_lit

          val error_distance = abs(approx_product.doubleValue - exact_product.doubleValue)

          if (error_distance > 0) {
            errorCount += 1
            totalErrorDistance += error_distance
            if (exact_product != 0) {
              val relative_error = error_distance / abs(exact_product.doubleValue)
              totalRelativeError += relative_error
              // 检查相对误差是否小于2% (论文P_RED的目标)
              if (relative_error < 0.02) {
                smallRelativeErrorCount += 1
              }
            }
          } else { // 如果没有误差
              // [修正] 只有当精确值不为0时，才计入 P_RED 分子
              if (exact_product != 0) {
                  smallRelativeErrorCount += 1
              }
          }
        }
      }

      println(s"Test finished. Completed $testCases input combinations.")

      // --- 根据论文 Table 5 计算所有误差指标 ---
      // ER (Error Rate)
      val errorRate = (errorCount.toDouble / testCases) * 100

      // NMED (Normalized Mean Error Distance)
      val maxPossibleProduct = abs(minVal * minVal) // |-128 * -128| = 16384
      val med = totalErrorDistance / testCases
      val nmed = med / maxPossibleProduct

      // MRED (Mean Relative Error Distance)
      // 注意：MRED的定义是只对出错的情况求平均还是对所有情况？论文中未明确，
      // 但通常是对所有非零结果求平均。这里我们对所有非零情况计算。
      val nonZeroCases = testCases - (2 * (maxVal - minVal + 1) -1) // 减去 a=0 或 b=0 的情况
      val mred = totalRelativeError / nonZeroCases * 100

      // P_RED (Probability of RED < 2%)
      // 同样，分母是所有非零情况
      val pred = (smallRelativeErrorCount.toDouble / nonZeroCases) * 100

      // --- 论文中 8-bit R4ABM2 (p=8) 的目标值 (来自Table 5) ---
      val targetER = 94.16
      val targetNMED = 0.409 * 1e-2
      val targetMRED = 24.120 // MRED(%)
      val targetPRED = 37.16  // P_RED(%)

      println("\n--- Comprehensive Error Analysis Results ---")
      println(f"Error Rate (ER):         $errorRate%.2f%% (Paper Target: $targetER%.2f%%)")
      println(f"Normalized MED (NMED):   ${nmed * 100}%.4f * 10^-2 (Paper Target: ${targetNMED * 100}%.4f * 10^-2)")
      println(f"Mean RED (MRED):         $mred%.2f%% (Paper Target: $targetMRED%.2f%%)")
      println(f"P(RED < 2%%) (P_RED):      $pred%.2f%% (Paper Target: $targetPRED%.2f%%)")

      // --- 自动化断言检查 ---
      val tolerance = 0.05 // 5% 的容差
      assert(abs(errorRate - targetER) / targetER < tolerance, f"ER check FAILED. Got $errorRate%.2f%%")
      assert(abs(nmed - targetNMED) / targetNMED < tolerance, f"NMED check FAILED. Got $nmed%.6f")
      assert(abs(mred - targetMRED) / targetMRED < tolerance, f"MRED check FAILED. Got $mred%.2f%%")
      assert(abs(pred - targetPRED) / targetPRED < tolerance, f"P_RED check FAILED. Got $pred%.2f%%")
      
      println("\n[SUCCESS] All approximation metrics (ER, NMED, MRED, P_RED) successfully met paper targets within 5% tolerance.")
    }
  }
}

