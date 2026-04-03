# -------------------------------------------------------------------------
# Phase E: 卡诺图 (K-Map) 布尔坍塌终局认证脚本 
# Target: Synopsys Design Compiler Ultra O-2018.06-SP1
# 约束: 1.5ns (常规时序)
# 目的: 用于验证剥离 Booth Encoder 后纯布尔网络的极限面积红利
# -------------------------------------------------------------------------

set WORK_DIR "/home/ICer/approx_project/R4ABM2/nangate45"
cd $WORK_DIR

set search_path [list . ./rtl ./lib $search_path]
set target_library "NangateOpenCellLibrary_typical.db"
set link_library "* $target_library"
set symbol_library ""

file mkdir reports_kmap
file mkdir mapped_kmap

set compile_seqmac_identification false
set hdlin_keep_signal_name all

# 只比对基准版与 K-Map 极致坍塌版
set DESIGN_LIST { \
    "StructuralExactBooth8" \
    "RegularBooth8_KMapTrunc" \
}

foreach design $DESIGN_LIST {
    echo "=========================================================="
    echo "▶▶▶ K-Map 终局对撞开启: $design ◀◀◀"
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

    report_timing -path full -delay max -max_paths 1 > "reports_kmap/${design}_timing_max.rpt"
    report_area -hierarchy -designware > "reports_kmap/${design}_area.rpt"
    report_power > "reports_kmap/${design}_power.rpt"
    report_reference > "reports_kmap/${design}_reference.rpt"

    write -format verilog -hierarchy -output "mapped_kmap/${design}_mapped.v"
    echo "✅ K-Map 靶机 $design 验证完毕。"
}

echo "=========================================================="
echo "🎯 K-Map 卡诺图坍塌对撞完成！报告存放在 reports_kmap/。"
echo "=========================================================="
exit
