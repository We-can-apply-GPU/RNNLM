import sys
with open("scores_hw3/" + sys.argv[1],'r') as candidate,\
     open('ans','r') as ans:
         accus = 0
         for line1,line2 in zip(candidate,ans):
             if line1==line2:
                 accus+=1
print("{0}'s accurracy : {1}".format(sys.argv[1],float(accus)/1040))

