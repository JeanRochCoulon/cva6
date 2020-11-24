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
#- Description: Bash file used to launch Design Compiler with sourcing commands
#-------------------------------------------------------------------------------


if [[ "$TOPO" = "ON" ]] ; then
  echo "  -Running synthesis with topographical mode"
  DC_OPT="-topographical_mode"
fi;


if [[ "$LOCAL" = "ON" ]] ; then
  echo "  -Running synthesis on local host"
  TOOL_PATH=$DC_SHELL_PATH/
else
  echo "  -Running synthesis on remote host"
  # Load environment variables
  source /etc/profile
  source ~/.profile
  #echo $PATH
  TOOL_PATH=""
fi;

# Run Design Compiler without commands
$TOOL_PATH\dc_shell-xg-t -wait 800 ${DC_OPT} | tee synthesis.log
