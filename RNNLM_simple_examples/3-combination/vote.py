import operator
import sys

DATA_PATH = "scores_"+ sys.argv[1] +"/"
class Eachline:
    def __init__(self):
        self.scoresDic = {'a':0,'b':0,'c':0,'d':0,'e':0}
    def __str__(self):
        return "{}".format(self.scoresDic)
#=======================================================

#set vote
ans = [Eachline() for _ in range(1040)]
for i in range(1,10):
    with open(DATA_PATH + '/' + str(i) + '.candidate','r') as candidate:
        for line in candidate:
            s = line.rstrip().split(',')
            ans[int(s[0]) -1 ].scoresDic[s[1]] +=1

#begin vote
with open(DATA_PATH + '/' + "123456789voting",'w') as fout:
    for i in range(1040):
        best = max(ans[i].scoresDic.items(), key=operator.itemgetter(1))[0]
        fout.write("{},{}\n".format(i+1,best))

