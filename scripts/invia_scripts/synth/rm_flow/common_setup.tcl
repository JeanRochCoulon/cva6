puts "RM-Info: Running script [info script]\n"

##########################################################################################
# Variables common to all reference methodology scripts
# Script: common_setup.tcl
# Version: J-2014.09-SP2 (January 12, 2015)
# Copyright (C) 2007-2015 Synopsys, Inc. All rights reserved.
##########################################################################################

set DESIGN_NAME                   [getenv TOP]  ;#  The name of the top-level design
set TECH                          [getenv TECH_NAME];
set techno                        [getenv TECH_NAME];
set SCRIPTS_DIR                   [getenv SCRIPTS_DIR];
set TOP_LIB                       [getenv TOP_LIB]
set SCAN_INSERTION                [getenv SCAN_INSERTION]

set DESIGN_REF_DATA_PATH          ""  ;#  Absolute path prefix variable for library/design data.
                                       #  Use this variable to prefix the common absolute path  
                                       #  to the common variables defined below.
                                       #  Absolute paths are mandatory for hierarchical 
                                       #  reference methodology flow.

##########################################################################################
# Hierarchical Flow Design Variables
##########################################################################################

set HIERARCHICAL_DESIGNS           "";# List of hierarchical block design names "DesignA DesignB" ...
                                   
set HIERARCHICAL_CELLS             "" ;# List of hierarchical block cell instance names "u_DesignA u_DesignB" ...

##########################################################################################
# Library Setup Variables
##########################################################################################

# For the following variables, use a blank space to separate multiple entries.
# Example: set TARGET_LIBRARY_FILES "lib1.db lib2.db lib3.db"

if {$techno == "UMC55HVTTYP" || $techno == "UMC55HVTWC"} {
  set FOUNDRY_PATH  "/opt/PDK/UMC/UMC55/common/stdcells/G-9LT-EFLASH_EE2PROM55N-LP_SPLIT_GATE_UM055LSCEE12BDH-LIBRARY_TAPE_OUT_KIT-Ver.B02_PB"
  set lib_base_name "u055lscee12bdh"
}
if {$techno == "UMC55RVTWC" || $techno == "UMC55RVTTYP" || $techno == "UMC55RVTBC"} {
  set FOUNDRY_PATH  "/opt/PDK/UMC/UMC55/common/stdcells/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDH-LIBRARY_TAPE_OUT_KIT-Ver.A03_P.B"
  set lib_base_name "u055lsclpmvbdh"
}
if {$techno == "ST28WC" || $techno == "ST28TYP"} {
  set FOUNDRY_PATH  "/opt/PDK/ST/CMOS028FD/stdcells_ISSM_28FD_31Oct2018/C28SOI_SC_8_CORE_LR/libs/"
  set lib_base_name "C28SOI_SC_8_CORE_LR_"
}
if {$techno == "ST40LLWC" || $techno == "ST40LLTYP"} {
  set FOUNDRY_PATH  "/opt/PDK/ST/CMOS040LP/STDCELLS/CMOS045_SC_14_CORE_LL_C40LP_SNPS-AVT-CDS/4.1/libs/"
  set lib_base_name "CMOS045_SC_14_CORE_LL"
}
if {$techno == "ST40LSWC" || $techno == "ST40LSTYP"} {
  set FOUNDRY_PATH  "/opt/PDK/ST/CMOS040LP/STDCELLS/CMOS045_SC_14_CORE_LS_C40LP_SNPS-AVT-CDS/4.1/libs/"
  set lib_base_name "CMOS045_SC_14_CORE_LS"
}


set ADDITIONAL_SEARCH_PATH        " ${FOUNDRY_PATH}/synopsys \
                                    ${FOUNDRY_PATH}/ \
                                  ";#  Additional search path to be added to the default search path

