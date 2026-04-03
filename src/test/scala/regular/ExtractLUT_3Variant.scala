package regular

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import regular.step2_neg_embedding._
import regular.step3_barc_compensation._
import java.io.{File, PrintWriter}

class ExtractLUT_3Variant extends AnyFlatSpec with ChiselScalatestTester {
  
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
          totalErr += (res - exact)
          
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

  it should "extract KMap_4Row_ZG_EmbeddedNeg" in {
    test(new KMap_4Row_ZG_EmbeddedNeg) { dut =>
      doExtract("KMap_4Row_ZG_EmbeddedNeg", dut, () => dut.io.a, () => dut.io.b, () => dut.io.product, () => dut.clock.step(1))
    }
  }

  it should "extract KMap_4Row_ZG_EmbeddedNeg_BARC" in {
    test(new KMap_4Row_ZG_EmbeddedNeg_BARC) { dut =>
      doExtract("KMap_4Row_ZG_EmbeddedNeg_BARC", dut, () => dut.io.a, () => dut.io.b, () => dut.io.product, () => dut.clock.step(1))
    }
  }

  it should "extract KMap_V3_Final_SchemeD" in {
    test(new KMap_V3_Final_SchemeD) { dut =>
      doExtract("KMap_V3_Final_SchemeD", dut, () => dut.io.a, () => dut.io.b, () => dut.io.product, () => dut.clock.step(1))
    }
  }
}
