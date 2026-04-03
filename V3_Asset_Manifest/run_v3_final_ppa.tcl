set WORK_DIR "/home/ICer/approx_project/R4ABM2/nangate45"
cd $WORK_DIR
set search_path [list . ./rtl ./lib $search_path]

set target_library "NangateOpenCellLibrary_typical.db"
set link_library "* $target_library"

set DESIGN_NAME KMap_V3_Final_SchemeD

read_file -format verilog "./rtl_v3_final/${DESIGN_NAME}.v"
current_design $DESIGN_NAME
link

# 时钟约束 1.5ns (极限性能测试)
create_clock -name clk -period 1.5
set_max_area 0

# Ultra 高级综合开启，赋予 Flatten 扁平化权限，验证 Naive 拼接算法威力
compile_ultra -flatten

report_area > "./rtl_v3_final/${DESIGN_NAME}_area.rpt"
report_power > "./rtl_v3_final/${DESIGN_NAME}_power.rpt"
report_timing > "./rtl_v3_final/${DESIGN_NAME}_timing.rpt"

exit
