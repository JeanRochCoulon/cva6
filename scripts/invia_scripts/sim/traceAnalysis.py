"""date 2020/02/20
author JRC
"""
import re
import os
import sys

def process_elf(FILE_SPIKE, FILE_RTL):
    
    #FILE_RTL preprocessing
    rtl=[]
    flag=0
    flag_mcause=0
    with open(FILE_RTL, 'r') as fin:
        for l in fin:
            if '0: 0x0000000080000000' in l and 'core' in l: flag=1
            if flag==1 and 'mem' not in l:
                if 'core' in l:
                    tmp=l.split('core ')
                    rtl.append('core '+tmp[1])
                else:
                    rtl.append(re.sub(" \(0x[0]*", " (0x", l))				
            #if flag_mcause: 
				#rtl[-1]="mcause...\n"
			#	flag_mcause=0
            #if "mcause" in l: flag_mcause=1
    fin.close()
   
    #FILE_SPIKE preprocessing
    spike=[]
    flag=0
    flag_mcause=0
    with open(FILE_SPIKE, 'r') as fin:
        for l in fin:
            if '0: 0x0000000080000000' in l: flag=1
            if flag==1:
                if 'core' in l:
                     spike.append(l)
                else:
                    tmp=re.sub(" mem .*", "", l)    #TODO: compare memory access 
                    spike.append(re.sub(" \(0x[0]*", " (0x", tmp))		
            #if flag_mcause: 
				#spike[-1]="mcause...\n"
			#	flag_mcause=0
            #if "mcause" in l: flag_mcause=1
    fin.close()
    
    length=min(len(rtl),len(spike))
    with open("python_spike.txt", 'w') as fout:
        for i in range(length):
            fout.write(spike[i])
    fin.close()
    with open("python_rtl.txt", 'w') as fout:
        for i in range(length):
            fout.write(rtl[i])
    fin.close()
    fail=0
    for i in range(length):
        rtl0=rtl[i]
        if "exception    11" in rtl0: 
          rtl0=re.sub("exception    11", "exception trap_machine_ecall", rtl0)
        if spike[i]!=rtl0: 
          fail=1
          print(spike[i], rtl0)
    print('input files: '+FILE_SPIKE+', '+FILE_RTL)
    print('compared files: python_spike.txt, python_rtl.txt')
    if fail: 
      print("*** Spike Vs RTL compare : FAIL ***\n")
      sys.exit(1)
    else: 
      print("*** Spike Vs RTL compare : SUCCESS ***\n")
      sys.exit(0)

			

if __name__ == "__main__":
    print (os.getcwd())
    process_elf("trace_spike.txt", "trace_hart_00_invia.dasm.txt")
