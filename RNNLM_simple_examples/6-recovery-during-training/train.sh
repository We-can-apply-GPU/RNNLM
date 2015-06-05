#!/bin/bash

rnnpath=../..
srilm_path=../../srilm/lm/bin/i686
trainfile=../../data/train_hw3
validfile=../../data/valid_hw3
testfile=../../data/test_hw3
rnnmodel=../../models/model_6
temp=../../temp

hidden_size=100
class_size=100
bptt_steps=4

#################################
# CHECK FOR 'rnnlm' AND 'convert'
#################################

if [ ! -e $rnnpath/rnnlm ]; then
    make clean -C $rnnpath
    make -C $rnnpath
fi

if [ ! -e $rnnpath/rnnlm ]; then
    echo "Cannot compile rnnlm tool";
    exit
fi

if [ ! -e $rnnpath/convert ]; then
    gcc $rnnpath/convert.c -O2 -o $rnnpath/convert
fi

#################################################
# IF MODEL FILE ALREADY EXISTS, IT WILL BE ERASED
#################################################

if [ -e $rnnmodel ]; then
    rm $rnnmodel
fi

if [ -e $rnnmodel.output.txt ]; then
    rm $rnnmodel.output.txt
fi

################################
# TRAINING OF RNNLM HAPPENS HERE
################################

#to interrupt training, we limit the time for process to 60 seconds
for i in `seq 1 5`; do
(
ulimit -t 60
time $rnnpath/rnnlm -train $trainfile -valid $validfile -rnnlm $rnnmodel -hidden $hidden_size -rand-seed 1 -debug 2 -class $class_size -bptt $bptt_steps -bptt-block 10 -anti-kasparek 100000
)
done


#################################################
# N-GRAM MODEL IS TRAINED HERE, USING SRILM TOOLS
#################################################

#we use -unk switch for srilm tools, as the data contain <unk> tokens for unknown words
#as we have rewritten all out of vocabulary words in the validation and test data to <unk> tokens, we do not need any special parameters to rnnlm tool
#you can check that the results are correct by replacing <unk> toknes by other (like <unknown>) and training closed vocabulary models

$srilm_path/ngram-count -text $trainfile -order 5 -lm $temp/templm -gt3min 1 -gt4min 1 -kndiscount -interpolate -unk
$srilm_path/ngram -lm $temp/templm -order 5 -ppl $testfile -debug 2 > $temp/temp.ppl -unk

$rnnpath/convert <$temp/temp.ppl >$temp/ngram.txt

##################################################
# MODELS ARE COMBINED HERE, PERPLEXITY IS REPORTED
##################################################

time $rnnpath/rnnlm -rnnlm $rnnmodel -test $testfile -lm-prob $temp/ngram.txt -lambda 0.5
