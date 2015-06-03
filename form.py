#!/usr/bin/env python
# -*- coding: utf-8 -*-
NBEST = 2
with open('test.txt','r') as fin,open('test.txt_'+ str(NBEST) , 'w') as fout:
    for line in fin:
        line = line.rstrip().split(' ')
        lineNo = int(line[0]) //NBEST
        content = ' '.join(line[1:])
        fout.write("{0} {1}\n".format(lineNo,content)) 
