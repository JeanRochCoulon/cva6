..
   Copyright 2021 Thales DIS design services SAS
   Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   SPDX-License-Identifier: Apache-2.0 WITH SHL-2.0
   You may obtain a copy of the License at https://solderpad.org/licenses/

   Original Author: Jean-Roch COULON (jean-roch.coulon@thalesgroup.com)

.. _FRONTEND:
.. _instruction-fetch:

FRONTEND Sub-system
===================

Decription
----------

FRONTEND implements the two first stages of the cva6 pipeline, PC gen and Fetch stages. PC gen stage is responsible for generating the next program counter housing a branch target buffer (BTB) and a branch history table (BHT) to speculate on the branch target address. Fetch stage implements the fetch FIFO which contains instructions fetched from memory.

The system is connected to:

* Subsystem INSTRUCTION CACHE
* subsystem DECODE

.. table:: FRONTENT interface signals
  :name: FRONTEND interface signals

  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | **Signal**                      | IO | **type**          | **Description**                                                                                          |
  +=================================+====+===================+==========================================================================================================+
  | ``clk_i``                       | in | logic             | System Clock                                                                                             |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rst_ni``                      | in | logic             | Asynchronous reset active low                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``flush_i``                     | in | logic             | Flush request for PCGEN                                                                                  |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``flush_bp_i``                  | in | logic             | flush branch prediction                                                                                  |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``debug_mode_i``                | in | logic             |                                                                                                          |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``boot_addr_i``                 | in | logic[VLEN-1:0]   |                                                                                                          |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``resolved_branch_i``           | in | bp_resolve_t      | Rom controller signaling a branch_predict                                                                |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``set_pc_commit_i``             | in | logic             | Take the PC from commit when flushing pipeline                                                           |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``pc_commit_i``                 | in | logic[VLEN-1:0]   | PC of instruction in commit when flushing pipeline                                                       |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``epc_i``                       | in | logic[VLEN-1:0]   | Exception PC which we need to return to                                                                  |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``eret_i``                      | in | logic             | Return from exception                                                                                    |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``trap_vector_base_i``          | in | logic[VLEN-1:0]   | Base of trap vector                                                                                      |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``ex_valid_i``                  | in | logic             | Exception is valid - from commit                                                                         |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``set_debug_pc_i``              | in | logic             | Jump to debug address                                                                                    |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``icache_dreq_o``               | out| icache_dreq_i_t   | Exception is valid - from commit                                                                         |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``icache_dreq_i``               | in | icache_dreq_o_t   | Exception is valid - from commit                                                                         |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``fetch_entry_o``               | out| fetch_entry_t     | Fetch entry containing relevant data for DECODE                                                          |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``fetch_entry_valid_o``         | out| logic             | Instruction in IF is valid                                                                               |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``fetch_entry_ready_i``         | in | logic             | ID acknowledged this instruction                                                                         |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+


Functionalities
---------------

PC gen to generate the next program counter.

All program counters are logical addressed. If the logical to physical mapping changes a fence.vm instruction should flush the pipeline and TLBs.

This stage contains speculation on the branch target address. It houses the branch target buffer (BTB) and a branch history table (BHT). If the BTB decodes a certain PC as a jump the BHT decides if the branch is taken or not.

The next PC can originate from the following sources (listed in order of precedence):

* **Default assignment:** The default assignment is to fetch PC + 4. PC Gen always fetches on a word boundary (32-bit). Compressed instructions are handled in a later pipeline step.

* **Branch Predict:** If the BHT and BTB predict a branch on a certain PC, PC Gen sets the next PC to the predicted address and also informs the IF stage that it performed a prediction on the PC. This is needed in various places further down the pipeline (for example to correct prediction). Branch information which is passed down the pipeline is encapsulated in a structure called branchpredict_sbe_t. In contrast to branch prediction information which is passed up the pipeline which is just called bp_resolve_t. This is used for corrective actions (see next bullet point). This naming convention should make it easy to detect the flow of branch information in the source code.

* **Control flow change request:** A control flow change request occurs from the fact that the branch predictor mis-predicted. This can either be a 'real' mis-prediction or a branch which was not recognized as one. In any case we need to correct our action and start fetching from the correct address.

* **Return from environment call:** A return from an environment call performs corrective action of the PC in terms of setting the successive PC to the one stored in the [m|s]epc register.

* **Exception/Interrupt:** If an exception (or interrupt, which is in the context of RISC-V systems quite similar) occurs PC Gen will generate the next PC as part of the trap vector base address. The trap vector base address can be different depending on whether the exception traps to S-Mode or M-Mode (user mode exceptions are currently not supported). It is the purpose of the CSR Unit to figure out where to trap to and present the correct address to PC Gen.

* **Pipeline Flush because of CSR side effects:** When a CSR with side-effects gets written we need to flush the whole pipeline and start fetching from the next instruction again in order to take the up-dated information into account (for example virtual memory base pointer changes).

* **Debug:** Debug has the highest order of precedence as it can interrupt any control flow requests. It also the only source of control flow change which can actually happen simultaneously to any other of the forced control flow changes. The debug unit reports the request to change the PC and the PC which the CPU should change to. (not supported in cv32a6-step1)

[TO BE CLARIFIED] This unit also takes care of a signal called fetch_enable which purpose is to prevent fetching if not asserted.

Also note that no flushing takes place in this unit. All the flush information is distributed by the controller. Actually the controller's only purpose is to flush different pipeline stages.


Architecture and Modules
------------------------

