# ------------------------------------------------------------------------------
#-                                                                            --
#-                      Copyright (C) 2010 INVIA                              --
#-                                                                            --
#-   All rights reserved. Reproduction in whole or part is prohibited         --
#-      without the written permission of the copyright owner                 --
#-                                                                            --
#-------------------------------------------------------------------------------
#- Author: N. VALETTE - INVIA
#- Revision : $Rev $
#- Date     : $LastChangedDate: 2010-05-19 17:04:32 +0200 (Wed, 19 May 2010) $
#- Description: Script used to convert lib file into synopsys db file
#               It has to be executed on cim_paca
#-------------------------------------------------------------------------------



#RASP1280X32M8_typical
#RASP1280X32M16_typical
#RASP4096X32M16_typical
#RAS7680X32M32_typical
#VROM8192X32M16_typical


set library_name VROM8192X32M16_typical
set input_path   /home/jrcoulon/GSMC13LP/Mem/import
set output_path  /home/jrcoulon/GSMC13LP/Mem/import


read_lib ${input_path}/${library_name}.lib
write_lib -format db -output ${output_path}/${library_name}.db ${library_name}
