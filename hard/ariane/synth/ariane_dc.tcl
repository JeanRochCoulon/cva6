source -echo -verbose ../../../scripts/invia_scripts/synth/rm_flow/dc_setup.tcl

set clk_name main_clk
set clk_port clk_i
set clk_ports_list [list $clk_port]
set clk_period
set clk_waveform
set DESIGN_NAME_BIS

set RESULTS_FREQ_DIR $RESULTS_DIR/$clk_period/$DESIGN_NAME_BIS
file mkdir -p $RESULTS_FREQ_DIR
set REPORTS_FREQ_DIR $REPORTS_DIR/$clk_period/$DESIGN_NAME_BIS
file mkdir -p $REPORTS_FREQ_DIR

set_app_var search_path "../../../src/fpu/src/common_cells/include/ $search_path"

#################################################################################
# Read in the RTL Design
#
# Read in the RTL source files or read in the elaborated design (.ddc).
#################################################################################

report_lib

#define_design_lib WORK -path ./WORK
#analyze -format vhdl ${RTL_SOURCE_FILES}
source readsv_dc.tcl

if [info exist GENERIC_LIST] {
  elaborate ${DESIGN_NAME} -library $TOP_LIB -parameters $GENERIC_LIST
} else {
  elaborate ${DESIGN_NAME_BIS} -library $TOP_LIB
}

# OR

# You can read an elaborated design from the same release.
# Using an elaborated design from an older release will not give the best results.

# read_ddc ${DCRM_ELABORATED_DESIGN_DDC_OUTPUT_FILE}

uniquify
link

write -hierarchy -format ddc -output ${RESULTS_FREQ_DIR}/${DCRM_ELABORATED_DESIGN_DDC_OUTPUT_FILE}

###########################################################
# Change names
###########################################################
change_name -rule verilog -hier

#################################################################################
# Apply Additional Optimization Constraints
#################################################################################

# Prevent assignment statements in the Verilog netlist.
set_fix_multiple_port_nets -all -buffer_constants

#################################################################################
# Check for Design Problems 
#################################################################################

# Check the current design for consistency
check_design -summary

#################################################################################
# Compile the Design
#################################################################################

#** Set don't touch
source ./scripts/dc_set_dont_touch.tcl

#** Set critical range to 0.02 ns in $DESIGN_NAME"
#set_critical_range 0.02 $DESIGN_NAME

create_clock [get_ports $clk_port] -name $clk_name -period $clk_period -waveform $clk_waveform

#set_clock_uncertainty $clk_uncertainty [get_clocks $clk_name]

set_max_area 0
compile_ultra -no_boundary_optimization
#compile_ultra -spg -no_boundary_optimization
#compile

#################################################################################
# High-effort area optimization
#
# optimize_netlist -area command, was introduced in I-2013.12 release to improve
# area of gate-level netlists. The command performs monotonic gate-to-gate 
# optimization on mapped designs, thus improving area without degrading timing or
# leakage. 
#################################################################################

#optimize_netlist -area

#################################################################################
# Write Out Final Design and Reports
#
#        .ddc:   Recommended binary format used for subsequent Design Compiler sessions
#    Milkyway:   Recommended binary format for IC Compiler
#        .v  :   Verilog netlist for ASCII flow (Formality, PrimeTime, VCS)
#       .spef:   Topographical mode parasitics for PrimeTime
#        .sdf:   SDF backannotated topographical mode timing for PrimeTime
#        .sdc:   SDC constraints for ASCII flow
#
#################################################################################

change_names -rules verilog -hierarchy


#################################################################################
# Write out Design
#################################################################################

write -format verilog -hierarchy -output ${RESULTS_FREQ_DIR}/${DCRM_FINAL_VERILOG_OUTPUT_FILE}_tmp.v

write -format ddc     -hierarchy -output ${RESULTS_FREQ_DIR}/${DCRM_FINAL_DDC_OUTPUT_FILE}

# Write and close SVF file and make it available for immediate use
set_svf -off

#################################################################################
# Generate Final Reports
#################################################################################

report_timing -nworst 10  >  $REPORTS_FREQ_DIR/${DESIGN_NAME_BIS}_${TECH}_timings.log

report_area -hier -nosplit > $REPORTS_FREQ_DIR/${DCRM_FINAL_AREA_REPORT}


exit
