..
   Copyright 2021 Thales DIS design services SAS
   Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   SPDX-License-Identifier: Apache-2.0 WITH SHL-2.0
   You may obtain a copy of the License at https://solderpad.org/licenses/

   Original Author: Jean-Roch COULON (jean-roch.coulon@thalesgroup.com)

.. _INTRO:

Introduction
=============

CVA6 is a 6-stage in-order and single issue processor core which implements
the RISC-V instruction set. Many features in the RISC-V specification are
optional, and CVA6 can be parameterized to enable or disable some of them.
CVA6 can be configured as a 32- or 64-bit core
(RV32 or RV64), called CV32A6 or CV64A6. The purpose of this document is
to describe the CV32A6 configuration which allows to connect coprocessor
through CV-X-IF but without Linux support, called CV32A6-step1.


ISA. :numref:`blockdiagram` shows a block diagram of the core.

.. figure:: ../images/CV32E40P_Block_Diagram.png
   :name: blockdiagram
   :align: center
   :alt:

   Block Diagram of CV32E40P RISC-V Core


License
-------

| Copyright 2022 OpenHW Group and Thales
| Copyright 2018 ETH Zürich and University of Bologna
| SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
| Licensed under the Solderpad Hardware License v 2.1 (the “License”);
  you may not use this file except in compliance with the License, or,
  at your option, the Apache License version 2.0. You may obtain a copy
  of the License at https://solderpad.org/licenses/SHL-2.1/.
| Unless required by applicable law or agreed to in writing, any work
  distributed under the License is distributed on an “AS IS” BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
  implied. See the License for the specific language governing
  permissions and limitations under the License.


Framework
---------

The framework of this document is inspired by the Common Criteria. The
Common Criteria for Information Technology Security Evaluation (referred
to as Common Criteria or CC) is an international standard (ISO/IEC 15408)
for computer security certification. The objective of this document is to
provide enough information to allow the RTL modification (by designers)
and the RTL verification (by verificators).

Description of the framework:

* Processor is split into subsystem corresponding to the main modules of the design
* Subsystems can contain several modules
* Each subsystem is described in a chapter, which contains the following subchapters: “Description”, “Functionalities”, “Architecture and Modules” and Registers (if any)
* The subchapter “Description” describes the main features of the submodule, then the interconnections between the current subsystem and the others.
* The subchapter “Functionality” lists in details the subsystem functionalities. Please avoid using the RTL signal names to explain the functionalities.
* The subchapter “Architecture and Modules” provides a drawing to present the module hierarchy, then the functionalities covered by the module
* The subchapter “Registers” specifies the subsystem registers if any


Contributors
------------

| Jean-Roch Coulon
  (`*jean-roch.coulon@thalesgroup.com* <mailto:jean-roch.coulon@thalesgroup.com>`__)
| Jerome Quevremont
  (`*jerome.quevremont@thalesgroup.com* <mailto:jerome.quevremont@thalesgroup.com>`__)
| Florian Zaruba
  (`*florian@openhwgroup.org* <mailto:florian@openhwgroup.org>`__)

