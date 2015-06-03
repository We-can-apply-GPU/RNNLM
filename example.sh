#!/bin/bash

#This is simple example how to use rnnlm tool for training and testing rnn-based language models
#Check 'example.output' how the output should look like
#SRILM toolkit must be installed for combination with ngram model to work properly

make clean
make

rm -f model
rm -f model.output.txt

#rnn model is trained here
time ./rnnlm -train train -valid valid -rnnlm model -hidden 15 -rand-seed 1 -debug 2 -class 100 -bptt 4 -bptt-block 10 -direct-order 3 -direct 2 -binary

#ngram model is trained here, using SRILM tools
srilm/lm/bin/i686/ngram-count -text train -order 5 -lm templm -kndiscount -interpolate -gt3min 1 -gt4min 1
srilm/lm/bin/i686//ngram -lm templm -order 5 -ppl test -debug 2 > temp.ppl

gcc convert.c -O2 -o convert
./convert <temp.ppl >srilm.txt

#combination of both models is performed here
time ./rnnlm -rnnlm model -test test -lambda 0.5 -gen 100