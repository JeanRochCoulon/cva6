#!/bin/bash

#-------------------------------------------------------------------------------
#-                                                                            --
#-                      Copyright (C) 2015 INVIA                              --
#-                                                                            --
#-   All rights reserved. Reproduction in whole or part is prohibited         --
#-      without the written permission of the copyright owner                 --
#-                                                                            --
#-------------------------------------------------------------------------------
#- Author: N. VALETTE - INVIA
#- Revision : 
#- Date     : 
#- Description: Bash file used to launch Design Compiler
#-------------------------------------------------------------------------------


if [[ "$TOPO" = "ON" ]] ; then
  echo "  -Running synthesis with topographical mode"
  DC_OPT="-topographical_mode"
  SCRIPT_FILE=$SCRIPTS_DIR/syn_topo.tcl
else
  SCRIPT_FILE=$SCRIPTS_DIR/rm_flow/dc.tcl
fi;


# Run Design Compiler with commands in scripts/platform_syn.tcl
${DC_SHELL_PATH}/dc_shell-xg-t  ${DC_OPT} -f ${SCRIPT_FILE} | tee synthesis.log
