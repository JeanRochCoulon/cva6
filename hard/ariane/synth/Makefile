# ------------------------------------------------------------------------------
#-                                                                            --
#-                      Copyright (C) 2010 INVIA                              --
#-                                                                            --
#-   All rights reserved. Reproduction in whole or part is prohibited         --
#-      without the written permission of the copyright owner                 --
#-                                                                            --
#-------------------------------------------------------------------------------
#- Author: N. VALETTE - INVIA
#- Revision : $Rev: 65 $
#- Date     : $LastChangedDate: 2010-06-10 17:27:46 +0200 (Thu, 10 Jun 2010) $
#- Description: Makefile used to launch dc_shell on cimpaca
#-------------------------------------------------------------------------------
HOST=invia
INVIA_SCRIPTS_DIR=../../../scripts/invia_scripts
TOP=s8_top
TOP_LIB=s8
TECH_NAME=UMC55HVTWC
#ST28
#UMC55HVT
SEND_LIB=1
LIBRARIES_MAP=../../libraries_fastbench.map
export LIBRARIES_MAP
################# DON'T TOUCH LINE BELLOW ################# 
#if the following file does not exist, please clone the invia_script project
include $(INVIA_SCRIPTS_DIR)/synth/synth.mak
#DC_SHELL_PATH=/opt/synopsys/Design_Compiler_dir/P-2019.03-SP5-1/bin/
DC_SHELL_PATH=/opt/synopsys/syn/Q-2019.12/bin/

ariane_synth:
	git apply sram.patch
	@echo "Synthesis release: $(DC_SHELL_PATH)"
	sed 's/set clk_period/set clk_period 8/' ariane_dc.tcl > command.tcl
	sed 's/set clk_waveform/set clk_waveform {0 4}/' command.tcl > command2.tcl
	sed 's/set DESIGN_NAME_BIS/set DESIGN_NAME_BIS ariane/' command2.tcl > command.tcl; rm command2.tcl
	@export $(EXPORT_LIST); $(DC_SHELL_PATH)/dc_shell -f ./command.tcl -output synthesis_batch.log
	python $(INVIA_SCRIPTS_DIR)/synth/gateAnalysis.py 


######## FOLLOWING LINES ARE SPECIFIC TO PROJECT ##########

get_reports: get_reports_generic

gen_area_plot_file:
	echo YVALUE=$$(cat reports/$(TOP)_$(TECH_NAME)_synth_hier_area.log\
          | grep 'Total cell area:'\
          | awk '{printf $$4}')\
          | tee reports/$(TOP)_$(TECH_NAME)_area_hier.plot
	echo YVALUE=$$(cat reports/$(TOP)_$(TECH_NAME)_synth_flat_area.log\
          | grep 'Total cell area:'\
          | awk '{printf $$4}')\
          | tee reports/$(TOP)_$(TECH_NAME)_area_flat.plot

