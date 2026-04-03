package regular

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers

class GatedMultiplierTest extends AnyFlatSpec with ChiselScalatestTester with Matchers {
  behavior of "GatedMultiplier"

  it should "freeze inputs when operands are zero and output zero" in {
    // 启用 Verilator 和波形输出，以便后续手动观察 Latch-Based Toggle 降低
    test(new GatedMultiplier).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.clock.setTimeout(0) // Disable timeout

      // 1. 正常计算周期 a=5, b=3
      dut.io.a.poke(5.U)
      dut.io.b.poke(3.U)
      dut.clock.step(1)
      val expected1 = 5 * 3
      println(s"expected1: $expected1, actual: ${dut.io.product.peek().litValue}")

      // 2. 正常计算周期 a=4, b=2
      dut.io.a.poke(4.U)
      dut.io.b.poke(2.U)
      dut.clock.step(1)
      val expected2 = 4 * 2
      println(s"expected2: $expected2, actual: ${dut.io.product.peek().litValue}")
      
      // 3. 产生 ZEROS: a=0, b=4 
      // 此时输入应该被锁存为上一拍的 a=4, b=2，但通过 MUX 输出必须为 0
      dut.io.a.poke(0.U)
      dut.io.b.poke(4.U)
      dut.clock.step(1)
      println(s"expected3: 0, actual: ${dut.io.product.peek().litValue}")
      dut.io.product.expect(0.S)

      // 继续喂 0，内部应当保持上一拍的 4 和 2
      dut.io.a.poke(7.U)
      dut.io.b.poke(0.U)
      dut.clock.step(1)
      println(s"expected4: 0, actual: ${dut.io.product.peek().litValue}")
      dut.io.product.expect(0.S)
      
      // 恢复正常打入
      dut.io.a.poke(3.U)
      dut.io.b.poke(3.U)
      dut.clock.step(1)
      val expected5 = 3 * 3
      println(s"expected5: $expected5, actual: ${dut.io.product.peek().litValue}")
    }
  }
}
