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
#- Description: TCL file used to set technology parameters
#-------------------------------------------------------------------------------

echo "************************************************"
echo "***** SETTING LIBRARIES FOR TECHNO $techno ****"
echo "************************************************"


if {[regexp {.*ALTIS130.*} $techno]} {
 source $scripts_dir/altis130setup.dcsh
 #set lib_name "starlib_hvt_10t"
}
if {$techno == "GSMC13"} {
 source $scripts_dir/gsmc13setup.dcsh
 set lib_name "gsmc13_lp_ss_1p35v_125c"
}
if {$techno == "GSMC13_ARM"} {
  source $scripts_dir/gsmc13_arm_rvtsetup.dcsh
  set lib_name "sc7_l013_base_rvt_ss_TYP_max_1p35v_125c"
}
if {$techno == "ST65GPLVT"} {
 source $scripts_dir/st65gplvt.dcsh
}
if {$techno == "ST65GPSVT"} {
 source $scripts_dir/st65gpsvt.dcsh
}
if {$techno == "STM90"} {
 source $scripts_dir/stm90setup.dcsh
}
if {$techno == "LF11"} {
 source $scripts_dir/lf11setup.dcsh
 set lib_name "lf110dhvt7s_worst"
}
if {$techno == "LF11_TIEMPO"} {
 source $scripts_dir/lf11_tiemposetup.dcsh
 set lib_name "STD_SS_1.08V_125C"
}
if {$techno == "TOSHIBA65"} {
 source $scripts_dir/toshiba65.dcsh
 set lib_name "tc320ca_lp_ss_1.10v_tj125_ccs"
}
if {$techno == "UMC55HVT"} {
 source $scripts_dir/umc55hvtsetup.dcsh
 set lib_name "u055lsclpmvbdh_108c125_wc"
}
if {$techno == "UMC55RVT"} {
 source $scripts_dir/umc55rvtsetup.dcsh
 set lib_name "u055lsclpmvbdr_108c125_wc"
}
if {$techno == "AMS350"} {
 source $scripts_dir/ams350.dcsh
}
if {$techno == "GF55LPHVT_ARM"} {
 source $scripts_dir/gf55_arm_lphvtsetup.dcsh
 set lib_name "sc8_55lpx_base_hvt_ss_nominal_max_1p08v_125c"
}

echo "search_path is set to: \n$search_path\n"
echo "link_library is set to: \n$link_library\n"
echo "target_library is set to: \n$target_library\n"
echo "symbol_library is set to: \n$symbol_library\n"
echo "synthetic_library is set to: \n$synthetic_library\n"
