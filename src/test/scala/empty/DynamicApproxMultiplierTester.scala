package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class DynamicApproxMultiplierTester extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "DynamicApproxMultiplier"

  it should "compute exact multiplication correctly when level = 0" in {
    test(new DynamicApproxMultiplier) { dut =>
      dut.io.approx_level.poke(0.U) // Level 0: Exact Mode

      // Test corner cases
      val cases = Seq(
        (0, 0), (1, 1), (-1, -1), (127, 127), (-128, -128),
        (127, -128), (-128, 127), (0, -1), (-1, 0)
      )

      for ((a, b) <- cases) {
        dut.io.multiplicand.poke(a.S)
        dut.io.multiplier.poke(b.S)
        dut.clock.step()
        
        val expected = a * b
        dut.io.product.expect(expected.S, s"Expected $a * $b = $expected")
      }

      // Test random values
      val r = new Random(42)
      for (_ <- 0 until 100) {
        val a = r.nextInt(256) - 128
        val b = r.nextInt(256) - 128
        dut.io.multiplicand.poke(a.S)
        dut.io.multiplier.poke(b.S)
        dut.clock.step()
        
        val expected = a * b
        dut.io.product.expect(expected.S, s"Expected $a * $b = $expected")
      }
    }
  }

  it should "produce different results for different approximation levels" in {
    test(new DynamicApproxMultiplier) { dut =>
      // Pick inputs that trigger 2A usage
      // 6 = 00000110. Booth: 
      // i=0 (1,0,-1) -> 100 (-2). USES 2A.
      // i=1 (3,2,1) -> 011 (+2). USES 2A.
      
      val a = 100
      val b = 6 
      
      dut.io.multiplicand.poke(a.S)
      dut.io.multiplier.poke(b.S)
      
      // Level 0: Exact
      // 6 * 100 = 600
      dut.io.approx_level.poke(0.U)
      dut.clock.step()
      dut.io.product.expect(600.S, "Level 0 should be exact (600)")

      // Level 1: Row 0 Approx
      // Row 0 (-2A) becomes -A (since 2A disabled, but -A remains).
      //   -A = -100.
      // Row 1 (+2A) stays +2A -> +2A << 2 = +8A = 800.
      // Total = 800 - 100 = 700.
      dut.io.approx_level.poke(1.U)
      dut.clock.step()
      dut.io.product.expect(700.S, "Level 1 (Row 0 approx) should yield 700 for 6*100")
      
      // Level 2: Row 0,1 Approx
      // Row 0 -> -A (-100).
      // Row 1 -> +A (since 2A disabled). +A << 2 = +4A = 400.
      // Total = 400 - 100 = 300.
      dut.io.approx_level.poke(2.U)
      dut.clock.step()
      dut.io.product.expect(300.S, "Level 2 (Row 0,1 approx) should yield 300 for 6*100")
    }
  }

  it should "support dynamic switching of levels during operation" in {
    test(new DynamicApproxMultiplier) { dut =>
      // Use 6 * 100 again for switching test
      dut.io.multiplicand.poke(100.S)
      dut.io.multiplier.poke(6.S)
      
      // Cycle 0: Level 0 -> 600
      dut.io.approx_level.poke(0.U)
      dut.clock.step()
      dut.io.product.expect(600.S)
      
      // Cycle 1: Level 2 -> 300
      dut.io.approx_level.poke(2.U)
      dut.clock.step()
      dut.io.product.expect(300.S)
      
      // Cycle 2: Level 1 -> 700
      dut.io.approx_level.poke(1.U)
      dut.clock.step()
      dut.io.product.expect(700.S)
    }
  }
}
