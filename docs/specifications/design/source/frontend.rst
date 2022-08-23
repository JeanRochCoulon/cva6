..
   Copyright 2021 Thales DIS design services SAS
   Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   SPDX-License-Identifier: Apache-2.0 WITH SHL-2.0
   You may obtain a copy of the License at https://solderpad.org/licenses/

   Original Author: Jean-Roch COULON (jean-roch.coulon@thalesgroup.com)

.. _frontend:
.. _instruction-fetch:

FRONTEND Sub-System
===================

Description
-----------

FRONTEND implements the two first stages of the cva6 pipeline, PC gen
and Fetch stages. PC gen stage is responsible for generating the next
program counter housing a branch target buffer (BTB) and a branch history
table (BHT) to speculate on the branch target address. PC gen can be
flushed by CONTROLLER.

The system is connected to:

* CACHES Sub-System: Fetch stage provides address to be fetched to the CACHES sub-system and retrieves the fetched data.
* DECODE Sub-System: Fetch stage provides instructions to the DECODE sub-system.
* CONTROLLER Sub-System: CONTROLLER can flush PC gen

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


Functionality
-------------

PC Generation stage
~~~~~~~~~~~~~~~~~~~

PC gen to generate the next program counter.

All program counters are logical addressed. If the logical to physical mapping changes a fence.vm instruction should flush the pipeline and TLBs.

This stage contains speculation on the branch target address. It houses the branch target buffer (BTB), a branch history table (BHT) and a Return Address Stack (RAS).

The next PC can originate from the following sources (listed in order of precedence):

* **Reset state:** At reset, the PC is assigned to a constant.

* **Branch Predict:** Branch can be predicted in the following cases: JALR instruction is pre-decoded and BTB speculates a PC jump, Branch instruction is pre-decoded and BTH speculates a PC jump, RET instruction is pre-decoded and RAS speculates the target address. In that case, PC Gen sets the next PC to the predicted address and also informs the Fetch stage that it performed a prediction on the PC.

* **Default assignment:** The default assignment is to fetch PC + 4. PC Gen always fetches on a word boundary (32-bit). Compressed instructions are handled in a later pipeline step.

* **Control flow change request:** A control flow change request occurs from the fact that the branch predictor mis-predicted. This can either be a 'real' mis-prediction or a branch which was not recognized as one. In any case we need to correct our action and start fetching from the correct address.

* **Replay instruction fetch:** The instruction queue is full, the fetch need to be replayed.

* **Return from environment call:** A return from an environment call performs corrective action of the PC in terms of setting the successive PC to the one stored in the [m|s]epc register.

* **Exception/Interrupt:** If an exception (or interrupt, which is in the context of RISC-V systems quite similar) occurs PC Gen will generate the next PC as part of the trap vector base address. The trap vector base address can be different depending on whether the exception traps to S-Mode or M-Mode (user mode exceptions are currently not supported). It is the purpose of the CSR Unit to figure out where to trap to and present the correct address to PC Gen.

* **Pipeline Flush because of CSR side effects:** When a CSR with side-effects gets written we need to flush the whole pipeline and start fetching from the next instruction again in order to take the up-dated information into account (for example virtual memory base pointer changes).

* **Debug:** Debug has the highest order of precedence as it can interrupt any control flow requests. It also the only source of control flow change which can actually happen simultaneously to any other of the forced control flow changes. The debug unit reports the request to change the PC and the PC which the CPU should change to. (not supported in cv32a6-step1)

[TO BE CLARIFIED] This unit also takes care of a signal called fetch_enable which purpose is to prevent fetching if not asserted.


Fetch Stage
~~~~~~~~~~~

PC generation stage asks the CACHE sub-system the memory fetch corresponding to the next PC.

Instruction Fetch stage inputs come from PC Gen stage. Inputs include information about branch prediction (was it a predicted branch? which is the target address? was it predicted to be taken?), current PC (word-aligned if it was a consecutive fetch) and whether this request is valid.

The Fetch stage asks the MMU to translate the requested address and controls the I$ (or just an instruction memory) interface. It requests for a memory fetch corresponding to PC next address to CACHE sub-system. An handshake protocol allows to signal the CACHES interfcace that a memory fetch is requested. Depending on the cache’s state this request may be granted or not. A granted fetch is pushed into an internal FIFO called instruction queue (instr_queue). It needs to do so as it has to know at any point in time how many transactions are outstanding. This is mostly due to the fact that instruction fetch happens on a very speculative basis because of branch prediction. It can always be the case that the controller decides to flush the instruction fetch stage in which case it needs to discard all outstanding transactions.

The fetch stage receives the response from the memory. Data coming from memory are written in the Fetch FIFO.

Memory and MMU can feedback potential exceptions generated by the memory fetch request. They can be bus errors, invalid accesses or instruction page faults.

Flush
~~~~~

