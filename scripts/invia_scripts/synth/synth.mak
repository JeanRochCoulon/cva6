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
#- Description: Makefile used for synthesis
#-------------------------------------------------------------------------------

DC_SHELL_PATH=/opt/synopsys/syn/M-2016.12-SP1/bin

DIR_PATH:=$(shell echo $$(basename $$(readlink -f $$(pwd)/../..)))

ifeq "$(USER)" "jenkins"
  DEST_DIR:=synth_batchs/$(USER)/$(JOB_NAME)/$(TOP)
else
  DEST_DIR:=synth_batchs/$(USER)/$(TOP)
endif

CURRENT_LIB:=$(shell echo $$(basename $$(readlink -f $$(pwd)/..)))


ifndef INVIA_SCRIPTS_DIR
  $(error you must set the 'INVIA_SCRIPTS_DIR' variable in your Makefile!)
endif
SCRIPTS_DIR=$(INVIA_SCRIPTS_DIR)/synth


#EXPORT_LIST used only for local synthesis (for the moment)
EXPORT_LIST=TOP_LIB=$(TOP_LIB) SNPSLMD_QUEUE=TRUE TECH_NAME=$(TECH_NAME) DC_SHELL_PATH=$(DC_SHELL_PATH) SCRIPTS_DIR=$(SCRIPTS_DIR) TOP=$(TOP) TERM=vt100 SCAN_INSERTION=$(SCAN_INSERTION)

synth: dc_script_gen
	@echo "Synthesis release: $(DC_SHELL_PATH)"
	@export $(EXPORT_LIST) ;$(DC_SHELL_PATH)/dc_shell-xg-t -topo -f $(SCRIPTS_DIR)/rm_flow/dc.tcl -output synthesis_batch.log
        
interative:
	@echo "Synthesis release: $(DC_SHELL_PATH)"
	@export $(EXPORT_LIST) ;$(DC_SHELL_PATH)/dc_shell-xg-t -topo -f $(SCRIPTS_DIR)/rm_flow/dc_setup.tcl -output synthesis_interactive.log
        
        
#idem to synth target but does not source the syn.tcl file
start_dc:
	$(SSH_CMD_PREFIX)export TOP_LIB=$(TOP_LIB) SCRIPTS_DIR=$(TARGET_SCRIPTS_DIR)/synth TOP=$(TOP) TECH=$(TECH_NAME) SNPSLMD_QUEUE=TRUE;cd ~/$(DEST_DIR)/$(CURRENT_LIB)/synth ; bash $(TARGET_SCRIPTS_DIR)/synth/start_dc.sh$(SSH_CMD_SUFFIX)
	@ssh $(SSH_HOST) "cat ~/$(DEST_DIR)/$(CURRENT_LIB)/synth/synthesis.log" > ./synthesis.log
	@$(MAKE) get_reports_generic

# load synthesis in local directory. No upload
synth_local: dc_script_gen
	export $(EXPORT_LIST) LOCAL=ON; bash $(SCRIPTS_DIR)/synth.sh
	@grep -in -B1 -A2 "error" ./synthesis.log > ./errors.log || exit 0
	@grep -in -B1 -A2 "warning" synthesis.log > warnings.log || exit 0
	@echo ""
	@$(MAKE) -s gen_plot_generics

# idem to synth_local target but does not source the syn.tcl file
start_dc_local: 
	export $(EXPORT_LIST) LOCAL=ON; bash $(SCRIPTS_DIR)/start_dc.sh

dc_script_gen:
ifndef DC_FILES_SCRIPT #Do not generate dc.tcl, if a DC_FILES_SCRIPT is defined
	@make -C ../sim gendep TOOL=dc TOP=$(TOP)
	@cp ../sim/build/dc.tcl dc.tcl
else
ifneq ($(DC_FILES_SCRIPT),dc.tcl)
	@cp $(DC_FILES_SCRIPT) dc.tcl
endif
endif
	@echo ""

clean:
	@rm -rf work alib* *_LIB *log *svf netlist reports


##########################################################################################
#Dependencies used to generate plot file
##########################################################################################

ifeq "$(TECH_NAME)" "GSMC13"
NAND_AREA=6052
endif
ifeq "$(TECH_NAME)" "UMC55HVT"
NAND_AREA=1120
endif
ifeq "$(TECH_NAME)" "UMC55RVT"
NAND_AREA=1120
endif
ifeq "$(TECH_NAME)" "ALTIS130"
NAND_AREA=6400
endif
ifeq "$(TECH_NAME)" "ALTIS130_RVT"
NAND_AREA=6400
endif
ifeq "$(TECH_NAME)" "LF11"
NAND_AREA=4110
endif
ifeq "$(TECH_NAME)" "LF11_TIEMPO"
NAND_AREA=4110
endif

plot_all: plot_gate_count plot_power plot_qor plot_reg_number plot_clock_gate

plot_gate_count:
	@$(INVIA_SCRIPTS_DIR)/synth/plot_gate_count.sh $(REPORT_FILE) $(PLOT_FILE) $(NAND_AREA)

plot_power: 
	@$(INVIA_SCRIPTS_DIR)/synth/plot_power.sh      $(REPORT_FILE) $(PLOT_FILE)

plot_qor:
	@$(INVIA_SCRIPTS_DIR)/synth/plot_qor.sh        $(REPORT_FILE) $(CLK_NAME) levels_$(CLK_NAME).plot

plot_qor_max:
	@$(INVIA_SCRIPTS_DIR)/synth/plot_qor_max.sh    $(REPORT_FILE) levels_max.plot

plot_reg_number:
	@$(INVIA_SCRIPTS_DIR)/synth/plot_reg_number.sh $(REPORT_FILE) reg_number.plot

plot_clock_gate:
	@$(INVIA_SCRIPTS_DIR)/synth/plot_clock_gate.sh $(REPORT_FILE) cg_percentage.plot cg_gated.plot cg_ungated.plot

gen_plot_generics:
	@$(MAKE) plot_gate_count REPORT_FILE=reports/$(TOP)_$(TECH_NAME)_synth_hier_area.log  PLOT_FILE=gate_count_hier.plot
	@$(MAKE) plot_gate_count REPORT_FILE=reports/$(TOP)_$(TECH_NAME)_synth_flat_area.log  PLOT_FILE=gate_count_flat.plot
	@$(MAKE) plot_power      REPORT_FILE=reports/$(TOP)_$(TECH_NAME)_synth_hier_power.log PLOT_FILE=dyn_power_hier.plot
	@$(MAKE) plot_power      REPORT_FILE=reports/$(TOP)_$(TECH_NAME)_synth_flat_power.log PLOT_FILE=dyn_power_flat.plot
	@$(MAKE) plot_clock_gate REPORT_FILE=reports/$(TOP)_$(TECH_NAME)_synth_hier_cg_struct.log
	@$(MAKE) plot_reg_number REPORT_FILE=reports/$(TOP)_$(TECH_NAME)_synth_hier_cg_struct.log
