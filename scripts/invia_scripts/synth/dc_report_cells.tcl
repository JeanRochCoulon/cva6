# ------------------------------------------------------------------------------
#-                                                                            --
#-                      Copyright (C) 2012 INVIA                              --
#-                                                                            --
#-   All rights reserved. Reproduction in whole or part is prohibited         --
#-      without the written permission of the copyright owner                 --
#-                                                                            --
#-------------------------------------------------------------------------------
#- Author: N. VALETTE - INVIA
#- Revision : 
#- Date     : 
#- Description: TCL file used to report specific cells for ALTIS 130 techno
#-------------------------------------------------------------------------------




if {$techno == "ALTIS130"} {
echo "**** Report all positive edge flip-flops cells in ${top_design}_${techno}_${iter}_cells_FFs.log"
report_cell  [get_references -hierarchical *FD*] > $reports_dir/${top_design}_${techno}_${iter}_cells_FFs.log

echo "**** Report all negative edge flip-flops cells in ${top_design}_${techno}_${iter}_cells_FFs_neg.log"
report_cell  [get_references -hierarchical *FDN*] > $reports_dir/${top_design}_${techno}_${iter}_cells_FFs_neg.log

echo "**** Report all latch cells in ${top_design}_${techno}_${iter}_cells_LATCHES.log"
report_cell  [get_references -hierarchical *LAT*]    >> $reports_dir/${top_design}_${techno}_${iter}_cells_LATCHES.log

echo "**** Report all latch cells in ${top_design}_${techno}_${iter}_cells_CLKGATE.log"
report_cell  [get_references -hierarchical *CLKGT*]    >> $reports_dir/${top_design}_${techno}_${iter}_cells_CLKGATE.log

echo ""
echo "**** Report untypical cells in ${top_design}_${techno}_${iter}_BadCells.log"

echo "FORBIDDEN cells "                                > $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
echo "Reset/Set FFs cells: *FF*SR* "
echo "Reset/Set FFs cells: *FF*SR* "                  >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *FF*SR*]   >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "------- cells: *SPG* "
echo "------- cells: *SPG* "                          >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *SPG*]     >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "High driver cells : *UX *16X *20X *30X *40X *80X"
echo "High driver cells : *UX *16X *20X *30X *40X *80X" >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *UX]       >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *16X]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *20X]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *30X]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *40X]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *80X]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "RS latches: *RSLAT* "
echo "RS latches: *RSLAT* "                           >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *RSLAT*]   >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Bus keeper cells: *HOLD* "
echo "Bus keeper cells: *HOLD* "                      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *HOLD*]    >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Synchronizer cells: *PULL* "
echo "Synchronizer cells: *PULL* "                    >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *PULL*]    >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Load cells: *DEL* "
echo "Load cells: *DEL* "                             >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *DEL*]     >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Load cells: *TIE* "
echo "Load cells: *TIE* "                             >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *TIE*]     >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Diode cells:*ANTFIX* "
echo "Diode cells:*ANTFIX* "                          >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical ANTFIX*]  >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log


echo "Other cells: *FIL* "                          >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical FIL*]   >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

}

if {$techno == "UMC55HVT"} {


echo "**** Report all positive edge flip-flops cells in ${top_design}_${techno}_${iter}_cells_FFs.log"
report_cell  [get_references -hierarchical *DF*] > $reports_dir/${top_design}_${techno}_${iter}_cells_FFs.log

echo "**** Report all negative edge flip-flops cells in ${top_design}_${techno}_${iter}_cells_FFs_neg.log"
report_cell  [get_references -hierarchical *DFC*] > $reports_dir/${top_design}_${techno}_${iter}_cells_FFs_neg.log

echo "**** Report all latch cells in ${top_design}_${techno}_${iter}_cells_LATCHES.log"
report_cell  [get_references -hierarchical *LAM*]    >> $reports_dir/${top_design}_${techno}_${iter}_cells_LATCHES.log

echo "**** Report all latch cells in ${top_design}_${techno}_${iter}_cells_CLKGATE.log"
report_cell  [get_references -hierarchical *LAG*]    >> $reports_dir/${top_design}_${techno}_${iter}_cells_CLKGATE.log

echo ""
echo "**** Report untypical cells in ${top_design}_${techno}_${iter}_BadCells.log"

echo "FORBIDDEN cells "                                  > $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
echo "Reset/Set FFs cells: *DF*SR* "
echo "Reset/Set FFs cells: *DF*SR* "                    >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *DF*RS*]     >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "High driver cells : *UX *16X *20X *30X *40X *80X"
echo "High driver cells : *UX *16X *20X *30X *40X *80X" >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *M16UM]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *M18UM]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *M20UM]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *M22UM]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *M24UM]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *M26UM]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *M32UM]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *M40UM]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *M48UM]      >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Bus keeper cells: *BHD* "
echo "Bus keeper cells: *BHD* "                         >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *BHD*]       >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Well Tap cells: *PULL* "
echo "Well Tap cells: *PULL* "                          >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *WT*]        >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Delay cells: *DEL* "                             
echo "Delay cells: *DEL* "                              >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *DEL*]       >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Load cells: *TIE* "                              
echo "Load cells: *TIE* "                               >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical *TIE*]       >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Antenna cells:*ANT* "                            
echo "Antenna cells:*ANT* "                             >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical ANT*]        >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

echo "Other cells: *FIL* "                              >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log
report_cell  [get_references -hierarchical FIL*]        >> $reports_dir/${top_design}_${techno}_${iter}_BadCells.log

}


