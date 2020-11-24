"""date 2020/02/20
author JRC
"""
import re
import os
import sys

def process_elf(FILE_RTL):
    
    #FILE_RTL preprocessing
    rtl=[]
    flag=0
    flag_mcause=0
    with open(FILE_RTL, 'r') as fin:
        for l in fin:
            if '0 core   0: 0x0000000080000000' in l: flag=1
            if flag==1:
                if 'core' in l:
                    tmp=l.split('core ')
                    rtl.append('core '+tmp[1])
                else:
                    rtl.append(re.sub(" \(0x[0]*", " (0x", l))				
            if flag_mcause: 
				rtl[-1]="mcause...\n"
				flag_mcause=0
            if "mcause" in l: flag_mcause=1
    fin.close()
       
    length=len(rtl)
    with open("python_rtl.txt", 'w') as fout:
        for i in range(length):
            fout.write(rtl[i])
    fin.close()
			
if __name__ == "__main__":
    print (os.getcwd())
    process_elf("trace_hart_00_invia.dasm.txt")
