package regular

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.io.{File, PrintWriter}

class ExtractLUT_MixedVariants extends AnyFlatSpec with ChiselScalatestTester {
  
  def doExtract(name: String, dut: Any, getA: () => UInt, getB: () => UInt, getProduct: () => SInt, stepClock: () => Unit): Unit = {
      val pw = new PrintWriter(new File(s"/home/qq/projects/adapt/adapt/cpu-kernels/axx_mults/$name.h"))
      pw.println("#include <stdint.h>")
      pw.println("")
      pw.println(s"// Extracted physically from Chisel RTL for $name")
      pw.println("const int16_t lut[256][256] = {")
      
      var totalErr: Long = 0
      for (a <- 0 until 256) {
        val rowVals = new collection.mutable.ArrayBuffer[String]()
        for (b <- 0 until 256) {
          getA().poke(a.U)
          getB().poke(b.U)
          stepClock()
          val res = getProduct().peek().litValue.toInt
          
          val as = if (a >= 128) a - 256 else a
          val bs = if (b >= 128) b - 256 else b
          var exact = as * bs
          if (exact > 32767) exact = 32767
          if (exact < -32768) exact = -32768
          totalErr += Math.abs(res - exact) // accumulate absolute errors
          
          rowVals += res.toString
        }
        val line = "    {" + rowVals.mkString(", ") + "}" + (if (a == 255) "" else ",")
        pw.println(line)
      }
      pw.println("};")
      pw.close()
      println(s"LUT for $name generated. Mean Error: ${totalErr / 65536.0}")
  }

  behavior of "LUT Extractor"

  it should "extract KMap_1Row_Approx" in {
    test(new KMap_1Row_Approx) { dut =>
      doExtract("KMap_1Row_Approx", dut, () => dut.io.a, () => dut.io.b, () => dut.io.product, () => dut.clock.step(1))
    }
  }

  it should "extract KMap_2Row_Approx" in {
    test(new KMap_2Row_Approx) { dut =>
      doExtract("KMap_2Row_Approx", dut, () => dut.io.a, () => dut.io.b, () => dut.io.product, () => dut.clock.step(1))
    }
  }

  it should "extract KMap_3Row_Approx" in {
    test(new KMap_3Row_Approx) { dut =>
      doExtract("KMap_3Row_Approx", dut, () => dut.io.a, () => dut.io.b, () => dut.io.product, () => dut.clock.step(1))
    }
  }
}
