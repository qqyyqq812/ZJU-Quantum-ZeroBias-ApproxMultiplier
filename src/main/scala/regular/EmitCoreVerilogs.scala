package regular

import chisel3.stage.ChiselStage

/**
 * ZBA-BM DAC 2026 Core Verilog Emitter
 * 
 * ==========================================================
 * 这份发射器只负责产生参与论文 PPA 评估的“纯血统” 5 大核心算子。
 * 所有历史遗留的 V1、V2 版本以及混血算子已被移入 archive/，
 * 不再经由该口统一生成，以防止 Verilog 产物区被污染。
 * ==========================================================
 * 
 * 执行指令: sbt "runMain regular.EmitCoreVerilogs"
 */
object EmitCoreVerilogs extends App {
  val targetDir = Array("-td", "generated_rtl")
  
  println(">>> [1/5] Generating StructuralExactBooth8...")
  (new ChiselStage).emitVerilog(new StructuralExactBooth8, targetDir)
  
  println(">>> [2/5] Generating KMap_V3_1Row_Approx...")
  (new ChiselStage).emitVerilog(new KMap_V3_1Row_Approx, targetDir)
  
  println(">>> [3/5] Generating KMap_V3_2Row_Approx...")
  (new ChiselStage).emitVerilog(new KMap_V3_2Row_Approx, targetDir)
  
  println(">>> [4/5] Generating KMap_V3_3Row_Approx...")
  (new ChiselStage).emitVerilog(new KMap_V3_3Row_Approx, targetDir)
  
  println(">>> [5/5] Generating KMap_V3_4Row_Approx (which is strictly V3_SchemeD)...")
  (new ChiselStage).emitVerilog(new KMap_V3_4Row_Approx, targetDir)
  (new ChiselStage).emitVerilog(new KMap_V3_Final_SchemeD, targetDir) // 皇冠版，功能等价于 4Row_Approx
  
  println("===================================================================")
  println(">>> SUCCESS! ALL 5 PURE V3 VERILOG FILES EMITTED TO generated_rtl/")
  println("===================================================================")
}
