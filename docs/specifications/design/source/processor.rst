..
   Copyright 2021 Thales DIS design services SAS
   Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   SPDX-License-Identifier: Apache-2.0 WITH SHL-2.0
   You may obtain a copy of the License at https://solderpad.org/licenses/

   Original Author: Jean-Roch COULON (jean-roch.coulon@thalesgroup.com)

.. _PROCESSOR:


Processor Overview
==================

Standards Compliance
--------------------

CV32A6-step1 is a standards-compliant 32-bit RISC-V processor.

| To ease the reading, the reference to these specifications can be implicit in the requirements below. For the sake of precision, the requirements identify the versions of RISC-V extensions from these specifications.
| **[RVunpriv]** “The RISC-V Instruction Set Manual, Volume I: User-Level ISA, Document Version 20191213”, Editors Andrew Waterman and Krste Asanović, RISC-V Foundation, December 13, 2019.
| **[RVpriv]** “The RISC-V Instruction Set Manual, Volume II: Privileged Architecture, Document Version 20211203”, Editors Andrew Waterman, Krste Asanović and John Hauser, RISC-V Foundation, December 4, 2021.
| **[RVdbg]** “RISC-V External Debug Support, Document Version 0.13.2”, Editors Tim Newsome and Megan Wachs, RISC-V Foundation, March 22, 2019.
| **[RVcompat]** “RISC-V Architectural Compatibility Test Framework”, https://github.com/riscv-non-isa/riscv-arch-test.
| **[AXI]** AXI Specification, https://developer.arm.com/documentation/ihi0022/hc.
| **[CV-X-IF]** Placeholder for the CV-X-IF coprocessor interface currently prepared at OpenHW Group; current version in https://docs.openhwgroup.org/projects/openhw-group-core-v-xif/.
| **[OpenPiton]** “OpenPiton Microarchitecture Specification”, Princeton University, https://parallel.princeton.edu/openpiton/docs/micro_arch.pdf.


Configuration
-------------

CV32A6-step1 supports the following configuration:

.. list-table:: CV32A6-step1 Configuration
   :header-rows: 1

   * - Standard Extension
     - Specification
     - Configurability

   * - **I**: RV32i Base Integer Instruction Set
     - [RVunpriv]
     - enabled

   * - **C**: Standard Extension for Compressed Instructions
     - [RVunpriv]
     - enabled

   * - **M**: Standard Extension for Integer Multiplication and Division
     - [RVunpriv]
     - enabled

   * - **A**: Standard Extension for Atomic transaction
     - [RVunpriv]
     - disabled

   * - **F and D**: Single and Double Precision Floating-Point
     - [RVunpriv]
     - disabled

   * - **Zicount**: Performance Counters
     - [RVunpriv]
     - disabled

   * - **Zicsr**: Control and Status Register Instructions
     - [RVpriv]
     - enabled

   * - **Zifencei**: Instruction-Fetch Fence
     - [RVunpriv]
     - enabled

   * - **Privilege**: Standard privilege modes M, S and U
     - [RVpriv]
     - enabled

   * - **SV39, SV32, SV0**: MMU capability
     - [RVpriv]
     - disabled

   * - **PMP**: Memory Protection Unit
     - [RVpriv]
     - disabled

   * - **CSR**: Support CSRs listed in :ref:`cs-registers`
     - [RVpriv]
     - enabled

   * - **CV-X-IF**: Coprocessor interface
     - [CV-X-IF]
     - enabled

   * - **I$**: Instruction cache micro-architecture
     - current spec
     - enabled

   * - **D$**: Data cache micro-architecture
     - current spec
     - disabled

   * - **Rename**: register Renaming micro-architecture to increase perf
     - current spec
     - disabled

   * - **Double Commit**: pipeline micro-architecture
     - current spec
     - enabled

   * - **BP**: Branch Prediction micro-architecture
     - current spec
     - static


Bus Interfaces
--------------

CVA6 memory interface complies with AXI5 specification including the Atomic_Transactions property support as defined in [AXI] section E1.1.

CVA6 coprocessor interface complies with CV-X-IF protocol specification as defined in [CV-X-IF].


Synthesis guidelines
--------------------

The CV32A4-step1 core is fully synthesizable.
It has been designed mainly for ASIC designs, but FPGA synthesis
is supported as well.

For ASIC synthesis, the whole design is completely
synchronous and uses positive-edge triggered flip-flops. The
core occupies an area of about 80 kGE.