CONTROLLER sub-system can flush PC Generation and Fetch stages. In that case, Fetch FIFO is reset.



Architecture and Modules
------------------------

.. figure:: ../images/frontend_modules.png
   :name: FRONTEND modules
   :align: center
   :alt:

   FRONTEND modules


Instr_realign
~~~~~~~~~~~~~

**Ports**

  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+
  | **Signal**                      | IO | **type**           | **Description**                                                                                          |
  +=================================+====+====================+==========================================================================================================+
  | ``clk_i``                       | in | logic              | System Clock                                                                                             |
  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+
  | ``rst_ni``                      | in | logic              | Asynchronous reset active low                                                                            |
  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+
  | ``flush_i``                     | in | logic              | Flush request                                                                                            |
  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+
  | ``valid_i``                     | in | logic              | 32-bits block coming from CACHE is valid                                                                 |
  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+
  | ``serving_unaligned_o``         | out| logic              |                                                                                                          |
  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+
  | ``address_i``                   | in | logic[VLEN-1:0]    | 32-bits block address coming from CACHE                                                                  |
  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+
  | ``data_i``                      | in | logic [31:0]       | 32-bit block data coming from CACHE                                                                      |
  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+
  | ``valid_o``                     | out| logic [1:0]        | instruction going to instr_queue is valid                                                                |
  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+
  | ``addr_o``                      | out|logic[1:0][VLEN-1:0]| Instruction address going to instr_queue                                                                 |
  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+
  | ``instr_o``                     | out| logic [1:0][31:0]  | Instruction going to instr_queue                                                                         |
  +---------------------------------+----+--------------------+----------------------------------------------------------------------------------------------------------+


**Functionality**

The 32-bit aligned cache block coming from the CACHE sub-system enters the instr_realign module. This module extracts the instructions from the 32-bit blocks, up to two instructions because it is possible to fetch two instructions when C extension is used. If the instructions are not compressed, it is possible that the instruction is not aligned on the block size but rather interleaved with two cache blocks. In that case, two cache accesses are needed. The instr_realign module provides at maximum one instruction per cycle. Not complete instruction is stored in instr_realign module to be provided in the next cycles.


Instr_queue
~~~~~~~~~~~

**Ports**

  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | **Signal**                      | IO | **type**          | **Description**                                                                                          |
  +=================================+====+===================+==========================================================================================================+
  | ``clk_i``                       | in | logic             | System Clock                                                                                             |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rst_ni``                      | in | logic             | Asynchronous reset active low                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``flush_i``                     | in | logic             | Flush request                                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``instr_i``                     | in | [1:0][31:0]       | Instruction coming from instr_realign                                                                    |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``addr_i``                      | in | [1:0][VLEN-1:0]   | Instruction address coming from instr_realign                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``valid_i``                     | in | [1:0]             | Instruction coming from instr_realign is valid                                                           |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``ready_o``                     | out| logic             | Instruction going to DECODE is ready                                                                     |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``consumed_o``                  | out| [1:0]             |                                                                                                          |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``exception_i``                 | in | logic             |                                                                                                          |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``exception_addr_i``            | in | logic[VLEN-1:0]   |                                                                                                          |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``predict_address_i``           | in | logic[VLEN-1:0]   | Predict address linked to instruction                                                                    |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``cf_type_i``                   | in | logic[1:0]        | Control flow instruction type                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``replay_o``                    | out| logic             | Replay instruction because one of the FIFO was already full                                              |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``replay_addr_o``               | out| logic[VLEN-1:0]   | Address at which to replay this instruction                                                              |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``fetch_entry_o``               | out| fetch_entry_t     | fetched instruction going to DECODE                                                                      |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``fetch_entry_valid_o``         | out| logic             | fetched instruction going to DECODE is valid                                                             |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``fetch_entry_ready_i``         | in | logic             | DECODE is ready to receive instruction                                                                   |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+


**Functionality**

The instr_queue creates a valid stream of instructions to be decoded (by the decode stage), to be issued (by the issue stage) and executed (by the execute stage). FRONTEND pushes instructions and target addresses that will change the control flow into a FIFO. DECODE pops them when decode stage is ready.

In the case the FIFO is full, a replay request is sent to inform the fetch mechanism to replay the fetch.

[TO BE CLARIFIED] In case of flush ?

[TO BE CLARIFIED] Exception ?

[TO BE CLARIFIED] consumed_o ?


Instr_scan
~~~~~~~~~~