if {$techno == "UMC55RVTWC"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_108c125_wc.db "  ;
}
if {$techno == "UMC55RVTTYP"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_120c25_tc.db "  ;
}
if {$techno == "UMC55RVTBC"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_132c-40_bc.db "  ;
}
if {$techno == "UMC55HVTWC"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_108c125_wc.db"  ;
}
if {$techno == "UMC55HVTTYP"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_120c25_tc.db"  ;
}
if {$techno == "ST28WC"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_ss28_0.90V_125C.db"  ;
}
if {$techno == "ST28TYP"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_ss28_0.90V_125C.db"  ;
}
if {$techno == "ST40LLWC"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_ss40_0.90V_125C.db"  ;
}
if {$techno == "ST40LLTYP"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_tt40_1.10V_125C.db"  ;
}
if {$techno == "ST40LSWC"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_ss40_0.90V_125C.db"  ;
}
if {$techno == "ST40LSTYP"} {
  set TARGET_LIBRARY_FILES          " ${lib_base_name}_tt40_1.10V_125C.db"  ;
}



set ADDITIONAL_LINK_LIB_FILES     "                                  ";#  Extra link logical libraries not included in TARGET_LIBRARY_FILES

set MIN_LIBRARY_FILES             ""  ;#  List of max min library pairs "max1 min1 max2 min2 max3 min3"...

set MW_REFERENCE_LIB_DIRS         " ${FOUNDRY_PATH}/milkyway/${lib_base_name} \
                                  "  ;#  Milkyway reference libraries (include IC Compiler ILMs here)

set MW_REFERENCE_CONTROL_FILE     ""  ;#  Reference Control file to define the Milkyway reference libs

set TECH_FILE                     "${FOUNDRY_PATH}/milkyway/tf/${lib_base_name}_5m1t0f.tf"  ;#  Milkyway technology file
set MAP_FILE                      "/data/PDK/UMC/UMC55/common/PandR/M5option/tlu/UMC55_5m0t1f_TLUplus.map"  ;#  Mapping file for TLUplus
set TLUPLUS_MAX_FILE              "/data/PDK/UMC/UMC55/common/PandR/M5option/tlu/u055lscee12bdh_CMAX.TLUPlus"  ;#  Max TLUplus file
set TLUPLUS_MIN_FILE              "/data/PDK/UMC/UMC55/common/PandR/M5option/tlu/u055lscee12bdh_CMIN.TLUPlus"  ;#  Min TLUplus file

set MIN_ROUTING_LAYER            "ME2"   ;# Min routing layer
set MAX_ROUTING_LAYER            "ME4"   ;# Max routing layer

set LIBRARY_DONT_USE_FILE        "${SCRIPTS_DIR}/dc_dont_use.tcl"   ;# Tcl file with library modifications for dont_use

##########################################################################################
# Multivoltage Common Variables
#
# Define the following multivoltage common variables for the reference methodology scripts 
# for multivoltage flows. 
# Use as few or as many of the following definitions as needed by your design.
##########################################################################################

set PD1                          ""           ;# Name of power domain/voltage area  1
set VA1_COORDINATES              {}           ;# Coordinates for voltage area 1
set MW_POWER_NET1                "VDD1"       ;# Power net for voltage area 1

set PD2                          ""           ;# Name of power domain/voltage area  2
set VA2_COORDINATES              {}           ;# Coordinates for voltage area 2
set MW_POWER_NET2                "VDD2"       ;# Power net for voltage area 2

set PD3                          ""           ;# Name of power domain/voltage area  3
set VA3_COORDINATES              {}           ;# Coordinates for voltage area 3
set MW_POWER_NET3                "VDD3"       ;# Power net for voltage area 3

set PD4                          ""           ;# Name of power domain/voltage area  4
set VA4_COORDINATES              {}           ;# Coordinates for voltage area 4
set MW_POWER_NET4                "VDD4"       ;# Power net for voltage area 4

puts "RM-Info: Completed script [info script]\n"

# Remove messages
suppress_message LINK-17
suppress_message MWLIBP-300
suppress_message MWLIBP-301
suppress_message MWLIBP-319
suppress_message MWLIBP-319
suppress_message MWLIBP-324
suppress_message MWLIBP-311
suppress_message MWLIBP-032
suppress_message UCN-1
suppress_message UID-282
