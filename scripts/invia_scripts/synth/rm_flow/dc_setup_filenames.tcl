puts "RM-Info: Running script [info script]\n"

#################################################################################
# Design Compiler Reference Methodology Filenames Setup
# Script: dc_setup_filenames.tcl
# Version: J-2014.09-SP2 (January 12, 2015)
# Copyright (C) 2010-2015 Synopsys, Inc. All rights reserved.
#################################################################################

#################################################################################
# Use this file to customize the filenames used in the Design Compiler
# Reference Methodology scripts.  This file is designed to be sourced at the
# beginning of the dc_setup.tcl file after sourcing the common_setup.tcl file.
#
# Note that the variables presented in this file depend on the type of flow
# selected when generating the reference methodology files.
#
# Example.
#    If you set DFT flow as FALSE, you will not see DFT related filename
#    variables in this file.
#
# When reusing this file for different flows or newer release, ensure that
# all the required filename variables are defined.  One way to do this is
# to source the default dc_setup_filenames.tcl file and then override the
# default settings as needed for your design.
#
# The default values are backwards compatible with older
# Design Compiler Reference Methodology releases.
#
# Note: Care should be taken when modifying the names of output files
#       that are used in other scripts or tools.
#################################################################################

#################################################################################
# General Flow Files
#################################################################################

##########################
# Milkyway Library Names #
##########################

set DCRM_MW_LIBRARY_NAME                                ${DESIGN_NAME}_${TECH}_LIB
set DCRM_FINAL_MW_CEL_NAME                              ${DESIGN_NAME}_${TECH}_DCT

#####################
# MCMM File Names   #
#####################

set DCRM_MCMM_SCENARIOS_SETUP_FILE                      ./scripts/dc_mcmm.scenarios.tcl
set DCRM_MCMM_SCENARIOS_REPORT                          ${DESIGN_NAME}.mcmm.scenarios.rpt

# The following procedure is used to control the naming of the scenario-specific
# MCMM input and output files. 
# By default the naming convention inserts the scenario name before the file 
# extension.
# Modify this procedure if you want to use different name convention for the 
# scenario-specific file naming.

proc dcrm_mcmm_filename { filename scenario } {
  return [file rootname $filename].$scenario[file extension $filename]
}

###############
# Input Files #
###############

set DCRM_SDC_INPUT_FILE                                 ${DESIGN_NAME}.sdc
set DCRM_CONSTRAINTS_INPUT_FILE                         ${DESIGN_NAME}.constraints.tcl

###########
# Reports #
###########

set DCRM_CHECK_LIBRARY_REPORT                           ${DESIGN_NAME}_${TECH}_synth_check_library.rpt

set DCRM_CONSISTENCY_CHECK_ENV_FILE                     ${DESIGN_NAME}_${TECH}.compile_ultra.env
set DCRM_CHECK_DESIGN_REPORT                            ${DESIGN_NAME}_${TECH}.check_design.rpt
set DCRM_ANALYZE_DATAPATH_EXTRACTION_REPORT             ${DESIGN_NAME}_${TECH}.analyze_datapath_extraction.rpt

set DCRM_FINAL_QOR_REPORT                               ${DESIGN_NAME}_${TECH}_synth_qor.rpt
set DCRM_FINAL_TIMING_REPORT                            ${DESIGN_NAME}_${TECH}_synth_timing.rpt
set DCRM_FINAL_AREA_REPORT                              ${DESIGN_NAME}_${TECH}_synth_area.rpt
set DCRM_FINAL_POWER_REPORT                             ${DESIGN_NAME}_${TECH}_synth_power.rpt
set DCRM_FINAL_CLOCK_GATING_REPORT                      ${DESIGN_NAME}_${TECH}_synth_clock_gating.rpt
set DCRM_FINAL_SELF_GATING_REPORT                       ${DESIGN_NAME}_${TECH}_synth_self_gating.rpt
set DCRM_THRESHOLD_VOLTAGE_GROUP_REPORT                 ${DESIGN_NAME}_${TECH}_synth_threshold.voltage.group.rpt
set DCRM_INSTANTIATE_CLOCK_GATES_REPORT                 ${DESIGN_NAME}_${TECH}_synth_instatiate_clock_gates.rpt

