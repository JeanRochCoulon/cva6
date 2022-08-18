=========================
CV32A6-step1 design specification
=========================

Revision 0.1

.. __license:

License
=======

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

.. __introduction:

Introduction
============
CVA6 is a 6-stage in-order and single issue processor core which implements the RISC-V instruction set. CVA6 can be configured as a 32- or 64-bit core (RV32 or RV64), called CV32A6 or CV64A6. The purpose of this document is to describe a CV32A6 configuration with CV-X-IF without Linux support, called CV32A6-step1.

This document is dedicated to designers and verificators.


Processor Overview
==================
CV32A6-step1 implements extensions as specified in Volume I: User-Level ISA V 2.1 as well as the privilege extension 1.10.

CV32A6-step1 implements the following configuration:

- RV32i

- M extension

- C extension

- No A extension

- No F and no D extensions

- Privilege modes: M, S and U

- Coprocessor interface, called CV-X-IF

- Instruction cache

- No Data cache

- No MMU

- No memory protection unit, called PMP

- No register renaming, called Remane

- No performance counters


Frontend
========

Description
-----------

Functionalities
---------------

Architecture and Modules
------------------------


Id_stage
========

Description
-----------

Functionalities
---------------

Architecture and Modules
------------------------


Issue_stage
===========

Description
-----------

Functionalities
---------------

Architecture and Modules
------------------------


Ex_stage
========

Description
-----------

Functionalities
---------------

Architecture and Modules
------------------------


Commit_stage
============

Description
-----------

Functionalities
---------------

Architecture and Modules
------------------------


CSR_stage
=========


Description
-----------

Functionalities
---------------

Architecture and Modules
------------------------

Registers
---------


Controller
==========

Description
-----------

Functionalities
---------------

Architecture and Modules
------------------------


Cache_subsystem
===============

Description
-----------

Functionalities
---------------

Architecture and Modules
------------------------


Perf_counter
============

[To be documented]
