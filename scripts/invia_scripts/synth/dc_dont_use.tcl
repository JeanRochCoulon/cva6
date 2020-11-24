echo ""
echo "******* DONT USE CELLS "
#########################################################################################################  *CLKGT*
echo "**** set_dont_use the following cells" 

if {$techno == "ALTIS130"} {
  echo "     FORBIDDEN Cells : *3Q*"
  set_dont_use $lib_name/*3Q*
}

if {$techno == "GSMC13"} {
  echo "**** set_dont_use the following cells" 
  echo "     FORBIDDEN Cells : *RSLAT* *HOLD* *PULL* *TIE* *FF*SR* *SPG*"
  echo "     FORBIDDEN Cells : *UX *16X *20X *30X *40X *80X"
  set_dont_use $lib_name/*FF*SR*
  set_dont_use $lib_name/*SPG*
  set_dont_use $lib_name/*16X
  set_dont_use $lib_name/*20X
  set_dont_use $lib_name/*30X
  set_dont_use $lib_name/*40X
  set_dont_use $lib_name/*80X
  set_dont_use $lib_name/*UX
  set_dont_use $lib_name/*RSLAT*
  set_dont_use $lib_name/*HOLD*
  set_dont_use $lib_name/*PULL*
  set_dont_use $lib_name/*DEL*
  #Following lines are not for backend
  set_dont_use $lib_name/*INVCLK*
  set_dont_use $lib_name/*BUFCLK*
  set_dont_use $lib_name/*TIE*
}

if {$techno == "UMC55HVT"} {
  echo "**** set_dont_use the following cells" 
  echo "     FORBIDDEN Cells : *BHD *DEL* *CKINV* *CKBUF* *TIE* "
  echo "     FORBIDDEN Cells : *M32UM -> *M48UM "
  foreach_in_collection lib [get_lib u055l*] {
    set lib_name [get_object_name $lib]
    set_dont_use $lib_name/*M32UM  
    set_dont_use $lib_name/*M40UM
    set_dont_use $lib_name/*M48UM
    set_dont_use $lib_name/*DEL*
    #Following lines are not for backend
    set_dont_use $lib_name/*CKINV*
    set_dont_use $lib_name/*CKBUF*
    set_dont_use $lib_name/*TIE*
  }
}

if {$techno == "ST28"} {
  echo "**** set_dont_use the following cells" 
  foreach_in_collection lib [get_lib C28SOI*] {
    set lib_name [get_object_name $lib]
  }
}


echo ""
#########################################################################################################