################
# Output Files #
################

set DCRM_AUTOREAD_RTL_SCRIPT                            ${DESIGN_NAME}_${TECH}.autoread_rtl.tcl
set DCRM_ELABORATED_DESIGN_DDC_OUTPUT_FILE              ${DESIGN_NAME}_${TECH}.elab.ddc
set DCRM_COMPILE_ULTRA_DDC_OUTPUT_FILE                  ${DESIGN_NAME}_${TECH}.compile_ultra.ddc
set DCRM_FINAL_DDC_OUTPUT_FILE                          ${DESIGN_NAME}_${TECH}_synth.ddc
set DCRM_FINAL_VERILOG_OUTPUT_FILE                      ${DESIGN_NAME}_${TECH}_synth.v
set DCRM_FINAL_SDC_OUTPUT_FILE                          ${DESIGN_NAME}_${TECH}_synth.sdc

#################################################################################
# DCT Flow Files
#################################################################################

###################
# DCT Input Files #
###################

set DCRM_DCT_DEF_INPUT_FILE                             ./inputs/pegasus.def
set DCRM_DCT_FLOORPLAN_INPUT_FILE                       ${DESIGN_NAME}.fp
set DCRM_DCT_PHYSICAL_CONSTRAINTS_INPUT_FILE            ${DESIGN_NAME}.physical_constraints.tcl


###############
# DCT Reports #
###############

set DCRM_DCT_PHYSICAL_CONSTRAINTS_REPORT                ${DESIGN_NAME}_${TECH}.physical_constraints.rpt

set DCRM_DCT_FINAL_CONGESTION_REPORT                    ${DESIGN_NAME}_${TECH}_synth_congestion.rpt
set DCRM_DCT_FINAL_CONGESTION_MAP_OUTPUT_FILE           ${DESIGN_NAME}_${TECH}_synth_congestion_map.png
set DCRM_DCT_FINAL_CONGESTION_MAP_WINDOW_OUTPUT_FILE    ${DESIGN_NAME}_${TECH}_synth_congestion_map_window.png

set DCRM_DCT_FINAL_QOR_SNAPSHOT_FOLDER                  ${DESIGN_NAME}_${TECH}.qor_snapshot
set DCRM_DCT_FINAL_QOR_SNAPSHOT_REPORT                  ${DESIGN_NAME}_${TECH}.qor_snapshot.rpt

####################
# DCT Output Files #
####################

set DCRM_DCT_FLOORPLAN_OUTPUT_FILE                      ${DESIGN_NAME}_${TECH}.initial.fp

set DCRM_DCT_FINAL_FLOORPLAN_OUTPUT_FILE                ${DESIGN_NAME}_${TECH}_synth.fp
set DCRM_DCT_FINAL_SPEF_OUTPUT_FILE                     ${DESIGN_NAME}_${TECH}_synth.spef
set DCRM_DCT_FINAL_SDF_OUTPUT_FILE                      ${DESIGN_NAME}_${TECH}_synth.sdf


#################################################################################
# Formality Flow Files
#################################################################################

set DCRM_SVF_OUTPUT_FILE                                ${DESIGN_NAME}_${TECH}.mapped.svf

set FMRM_UNMATCHED_POINTS_REPORT                        ${DESIGN_NAME}_${TECH}.fmv_unmatched_points.rpt

set FMRM_FAILING_SESSION_NAME                           ${DESIGN_NAME}_${TECH}
set FMRM_FAILING_POINTS_REPORT                          ${DESIGN_NAME}_${TECH}.fmv_failing_points.rpt
set FMRM_ABORTED_POINTS_REPORT                          ${DESIGN_NAME}_${TECH}.fmv_aborted_points.rpt
set FMRM_ANALYZE_POINTS_REPORT                          ${DESIGN_NAME}_${TECH}.fmv_analyze_points.rpt

puts "RM-Info: Completed script [info script]\n"
