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

- No Branch prediction

- Double commit

- CSR


FRONTEND
========

Description
-----------
FRONTEND implements the two first stages of the cva6 pipeline, PC gen and Fetch stages. PC gen stage is responsible for generating the next program counter housing a branch target buffer (BTB) and a branch history table (BHT) to speculate on the branch target address. Fetch stage implements the fetch FIFO which contains instructions fetched from memory. 

The system is connected to:

- Subsystem INSTRUCTION CACHE

- subsystem DECODE

Functionalities
---------------

PC gen to generate the next program counter.

All program counters are logical addressed. If the logical to physical mapping changes a fence.vm instruction should flush the pipeline and TLBs.

This stage contains speculation on the branch target address. It houses the branch target buffer (BTB) and a branch history table (BHT). If the BTB decodes a certain PC as a jump the BHT decides if the branch is taken or not.

The next PC can originate from the following sources (listed in order of precedence):

    Default assignment: The default assignment is to fetch PC + 4. PC Gen always fetches on a word boundary (32-bit). Compressed instructions are handled in a later pipeline step.

    Branch Predict: If the BHT and BTB predict a branch on a certain PC, PC Gen sets the next PC to the predicted address and also informs the IF stage that it performed a prediction on the PC. This is needed in various places further down the pipeline (for example to correct prediction). Branch information which is passed down the pipeline is encapsulated in a structure called branchpredict_sbe_t. In contrast to branch prediction information which is passed up the pipeline which is just called bp_resolve_t. This is used for corrective actions (see next bullet point). This naming convention should make it easy to detect the flow of branch information in the source code.

    Control flow change request: A control flow change request occurs from the fact that the branch predictor mis-predicted. This can either be a 'real' mis-prediction or a branch which was not recognized as one. In any case we need to correct our action and start fetching from the correct address.

    Return from environment call: A return from an environment call performs corrective action of the PC in terms of setting the successive PC to the one stored in the [m|s]epc register.

    Exception/Interrupt: If an exception (or interrupt, which is in the context of RISC-V systems quite similar) occurs PC Gen will generate the next PC as part of the trap vector base address. The trap vector base address can be different depending on whether the exception traps to S-Mode or M-Mode (user mode exceptions are currently not supported). It is the purpose of the CSR Unit to figure out where to trap to and present the correct address to PC Gen.

    Pipeline Flush because of CSR side effects: When a CSR with side-effects gets written we need to flush the whole pipeline and start fetching from the next instruction again in order to take the up-dated information into account (for example virtual memory base pointer changes).

    Debug: Debug has the highest order of precedence as it can interrupt any control flow requests. It also the only source of control flow change which can actually happen simultaneously to any other of the forced control flow changes. The debug unit reports the request to change the PC and the PC which the CPU should change to. (not supported in cv32a6-step1)

[TO BE CLARIFIED] This unit also takes care of a signal called fetch_enable which purpose is to prevent fetching if not asserted. 

Also note that no flushing takes place in this unit. All the flush information is distributed by the controller. Actually the controller's only purpose is to flush different pipeline stages.


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
