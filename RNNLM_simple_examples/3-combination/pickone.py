import numpy as np
import sys
NBEST = 5
if __name__ == "__main__":
    with open ("scores_"+ sys.argv[2] + "/model"+sys.argv[1]+".score.txt",'r') as score,\
         open("scores_hw3/" + sys.argv[1] + ".candidate",'w') as record:
         for line,score in enumerate(score,1):
            if(line == 1):
                 best_score = -1000.0
            if(float(score) > best_score):
                best_score = float(score)
                best = line % NBEST

            #Need Record
            if(line % NBEST == 0):
                if best == 0:
                    best = 5
                best_score = -1000.0
                candidate = chr(ord('a')-1+best)
                record.write("{},{}\n".format((line//NBEST),candidate))
