"""date 2020/03/23
author JRC
"""

def process_elf(FILE_R, FILE_W):

  with open(FILE_W, 'w') as fout:
    with open(FILE_R, 'r') as fin:
      for l in fin:
        data=[]
        tmp=l.split(' ')
        for i in range(len(tmp)):
          tmp0=tmp[i].split('\n')
          if tmp0[0]!='': 
            if i==0: address=tmp0[0]
            else: data.append(tmp0[0])
        for i in range(8):
		  if len(data)<i+1: data.append('0000')
        fout.write("{}{}{}{}\n{}{}{}{}\n".format(data[3],data[2],data[1],data[0],data[7],data[6],data[5],data[4]))
    fin.close()
  fout.close()

if __name__ == "__main__":
    process_elf("hexdump.txt", "sram_image.mem")
