set WORK_DIR "/home/ICer/approx_project/R4ABM2/nangate45"
cd $WORK_DIR

set search_path [list . ./rtl ./lib ./rtl_v3_exp $search_path]
set target_library "NangateOpenCellLibrary_typical.db"
set link_library "* $target_library"
set symbol_library ""

foreach DESIGN_NAME {"KMap_V3_Exp1_BaseNoZG" "KMap_V3_Exp2_EmbeddedSchemeD"} {
    read_file -format verilog "./rtl_v3_exp/${DESIGN_NAME}.v"
    current_design $DESIGN_NAME
    link

    # 时钟约束 1.5ns (极限性能测试)
    create_clock -name clk -period 1.5
    set_max_area 0

    compile_ultra

    report_area > "./rtl_v3_exp/${DESIGN_NAME}_area.rpt"
    report_power > "./rtl_v3_exp/${DESIGN_NAME}_power.rpt"
    report_timing > "./rtl_v3_exp/${DESIGN_NAME}_timing.rpt"
    
    remove_design -designs
}
exit
