# ------------------------------------------------------------------------------
#-                                                                            --
#-                      Copyright (C) 2014 INVIA                              --
#-                                                                            --
#-   All rights reserved. Reproduction in whole or part is prohibited         --
#-      without the written permission of the copyright owner                 --
#-                                                                            --
#-------------------------------------------------------------------------------
#- Author: N. VALETTE - INVIA
#- Revision : 
#- Date     : 
#- Description: TCL file used to generate netlist files
#-------------------------------------------------------------------------------


# Change clock tree to ideal (remove delays):
echo  $clk_ports_list
foreach clk_j $clk_ports_list { 
  echo "**** Remove delays for $clk_j"
  set pins [filter_coll [all_fanout -from [get_port [string tolower $clk_j]] \
         -flat] "pin_direction==in"]
  foreach_in_collection p $pins {
    set_annotated_transition 0 $p
    set_load 0 [get_net -of $p]
    set_annotated_delay 0 -net \
      -from [filter_coll [all_fanin -to $p -flat -level 1] "pin_direction==out"] \
      -to $p
    set_annotated_delay 0 -cell \
      -from $p \
      -to [filter_coll [all_fanout -from $p -flat -level 1] "pin_direction==out"]
  } > ./reports/${top_design}_${techno}_${iter}_remove_ideal_network.log
}


# Generate Post Synthesis Files
write $top_design -hier -output ./netlist/${top_design}_${techno}_${iter}.v   -format verilog
write_sdf ./netlist/${top_design}_${techno}_${iter}.v.sdf
write $top_design -hier -output ./netlist/${top_design}_${techno}_${iter}.v.ddc
write_sdc ./netlist/${top_design}_${techno}_${iter}.v.sdc
write_sdf ./netlist/${top_design}_${techno}_${iter}.vhd.sdf
write $top_design -hier -output ./netlist/${top_design}_${techno}_${iter}.vhd.ddc
write_sdc ./netlist/${top_design}_${techno}_${iter}.vhd.sdc


# NOTE: the following lines will be particularly useful for a translation Verilog2VHDL
#set vhdlout_equations true
#write $top_design -hier -output ./netlist/${top_design}_${techno}_${iter}_boolean.vhd -format vhdl
#set vhdlout_equations false