**Ports**

  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | **Signal**                      | IO | **type**          | **Description**                                                                                          |
  +=================================+====+===================+==========================================================================================================+
  | ``instr_i``                     | in | logic[31:0]       | Instruction to be predecoded                                                                             |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvi_return_o``                | out| logic             | Return instruction                                                                                       |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvi_call_o``                  | out| logic             | JAL instruction                                                                                          |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvi_branch_o``                | out| logic             | Branch instruction                                                                                       |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvi_jalr_o``                  | out| logic             | JALR instruction                                                                                         |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvi_jump_o``                  | out| logic             | unconditional jump instruction                                                                           |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvi_imm_o``                   | out| logic[VLEN-1:0]   | Instruction immediat                                                                                     |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvc_branch_o``                | out| logic             | Branch compressed instruction                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvc_jump_o``                  | out| logic             | unconditional jump compressed instruction                                                                |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvc_jr_o``                    | out| logic             | JR compressed instruction                                                                                |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvc_return_o``                | out| logic             | Return compressed instruction                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvc_jalr_o``                  | out| logic             | JALR compressed instruction                                                                              |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvc_call_o``                  | out| logic             | JAL compressed instruction                                                                               |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rvc_imm_o``                   | out| logic[VLEN-1:0]   | Instruction compressed immediat                                                                          |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+


**Functionality**

The instr_scan module pre-decodes the fetched instructions, instructions could be compressed or not. The outputs are used by the branch prediction feature. The instr_scan module tells if the instruction is compressed and provides the intruction type: branch, jump, return, jalr, imm, call or others.


BHT - Branch History Table
~~~~~~~~~~~~~~~~~~~~~~~~~~

**Ports**

  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | **Signal**                      | IO | **type**          | **Description**                                                                                          |
  +=================================+====+===================+==========================================================================================================+
  | ``clk_i``                       | in | logic             | System Clock                                                                                             |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rst_ni``                      | in | logic             | Asynchronous reset active low                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``flush_i``                     | in | logic             | Flush request                                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``debug_mode_i``                | in | logic             |                                                                                                          |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``vpc_i``                       | in | logic[VLEN-1:0]   | Virtual PC from fetch stage                                                                              |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``bht_update_i``                | in | bht_update_t      | Update btb with this information                                                                         |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``bht_prediction_o``            | out| bht_prediction_t  | Prediction from bht                                                                                      |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+


**Functionality**

When a branch instruction is valid, the relative information is stored in the Branch History Table.

The Branch History table is a two-bit saturation counter that takes the virtual address of the current fetched instruction by the CACHE. It states whether the current branch request should be taken or not. The two bit counter is updated by the successive execution of the current instructions as shown in the following figure.

.. figure:: ../images/bht.png
   :name: BHT saturation
   :align: center
   :alt:

   BHT saturation

When a branch instruction is detected, the BHT informs whether the PC address is in the BHT. In this case, the BHT predicts whether the branch is taken and provides the corresponding target address.

The BHT can be flushed.


BTB - Branch Target Buffer
~~~~~~~~~~~~~~~~~~~~~~~~~~

**Ports**

  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | **Signal**                      | IO | **type**          | **Description**                                                                                          |
  +=================================+====+===================+==========================================================================================================+
  | ``clk_i``                       | in | logic             | System Clock                                                                                             |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rst_ni``                      | in | logic             | Asynchronous reset active low                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``flush_i``                     | in | logic             | Flush request                                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``debug_mode_i``                | in | logic             |                                                                                                          |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``vpc_i``                       | in | logic             | Virtual PC from fetch stage                                                                              |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``btb_update_i``                | in | btb_update_t      | Update btb with this information                                                                         |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``btb_prediction_o``            | out| btb_prediction_t  | Prediction from btb                                                                                      |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+


**Functionality**

When a miss prediction happens on a unconditional jumps to a register (JALR instruction), the relative information provided by the EXECUTE stage is logged into the BTB, that is to say the JALR pc and the target address.

The BTB informs whether the input PC address is in BTB. In this case, the BTB provides the corresponding target address.

The BTB can be flushed.



RAS - Return Address Stack
~~~~~~~~~~~~~~~~~~~~~~~~~~

**Ports**

  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | **Signal**                      | IO | **type**          | **Description**                                                                                          |
  +=================================+====+===================+==========================================================================================================+
  | ``clk_i``                       | in | logic             | System Clock                                                                                             |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``rst_ni``                      | in | logic             | Asynchronous reset active low                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``flush_i``                     | in | logic             | Flush request                                                                                            |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``push_i``                      | in | logic             | Push new address in RAS                                                                                  |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``pop_i``                       | in | logic             | Pop address from RAS                                                                                     |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``data_i``                      | in | logic[VLEN-1:0]   | Data to be pushed                                                                                        |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+
  | ``data_o``                      | out| ras_t             | Popped data                                                                                              |
  +---------------------------------+----+-------------------+----------------------------------------------------------------------------------------------------------+


**Functionality**

When the instruction is an unconditional jumps to a known target address (JAL instruction), the next pc after the JAL instruction and the return address are logged into the RAS.

The RAS informs whether the input PC address is logged in RAS. In this case, the RAS provides the corresponding target address.

The RAS can be flushed.




