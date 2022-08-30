..
   Copyright 2022 Thales DIS design services SAS
   Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   SPDX-License-Identifier: Apache-2.0 WITH SHL-2.0
   You may obtain a copy of the License at https://solderpad.org/licenses/

   Original Author: Jean-Roch COULON (jean-roch.coulon@thalesgroup.com)

.. _decode:

DECODE Sub-System
=================

Description
-----------

CV32A6-step1 decodes the following instructions coming fron the FRONTEND sub-system to send the information to the ISSUE sub-system:
* As requested by [ISA-20] of [CVA6req], RV32I base instruction set, version 2.1
* As requested by [ISA-30] of [CVA6req], M extension (integer multiply and divide), version 2.0
* As requested by [ISA-80] of [CVA6req], C extension (compressed instructions), version 2.0
* As requested by [ISA-90] of [CVA6req], Zicsr extension (CSR instructions), version 2.0
* As requested by [ISA-100] of [CVA6req], Zifencei extension, version 2.0



Functionality
-------------

Architecture and Modules
------------------------

Registers
---------
