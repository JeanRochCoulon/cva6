#File automatically generated, do not edit !
sh rm -rf work
sh mkdir work
#Create library work
define_design_lib s8 -path work/s8

analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/riscv-dbg/src/dm_pkg.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../include/riscv_pkg.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../include/ariane_pkg.sv      
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../include/wt_cache_pkg.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../include/std_cache_pkg.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../tb/ariane_soc_pkg.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/axi/src/axi_pkg.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../include/ariane_axi_pkg.sv  
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../include/instr_tracer_pkg.sv  
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/register_interface/src/reg_intf_pkg.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../tb/ariane_peripherals.sv

#analyze -f sverilog -define WT_DCACHE -lib s8 ../../../include/axi_intf.sv        

analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/alu.sv                 
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/csr_buffer.sv           
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/mmu.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/amo_buffer.sv          
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/csr_regfile.sv          
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/multiplier.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/ariane_regfile_ff.sv   
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/decoder.sv              
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/mult.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/ariane_regfile.sv      
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/ex_stage.sv             
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/perf_counters.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/ariane.sv

analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/popcount.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/unread.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/rr_arb_tree.sv

analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/shift_reg.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/lfsr_8bit.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/miss_handler.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/stream_arbiter_flushable.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpga-support/rtl/SyncSpRamBeNx64.sv

analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/lzc.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/stream_demux.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/stream_mux.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/stream_arbiter.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/fifo_v3.sv

analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_pkg.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu_wrap.sv  
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_top.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_opgroup_block.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/include/common_cells/registers.svh
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_opgroup_fmt_slice.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_opgroup_multifmt_slice.sv
#analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_noncomp.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_fma.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_fma_multi.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_divsqrt_multi.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_noncomp.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_cast_multi.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_classifier.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpnew_rounding.sv
#analyze -f sverilog -define WT_DCACHE -lib s8 ../../../hard/ariane/synth/work/s8/defs_div_sqrt_mvp.pvk
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpu_div_sqrt_mvp/hdl/defs_div_sqrt_mvp.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpu_div_sqrt_mvp/hdl/nrbd_nrsc_mvp.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpu_div_sqrt_mvp/hdl/norm_div_sqrt_mvp.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpu_div_sqrt_mvp/hdl/div_sqrt_top_mvp.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpu_div_sqrt_mvp/hdl/preprocess_mvp.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpu_div_sqrt_mvp/hdl/control_mvp.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/fpu/src/fpu_div_sqrt_mvp/hdl/iteration_div_sqrt_mvp.sv

analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/ptw.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/axi_adapter.sv         
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/id_stage.sv             
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/re_name.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/axi_shim.sv            
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/instr_realign.sv        
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/scoreboard.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/branch_unit.sv         
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/issue_read_operands.sv  
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/serdiv.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/commit_stage.sv        
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/issue_stage.sv          
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/store_buffer.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/compressed_decoder.sv  
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/load_store_unit.sv      
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/store_unit.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/controller.sv          
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/load_unit.sv            
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/tlb.sv

analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/amo_alu.sv              
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/clint/axi_lite_interface.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/cache_ctrl.sv           
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/clint/clint.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/miss_handler.sv         
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/frontend/bht.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/std_cache_subsystem.sv  
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/frontend/btb.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/std_icache.sv           
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/frontend/frontend.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/common_cells/src/exp_backoff.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/std_nbdcache.sv         
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/frontend/instr_queue.sv
#analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/std_no_dcache.sv        
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/frontend/instr_scan.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/tag_cmp.sv              
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/frontend/ras.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/wt_axi_adapter.sv       
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/util/axi_master_connect_rev.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/wt_cache_subsystem.sv   
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/util/axi_master_connect.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/wt_dcache_ctrl.sv       
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/util/axi_slave_connect_rev.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/wt_dcache_mem.sv        
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/util/axi_slave_connect.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/wt_dcache_missunit.sv   
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/util/find_first_one.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/wt_dcache.sv            
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/util/instr_tracer_if.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/wt_dcache_wbuffer.sv    
#analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/util/instr_tracer.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/wt_icache.sv            
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/util/sram.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/wt_l15_adapter.sv

analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/pmp/src/pmp.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/pmp/src/pmp_entry.sv
analyze -f sverilog -define WT_DCACHE -lib s8 ../../../src/cache_subsystem/cva6_icache.sv
