# ------------------------------------------------------------------------------
#-                                                                            --
#-                      Copyright (C) 2019 INVIA                         --
#-                                                                            --
#-   All rights reserved. Reproduction in whole or part is prohibited         --
#-      without the written permission of the copyright owner                 --
#-                                                                            --
#-------------------------------------------------------------------------------
#- Author: T. DOUTREMER - INVIA
#- Revision : 
#- Date     :
#- Description: Makefile used for formality
#-------------------------------------------------------------------------------

ifndef INVIA_SCRIPTS_DIR
  $(error you must set the 'INVIA_SCRIPTS_DIR' variable in your Makefile!)
endif
SCRIPTS_DIR=$(INVIA_SCRIPTS_DIR)/synth


#EXPORT_LIST used only for local synthesis (for the moment)
EXPORT_LIST=TOP_LIB=$(TOP_LIB) SNPSLMD_QUEUE=TRUE TECH_NAME=$(TECH_NAME) FM_SHELL_PATH=$(FM_SHELL_PATH) SCRIPTS_DIR=$(SCRIPTS_DIR) TOP=$(TOP) TERM=vt100 SCAN_INSERTION=$(SCAN_INSERTION)

rtl2gate: fm_setup
	@echo "Formality release: $(FM_SHELL_PATH)"
	@export $(EXPORT_LIST) ;$(FM_SHELL_PATH)/fm_shell -f $(SCRIPTS_DIR)/rm_flow/fm.tcl
        
fm_setup:
	@make -C ../sim gendep TOOL=fm TOP=$(TOP) LIBRARIES_MAP=../../libraries.map
	@cp ../sim/build/fm.tcl .
        
