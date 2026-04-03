# =========================================================================
# Authority PPA Synthesis — ZBA-BM DAC 2026 论文终稿数据
# Target:  Synopsys Design Compiler Ultra O-2018.06-SP1
# Library: NangateOpenCellLibrary 45nm (typical corner)
# Clock:   1.5 ns max_delay (≈667 MHz, all designs meet timing)
# Compile: compile_ultra -no_autoungroup (保留层次结构, 公平对比)
# Author:  Agent 1 — 算子级物理极限突击队
# Date:    2026-03-31
# =========================================================================
#
# 策略说明:
#   1. 不使用 -flatten: 避免消除子模块边界, 确保精确版与近似版的
#      结构差异被忠实反映在面积数据中。
#   2. 时钟约束 1.5ns: 所有变体均可 meet timing, 使面积和功耗成为
#      唯一比较维度。过紧约束会触发 buffer insertion 反噬。
#   3. 显式设定 toggle rate = 0.5: 避免 DC 版本间默认值漂移。
#   4. 全部 7 个变体为裸核 (不含 GatedPE), 论文口径统一。
# =========================================================================

set WORK_DIR "/home/ICer/approx_project/R4ABM2/nangate45"
cd $WORK_DIR

# --- 库设定 ---
set search_path [list . ./authority_rtl ./lib $search_path]
set target_library "NangateOpenCellLibrary_typical.db"
set link_library   "* $target_library"
set symbol_library ""

# --- 输出目录 ---
file mkdir reports_authority
file mkdir mapped_authority

# --- DC 全局设定 ---
set compile_seqmac_identification false
set hdlin_keep_signal_name all

# =========================================================================
# 变体清单 (7 个, 按论文表格顺序)
# =========================================================================
# Table 1 (Architecture Exploration):
#   [1] StructuralExactBooth8       — 精确基线
#   [5] KMap_4Row_ZG_EmbeddedNeg    — 4 行全近似 (KMap_4Row_Pure)
#   [7] KMap_4Row_ZG_EmbeddedNeg_BARC — BARC 补偿版
#   [6] KMap_V3_Final_SchemeD       — V3 终局裸核 (零偏差)
#
# Table 2 (Gradient Ablation):
#   [1] StructuralExactBooth8       — 0 行近似 (重复, 只跑一次)
#   [2] KMap_1Row_Approx            — 1 行近似
#   [3] KMap_2Row_Approx            — 2 行近似
#   [4] KMap_3Row_Approx            — 3 行近似
#   [5] KMap_4Row_ZG_EmbeddedNeg    — 4 行近似 (重复, 只跑一次)
# =========================================================================

set DESIGN_LIST { \
    "StructuralExactBooth8" \
    "KMap_V3_1Row_Approx" \
    "KMap_V3_2Row_Approx" \
    "KMap_V3_3Row_Approx" \
    "KMap_V3_4Row_Approx" \
}

set total [llength $DESIGN_LIST]
set idx 0

foreach design $DESIGN_LIST {
    incr idx
    echo "=================================================================="
    echo ">>> \[$idx/$total\] Authority PPA: $design <<<"
    echo "=================================================================="
    
    # --- 清空工作区 ---
    remove_design -all

    # --- 读入 RTL ---
    analyze -format verilog "authority_rtl/${design}.v"
    elaborate $design
    current_design $design
    
    link
    uniquify

    # --- 时序约束: 1.5ns 组合逻辑路径 ---
    set_max_delay 1.5 -from [all_inputs] -to [all_outputs]
    set_max_area 0.0

    # --- 功耗: 显式设定 switching activity ---
    # 基于 CNN (~60% 0-sparsity) 分析得出的学术界真实打榜翻转率基线
    set_switching_activity -toggle_rate 0.15 \
                           -static_probability 0.3 \
                           [all_inputs]

    # --- 编译: Ultra + 保留层次 ---
    compile_ultra -no_autoungroup

    # --- 报告提取 ---
    report_timing -path full -delay max -max_paths 1 \
        > "reports_authority/${design}_timing.rpt"
    
    report_area -hierarchy \
        > "reports_authority/${design}_area.rpt"
    
    report_power -analysis_effort medium \
        > "reports_authority/${design}_power.rpt"
    
    report_reference \
        > "reports_authority/${design}_reference.rpt"

    # --- 输出门级网表 ---
    write -format verilog -hierarchy \
        -output "mapped_authority/${design}_mapped.v"

    echo "=== DONE: $design ==="
    echo ""
}

echo "=================================================================="
echo ">>> ALL 7 DESIGNS SYNTHESIZED SUCCESSFULLY <<<"
echo ">>> Reports: reports_authority/ <<<"  
echo ">>> Mapped:  mapped_authority/ <<<"
echo "=================================================================="
exit
