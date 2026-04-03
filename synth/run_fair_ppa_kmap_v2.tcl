# -------------------------------------------------------------------------
# Phase E2: K-Map 极限异或终局 (PZ保零版 vs EX极小版) 
# Target: Synopsys Design Compiler Ultra O-2018.06-SP1
# 约束: 1.5ns (常规时序)
# 目的: 用于验证一根异或门带来的绝对物理断崖
# -------------------------------------------------------------------------

set WORK_DIR "/home/ICer/approx_project/R4ABM2/nangate45"
cd $WORK_DIR

set search_path [list . ./rtl ./lib $search_path]
set target_library "NangateOpenCellLibrary_typical.db"
set link_library "* $target_library"
set symbol_library ""

file mkdir reports_kmap_v2
file mkdir mapped_kmap_v2

set compile_seqmac_identification false
set hdlin_keep_signal_name all

set DESIGN_LIST { \
    "StructuralExactBooth8" \
    "RegularBooth8_KMap_PZ" \
    "RegularBooth8_KMap_EX" \
}

foreach design $DESIGN_LIST {
    echo "=========================================================="
    echo "▶▶▶ K-Map 异或对撞开启: $design ◀◀◀"
    echo "=========================================================="
    
    remove_design -all

    analyze -format verilog "rtl/${design}.v"
    elaborate $design
    current_design $design
    
    link
    uniquify

    set_max_delay 1.5 -from [all_inputs] -to [all_outputs]
    set_max_area 0.0

    compile_ultra -flatten 

    report_timing -path full -delay max -max_paths 1 > "reports_kmap_v2/${design}_timing_max.rpt"
    report_area -hierarchy -designware > "reports_kmap_v2/${design}_area.rpt"
    report_power > "reports_kmap_v2/${design}_power.rpt"
    report_reference > "reports_kmap_v2/${design}_reference.rpt"

    write -format verilog -hierarchy -output "mapped_kmap_v2/${design}_mapped.v"
    echo "✅ 靶机 $design 验证完毕。"
}

echo "=========================================================="
echo "🎯 PZ vs EX 对撞完成！报告存放在 reports_kmap_v2/。"
echo "=========================================================="
exit
