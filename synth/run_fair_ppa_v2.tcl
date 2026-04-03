# -------------------------------------------------------------------------
# 四版本 Ablation Study 综合评测脚本 (真实频率约束版)
# Target: Synopsys Design Compiler Ultra O-2018.06-SP1
# Goal: 放宽延时约束至 1.5ns (约 666MHz)，避免控制门海反噬，探查真实 PPA 红利
# -------------------------------------------------------------------------

set WORK_DIR "/home/ICer/approx_project/R4ABM2/nangate45"
cd $WORK_DIR

set search_path [list . ./rtl ./lib $search_path]
set target_library "NangateOpenCellLibrary_typical.db"
set link_library "* $target_library"
set symbol_library ""

file mkdir reports_v2
file mkdir mapped_v2

set compile_seqmac_identification false
set hdlin_keep_signal_name all

# === 核心的 4 级控制变量测试群 ===
# 1. 纯净基准
# 2. 裸奔近似版 (纯砍连线，无任何监工)
# 3. 掩码版 (只加少量与门监工)
# 4. 满血版 (含双重零值关断监工，用来看看在正常时钟下会不会反噬)
set DESIGN_LIST { \
    "StructuralExactBooth8" \
    "RegularBooth8_OnlyTrunc" \
    "RegularBooth8_BARC" \
    "RegularBooth8FullOpt" \
}

foreach design $DESIGN_LIST {
    echo "=========================================================="
    echo "▶▶▶ 开始编译与常规约束提纯: $design ◀◀◀"
    echo "=========================================================="
    
    remove_design -all

    analyze -format verilog "rtl/${design}.v"
    elaborate $design
    current_design $design
    
    link
    uniquify

    # === 【关键修改】：放宽后的真实时钟约束 ===
    # 不再使用 0.0ns 的极端压榨，改用 1.5ns 
    # 让综合器不用为了并行传播控制信号而疯狂生成海量的 AOI/OAI 复合门
    set_max_delay 1.5 -from [all_inputs] -to [all_outputs]
    set_max_area 0.0

    # 深度编译
    compile_ultra -flatten 

    # 抽取 4 项核心数据
    report_timing -path full -delay max -max_paths 1 > "reports_v2/${design}_timing_max.rpt"
    report_area -hierarchy -designware > "reports_v2/${design}_area.rpt"
    report_power > "reports_v2/${design}_power.rpt"
    report_reference > "reports_v2/${design}_reference.rpt"

    write -format verilog -hierarchy -output "mapped_v2/${design}_mapped.v"
    echo "✅ $design 靶机验证完毕。"
}

echo "=========================================================="
echo "🎯 4 级 Ablation Study 交叉综合完成！报告存放在 reports_v2/ 目录中。"
echo "=========================================================="
exit
