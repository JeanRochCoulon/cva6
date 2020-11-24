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
#- Description: TCL file used to generate report files
#-------------------------------------------------------------------------------


#Clock-gating reports
echo "***  Report clock gating insertion"
echo "*  report clock_gating : gated registers in   ${top_design}_${techno}_${iter}_greg.log file"
report_clock_gating -style -multi_stage -verbose -gated               > ./reports/${top_design}_${techno}_${iter}_cg_greg.log
echo "*  report clock_gating : ungated registers in ${top_design}_${techno}_${iter}_cg_ungreg.log file"
report_clock_gating -style -multi_stage -verbose -ungated             > ./reports/${top_design}_${techno}_${iter}_cg_ungreg.log
echo "*  report clock_gating : gated elements in    ${top_design}_${techno}_${iter}_cg_elements.log file"
report_clock_gating -style -multi_stage -verbose -gating_elements     > ./reports/${top_design}_${techno}_${iter}_cg_elements.log
echo "*  report clock_gating : structure in         ${top_design}_${techno}_${iter}_cg_struct.log file"
report_clock_gating -structure                                        > ./reports/${top_design}_${techno}_${iter}_cg_struct.log


# Generate Post Synthesis Reports
report_hierarchy                                      > ./reports/${top_design}_${techno}_${iter}_hierarchy.log
report_area -hierarchy                                > ./reports/${top_design}_${techno}_${iter}_area.log
report_cell -nosplit                                  > ./reports/${top_design}_${techno}_${iter}_area_nosplit.log
report_clock                                          > ./reports/${top_design}_${techno}_${iter}_clock_hier.log
report_timing -path full_clock_expanded -max_paths 15 > ./reports/${top_design}_${techno}_${iter}_timings.log
report_timing -path_type end -nworst 1                > ./reports/${top_design}_${techno}_${iter}_timings_end.log
report_timing -delay min -path full_clock_expanded  -max_paths 15 > ./reports/${top_design}_${techno}_${iter}_timings_hold.log
report_reference -hierarchy                           > ./reports/${top_design}_${techno}_${iter}_ref.log
report_power                                          > ./reports/${top_design}_${techno}_${iter}_power.log
report_qor                                            > ./reports/${top_design}_${techno}_${iter}_QoR.log
report_bus                                            > ./reports/${top_design}_${techno}_${iter}_buses_flat.log



#generate timing for all combinationals path to outputs for each input:
set all_inputs_collection [all_inputs]

echo "" > ./reports/${top_design}_${techno}_${iter}_comb_path_in_to_out.log
foreach_in_collection input ${all_inputs_collection} {
  echo                                                                                  >>  ./reports/${top_design}_${techno}_${iter}_comb_path_in_to_out.log
  echo "###########################################################################"    >> ./reports/${top_design}_${techno}_${iter}_comb_path_in_to_out.log
  echo -n "Combinationnals paths to ouputs from input pin "                             >> ./reports/${top_design}_${techno}_${iter}_comb_path_in_to_out.log
  echo [get_object_name ${input}]                                                       >> ./reports/${top_design}_${techno}_${iter}_comb_path_in_to_out.log
  report_timing -from ${input} -to [all_outputs] -input_pins -path end -max_paths 10000 >> ./reports/${top_design}_${techno}_${iter}_comb_path_in_to_out.log
}
