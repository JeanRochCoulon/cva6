"""date 2019/09/10
author JRC
"""

def process_elf(FILE):
    print(FILE)
    flag=0
    block={}
    with open(FILE, 'r') as fin:
      for l in fin:
        if 'Hierarchical cell' in l: flag=1
        if flag==1:
          tmp=l.split(' ')
          ipname=tmp[0]
          if (ipname.count('/')==0 or
              (ipname.count('/')==1 and 'ex_stage_i' in ipname) or
              (ipname.count('/')==1 and 'i_cache_subsystem' in ipname and 'stream' not in ipname) or
              (ipname.count('/')==1 and 'issue_stage_i' in ipname) or
              (ipname.count('/')==2 and 'ex_stage_i' in ipname) or
              ('i_issue_read_operands' in ipname)):
            for i in range(1,len(tmp)):
              if tmp[i]!='':
                ipgate=tmp[i]
                if '.' in ipgate and 'Total' not in ipname:
                  ipgate=ipgate.split('.')
                  print('{:50} {:.0f} kg'.format(ipname, int(ipgate[0])/0.985/1000))
                  block[ipname]=int(int(ipgate[0])/0.985/1000)
                break
    fin.close()

if __name__ == "__main__":
    areaFile='./reports/8/ariane/s8_top_UMC55HVTWC_synth_area.rpt'
    process_elf(FILE=areaFile)
