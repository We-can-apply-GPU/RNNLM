import numpy as np
import sys
if __name__ == "__main__":
    with open ("nameList",'r') as namelist,\
         open (sys.argv[1],'r') as answers,\
         open ("OutLexicon",'r') as _sentences,\
         open ("output_" + sys.argv[1],'w') as output:
         sentences = _sentences.readlines()
         for name,_ans in zip(namelist,answers):
             name = name.rstrip()
             lala = _ans.rstrip().split(',')
             #print(lala)
             line = int(lala[0])-1
             ans = lala[1]
             print(5*line+(ord(ans)-ord('a')))
             output.write("{}".format(sentences[5*line+(ord(ans)-ord('a'))]))
