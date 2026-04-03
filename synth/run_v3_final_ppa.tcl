# =========================================================================
# Authority PPA Synthesis — V3 Final Pareto Exploration
# Target:  Design Compiler (WSL2 Native)
# Library: NangateOpenCellLibrary 45nm
# Clock:   1.5 ns max_delay
# =========================================================================

set WORK_DIR "/home/qq/projects/approx-multiplier/synth"
cd $WORK_DIR

set search_path [list . ./rtl /home/qq/EDA/libraries/nangate45 $search_path]
set target_library "NangateOpenCellLibrary_typical.db"
set link_library   "* $target_library"

file mkdir reports_v3_final
file mkdir mapped_v3_final

set DESIGN_LIST { \
    "StructuralExactBooth8" \
    "KMap_V3_Final_SchemeD" \
}

foreach design $DESIGN_LIST {
    echo "=================================================================="
    echo ">>> Target: $design <<<"
    echo "=================================================================="
    
    remove_design -all

    analyze -format verilog "rtl/${design}.v"
    elaborate $design
    current_design $design
    
    link
    uniquify

    set_max_delay 1.5 -from [all_inputs] -to [all_outputs]
    set_max_area 0.0

    set_switching_activity -toggle_rate 0.15 \
                           -static_probability 0.3 \
                           [all_inputs]

    compile_ultra -no_autoungroup

    report_timing -path full -delay max -max_paths 1 \
        > "reports_v3_final/${design}_timing.rpt"
    
    report_area -hierarchy \
        > "reports_v3_final/${design}_area.rpt"
    
    report_power -analysis_effort medium \
        > "reports_v3_final/${design}_power.rpt"
    
    report_reference \
        > "reports_v3_final/${design}_reference.rpt"

    write -format verilog -hierarchy \
        -output "mapped_v3_final/${design}_mapped.v"

    echo "=== DONE: $design ==="
}
exit
