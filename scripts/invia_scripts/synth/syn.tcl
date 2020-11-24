# ------------------------------------------------------------------------------
#-                                                                            --
#-                      Copyright (C) 2010-2014 INVIA                         --
#-                                                                            --
#-   All rights reserved. Reproduction in whole or part is prohibited         --
#-      without the written permission of the copyright owner                 --
#-                                                                            --
#-------------------------------------------------------------------------------
#- Author: N. VALETTE - INVIA
#- Revision :
#- Date     :
#- Description: TCL file used to launch dc_shell
#-------------------------------------------------------------------------------
#- PLEASE KEEP THIS FILE READABLE
#-------------------------------------------------------------------------------


echo ""
echo -n ' ****** STARTING Synthesis at ' 
sh date
echo ""

# Using many cores
set_host_options -max_cores 2

# Set default value
set always_ungroup 0
set clk_name main_clk
set clk_port clk
set clk_ports_list [list $clk_port]
set clk_uncertainty 0.1
set clk_period 40
set clk_waveform {0 20}
#Use only the top name on the style rather than along with the parameters
set template_naming_style "%s"

echo "** Define output verilog rules"
#set verilogout_single_bit true
define_name_rules verilog \
    -target_bus_naming_style "%s\[%d\]" \
    -allowed "a-z0-9_" \
    -first_restricted "0-9_" \
    -replacement_char "_" \
    -equal_ports_nets -inout_ports_equal_nets \
    -collapse_name_space -case_insensitive -special verilog \
    -add_dummy_nets \
    -dummy_net_prefix "synp_unconn_%d"


#TODO Make sure you set compile_options in dc_init.tcl to replace the precedent lines
set compile_options -area_high_effort_script
source -echo -verbose ./dc_init.tcl

echo ""
echo "****** Top design is $top_design (in library $top_lib)"
echo "****** Techno is $techno"
echo ""
set iter pre_elaborate


#***********************************************
#**** LOADING TECHNO LIBS FOR $techno TECHNO ***
#***********************************************
source -echo -verbose $scripts_dir/dc_set_techno.tcl


if {[file exists "./dc_pre_elaborate.tcl"]==1} {source -echo -verbose ./dc_pre_elaborate.tcl} 

#***********************************************
#**** LOADING RTL sources                    ***
#***********************************************
source -echo -verbose ./dc.tcl


#***********************************************
#******** ELABORATING $top_design **************
#***********************************************
elaborate $top_design -library $top_lib

link


#***********************************************
#********* SETTING COMPILATION CONSTRAINTS *****
#***********************************************
set iter precomp

check_design
create_clock [get_ports $clk_port] -name $clk_name -period $clk_period -waveform $clk_waveform
set_clock_uncertainty $clk_uncertainty [get_clocks $clk_name]

# Generate Pre compilation Reports
write -hier $top_design -output    ./netlist/${top_design}_${techno}_${iter}.ddc
change_names -hierarchy -rules verilog
write -hier $top_design -output    ./netlist/${top_design}_${techno}_${iter}.vhd -format vhdl
report_hierarchy                 > ./reports/${top_design}_${techno}_${iter}_hierarchy.log
list_libs                        > ./reports/${top_design}_${techno}_${iter}_libs.log

#Constraining design
if {[file exists "./dc_constraints.tcl"]==1}         {source -echo -verbose ./dc_constraints.tcl}
if {[file exists "./dc_set_false_path.tcl"]==1}      {source -echo -verbose ./dc_set_false_path.tcl}
if {[file exists "./dc_set_multicycle_path.tcl"]==1} {source -echo -verbose ./dc_set_multicycle_path.tcl}
if {[file exists "./dc_set_case_analysis.tcl"]==1}   {source -echo -verbose ./dc_set_case_analysis.tcl}
if {[file exists "./dc_clock_gating.tcl"]==1}        {source -echo -verbose ./dc_clock_gating.tcl}
if {[file exists "./dc_clock_gating_style.tcl"]==1}  {source -echo -verbose ./dc_clock_gating_style.tcl}
#** Saving constrained database
write -hier $top_design -output ./netlist/${top_design}_${techno}_constrainted.ddc


#***********************************************
#* $top_design DESIGN HIERARCHICAL COMPILATION *
#***********************************************
set iter synth_hier

#if {$always_ungroup == "1"} {source $scripts_dir/ungroup.dcsh} else {source $scripts_dir/group.dcsh} FIXME this became obsolete

#propagate_constraints
set_flatten false
report_compile_options
compile_ultra $compile_options -no_autoungroup
optimize_netlist -area
change_names -hier -rule verilog


if {[file exists "./dc_postcompile.tcl"]==1} {source -echo -verbose ./dc_postcompile.tcl}

source -echo -verbose $scripts_dir/dc_gen_netlist.tcl
source -echo -verbose $scripts_dir/dc_gen_reports.tcl

# Reports particular cells
if {[file exists "./dc_cells.tcl"]==1} {source -echo -verbose ./dc_cells.tcl} else {source $scripts_dir/dc_report_cells.tcl}


#***********************************************
#*** $top_design DESIGN FLATTEN COMPILATION ****
#***********************************************
set iter synth_flat

#propagate_constraints
set_flatten true
ungroup -all
report_compile_options
compile_ultra $compile_options
optimize_netlist -area
change_names -hier -rule verilog

if {[file exists "./dc_postcompile.tcl"]==1} {source -echo -verbose ./dc_postcompile.tcl}

source -echo -verbose $scripts_dir/dc_gen_netlist.tcl
source -echo -verbose $scripts_dir/dc_gen_reports.tcl

# Reports particular cells
if {[file exists "./dc_cells.tcl"]==1} {source -echo -verbose ./dc_cells.tcl} else {source $scripts_dir/dc_report_cells.tcl}

echo ""
echo -n ' ****** ENDING Synthesis at ' 
sh date
echo ""

quit
