// =============================================================================
// RegularBooth8Test.scala - 正则布局融合乘法器测试
// =============================================================================

package regular

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class RegularBooth8Test extends AnyFlatSpec with ChiselScalatestTester {
  
  behavior of "RegularBooth8"

  // =========================================================================
  // 基础功能测试
  // =========================================================================
  
  it should "compute 0 * 0 = 0" in {
    test(new RegularBooth8) { dut =>
      dut.io.a.poke(0.U)
      dut.io.b.poke(0.U)
      dut.clock.step(1)
      dut.io.product.expect(0.S)
    }
  }

  it should "compute 1 * 1 = 1" in {
    test(new RegularBooth8) { dut =>
      dut.io.a.poke(1.U)
      dut.io.b.poke(1.U)
      dut.clock.step(1)
      dut.io.product.expect(1.S)
    }
  }

  it should "compute 127 * 127 = 16129" in {
    test(new RegularBooth8) { dut =>
      dut.io.a.poke(127.U)
      dut.io.b.poke(127.U)
      dut.clock.step(1)
      dut.io.product.expect(16129.S)
    }
  }

  // =========================================================================
  // 全遍历测试 (检测系统偏差)
  // =========================================================================
  
  it should "have zero mean error (Zero-Bias)" in {
    test(new RegularBooth8) { dut =>
      var totalError: Long = 0
      var errorCount: Int = 0
      
      for (a <- 0 until 256) {
        for (b <- 0 until 256) {
          // 转换为有符号数
          val a_signed = if (a >= 128) a - 256 else a
          val b_signed = if (b >= 128) b - 256 else b
          val expected = a_signed * b_signed
          
          dut.io.a.poke(a.U)
          dut.io.b.poke(b.U)
          dut.clock.step(1)
          
          val result = dut.io.product.peek().litValue.toInt
          val error = result - expected
          totalError += error
          
          if (error != 0) errorCount += 1
        }
      }
      
      val meanError = totalError.toDouble / 65536.0
      println(s"Total samples: 65536")
      println(s"Error count: $errorCount")
      println(s"Mean error: $meanError")
      
      // Zero-Bias 验证: 平均误差应接近 0
      assert(Math.abs(meanError) < 0.1, s"Non-zero bias detected: $meanError")
    }
  }

  // =========================================================================
  // 边界情况测试
  // =========================================================================
  
  it should "handle A=0 correctly (macro gating)" in {
    test(new RegularBooth8) { dut =>
      for (b <- Seq(0, 1, 127, 128, 255)) {
        dut.io.a.poke(0.U)
        dut.io.b.poke(b.U)
        dut.clock.step(1)
        dut.io.product.expect(0.S, s"A=0, B=$b should be 0")
      }
    }
  }

  it should "handle B=0 correctly (micro gating via 000/111)" in {
    test(new RegularBooth8) { dut =>
      for (a <- Seq(0, 1, 127, 128, 255)) {
        dut.io.a.poke(a.U)
        dut.io.b.poke(0.U)
        dut.clock.step(1)
        dut.io.product.expect(0.S, s"A=$a, B=0 should be 0")
      }
    }
  }

  it should "handle Row 0 encoding 100 (BARC test)" in {
    test(new RegularBooth8) { dut =>
      // b_extended[2:0] = 100 when B[1:0] = 10 (B=2 or B=-126)
      // B = 2 -> b = 00000010, b_extended = 00000010_0 -> enc0 = 100
      dut.io.a.poke(1.U)
      dut.io.b.poke(2.U)
      dut.clock.step(1)
      // 精确: 1 * 2 = 2
      dut.io.product.expect(2.S, "1 * 2 should be 2")
    }
  }

  // =========================================================================
  // 负数测试
  // =========================================================================
  
  it should "handle negative numbers" in {
    test(new RegularBooth8) { dut =>
      // -1 * -1 = 1
      dut.io.a.poke(255.U)  // -1 in 2's complement
      dut.io.b.poke(255.U)
      dut.clock.step(1)
      dut.io.product.expect(1.S)
      
      // -128 * 1 = -128
      dut.io.a.poke(128.U)  // -128
      dut.io.b.poke(1.U)
      dut.clock.step(1)
      dut.io.product.expect(-128.S)
      
      // -128 * -1 = 128
      dut.io.a.poke(128.U)
      dut.io.b.poke(255.U)
      dut.clock.step(1)
      dut.io.product.expect(128.S)
    }
  }
}
