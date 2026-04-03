# -------------------------------------------------------------------------
# Phase FINAL: 论文核心 PPA 消融综合 (Nangate 45nm)
# Target: Synopsys Design Compiler Ultra O-2018.06-SP1
# 约束: 1.5ns (与 Step 1/2 保持一致)
# 模板来源: run_step2_ppa.tcl (已验证可跑通)
# -------------------------------------------------------------------------

set WORK_DIR "/home/ICer/approx_project/R4ABM2/nangate45"
cd $WORK_DIR

set search_path [list . ./rtl_paper_final ./lib $search_path]
set target_library "NangateOpenCellLibrary_typical.db"
set link_library "* $target_library"
set symbol_library ""

file mkdir reports_paper_final
file mkdir mapped_paper_final

set compile_seqmac_identification false
set hdlin_keep_signal_name all

# 论文四大变体
set DESIGN_LIST { \
    "StructuralExactBooth8" \
    "KMap_4Row_ZG_EmbeddedNeg" \
    "KMap_4Row_ZG_EmbeddedNeg_BARC" \
    "KMap_V3_Final_SchemeD" \
}

foreach design $DESIGN_LIST {
    echo "=========================================================="
    echo "▶▶▶ PPA Authority 综合打榜: $design ◀◀◀"
    echo "=========================================================="
    
    remove_design -all

    analyze -format verilog "rtl_paper_final/${design}.v"
    elaborate $design
    current_design $design
    
    link
    uniquify

    set_max_delay 1.5 -from [all_inputs] -to [all_outputs]
    set_max_area 0.0

    compile_ultra -flatten 

    report_timing -path full -delay max -max_paths 1 > "reports_paper_final/${design}_timing_max.rpt"
    report_area -hierarchy -designware > "reports_paper_final/${design}_area.rpt"
    report_power > "reports_paper_final/${design}_power.rpt"
    report_reference > "reports_paper_final/${design}_reference.rpt"

    write -format verilog -hierarchy -output "mapped_paper_final/${design}_mapped.v"
    echo "✅ $design 综合完毕。"
}

echo "=========================================================="
echo "🎯 Paper 级对比组综合完成！报告存放在 reports_paper_final/。"
echo "=========================================================="
exit
