#!/bin/bash

rnnpath=../..
srilm_path=../../srilm/lm/bin/i686
trainfile=../../data/corpus/$1/train_$1
validfile=../../data/corpus/$1/valid_$1
testfile=../../data/corpus/test_$1
rnnmodel1=../../models/combination_$1/model-1.hidden100.class100.txt
rnnmodel2=../../models/combination_$1/model-2.hidden100.class100.txt
rnnmodel3=../../models/combination_$1/model-3.hidden100.class100.txt
rnnmodel4=../../models/combination_$1/model-4.hidden100.class100.txt
rnnmodel5=../../models/combination_$1/model-5.hidden100.class100.txt
rnnmodel6=../../models/combination_$1/model-6.hidden100.class100.txt
rnnmodel7=../../models/combination_$1/model-7.hidden100.class100.txt
rnnmodel8=../../models/combination_$1/model-8.hidden100.class100.txt
rnnmodel9=../../models/combination_$1/model-9.hidden100.class100.txt
temp=../../temp

hidden_size=210
class_size=1000
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

##############################################
# IF MODELS ALREADY EXIST, THEY WILL BE ERASED
##############################################

if [ -e $rnnmodel1 ]; then
    rm $rnnmodel1
fi
if [ -e $rnnmodel1.output.txt ]; then
    rm $rnnmodel1.output.txt
fi

if [ -e $rnnmodel2 ]; then
    rm $rnnmodel2
fi
if [ -e $rnnmodel2.output.txt ]; then
    rm $rnnmodel2.output.txt
fi

if [ -e $rnnmodel3 ]; then
    rm $rnnmodel3
fi
if [ -e $rnnmodel3.output.txt ]; then
    rm $rnnmodel3.output.txt
fi

if [ -e $rnnmodel4 ]; then
    rm $rnnmodel4
fi
if [ -e $rnnmodel4.output.txt ]; then
    rm $rnnmodel4.output.txt
fi

if [ -e $rnnmodel5 ]; then
    rm $rnnmodel5
fi
if [ -e $rnnmodel5.output.txt ]; then
    rm $rnnmodel5.output.txt
fi
if [ -e $rnnmodel6 ]; then
    rm $rnnmodel6
fi
if [ -e $rnnmodel6.output.txt ]; then
    rm $rnnmodel6.output.txt
fi
if [ -e $rnnmodel7 ]; then
    rm $rnnmodel7
fi
if [ -e $rnnmodel7.output.txt ]; then
    rm $rnnmodel7.output.txt
fi
if [ -e $rnnmodel8 ]; then
    rm $rnnmodel8
fi
if [ -e $rnnmodel8.output.txt ]; then
    rm $rnnmodel8.output.txt
fi
if [ -e $rnnmodel9 ]; then
    rm $rnnmodel9
fi
if [ -e $rnnmodel9.output.txt ]; then
    rm $rnnmodel9.output.txt
fi

#######################################################################################################
# TRAINING OF RNNLMS HAPPENS HERE - DIFFERENT INITIALIZATION IS OBTAINED BY USING -rand-seed <n> SWITCH
#######################################################################################################

time $rnnpath/rnnlm -train $trainfile -valid $validfile -rnnlm $rnnmodel1 -hidden $hidden_size -rand-seed 1 -debug 2 -class $class_size -bptt $bptt_steps -bptt-block 10
time $rnnpath/rnnlm -train $trainfile -valid $validfile -rnnlm $rnnmodel2 -hidden $hidden_size -rand-seed 2 -debug 2 -class $class_size -bptt $bptt_steps -bptt-block 10
time $rnnpath/rnnlm -train $trainfile -valid $validfile -rnnlm $rnnmodel3 -hidden $hidden_size -rand-seed 3 -debug 2 -class $class_size -bptt $bptt_steps -bptt-block 10
time $rnnpath/rnnlm -train $trainfile -valid $validfile -rnnlm $rnnmodel4 -hidden $hidden_size -rand-seed 4 -debug 2 -class $class_size -bptt $bptt_steps -bptt-block 10
time $rnnpath/rnnlm -train $trainfile -valid $validfile -rnnlm $rnnmodel5 -hidden $hidden_size -rand-seed 5 -debug 2 -class $class_size -bptt $bptt_steps -bptt-block 10
time $rnnpath/rnnlm -train $trainfile -valid $validfile -rnnlm $rnnmodel6 -hidden $hidden_size -rand-seed 6 -debug 2 -class $class_size -bptt $bptt_steps -bptt-block 10
time $rnnpath/rnnlm -train $trainfile -valid $validfile -rnnlm $rnnmodel7 -hidden $hidden_size -rand-seed 7 -debug 2 -class $class_size -bptt $bptt_steps -bptt-block 10
time $rnnpath/rnnlm -train $trainfile -valid $validfile -rnnlm $rnnmodel8 -hidden $hidden_size -rand-seed 8 -debug 2 -class $class_size -bptt $bptt_steps -bptt-block 10
time $rnnpath/rnnlm -train $trainfile -valid $validfile -rnnlm $rnnmodel9 -hidden $hidden_size -rand-seed 9 -debug 2 -class $class_size -bptt $bptt_steps -bptt-block 10
