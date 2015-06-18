#!/bin/bash

rnnpath=../..
srilm_path=../../srilm/lm/bin/i686
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
scores=./scores_$1
lambda=$2
if [[ ! -e $rnnmodel1 || ! -e $rnnmodel2 || ! -e $rnnmodel3 || ! -e $rnnmodel4 || ! -e $rnnmodel5|| ! -e $rnnmodel6|| ! -e $rnnmodel7|| ! -e $rnnmodel8|| ! -e $rnnmodel9 ]]; then
    echo "model files not found... run first train.sh"
    exit
fi

#######################
# CHECK FOR 'prob' TOOL
#######################

if [ ! -e $rnnpath/prob ]; then
    gcc $rnnpath/prob.c -O2 -lm -o $rnnpath/prob
fi

#################################################
# N-GRAM MODEL IS TRAINED HERE, USING SRILM TOOLS
#################################################

$srilm_path/ngram-count -text $trainfile -order 5 -lm $temp/templm -gt3min 1 -gt4min 1 -kndiscount -interpolate -unk
$srilm_path/ngram -lm $temp/templm -order 5 -ppl $testfile -debug 2 > $temp/temp.ppl -unk

$rnnpath/convert <$temp/temp.ppl >$temp/srilm.txt

##################################################
#COMPUTE PER-WORD PROBABILITIES GIVEN ALL 5 MODELS
##################################################

$rnnpath/rnnlm -rnnlm $rnnmodel1 -test $testfile -lm-prob $temp/srilm.txt -lambda $lambda -nbest -debug 2 > $scores/model1.score.txt

$rnnpath/rnnlm -rnnlm $rnnmodel2 -test $testfile -lm-prob $temp/srilm.txt -lambda $lambda  -nbest -debug 2 > $scores/model2.score.txt

$rnnpath/rnnlm -rnnlm $rnnmodel3 -test $testfile -lm-prob $temp/srilm.txt -lambda $lambda  -nbest -debug 2 > $scores/model3.score.txt

$rnnpath/rnnlm -rnnlm $rnnmodel4 -test $testfile -lm-prob $temp/srilm.txt -lambda $lambda  -nbest -debug 2 > $scores/model4.score.txt

$rnnpath/rnnlm -rnnlm $rnnmodel5 -test $testfile -lm-prob $temp/srilm.txt -lambda $lambda  -nbest -debug 2 > $scores/model5.score.txt

$rnnpath/rnnlm -rnnlm $rnnmodel6 -test $testfile -lm-prob $temp/srilm.txt -lambda $lambda  -nbest -debug 2 > $scores/model6.score.txt
$rnnpath/rnnlm -rnnlm $rnnmodel7 -test $testfile -lm-prob $temp/srilm.txt -lambda $lambda  -nbest -debug 2 > $scores/model7.score.txt
$rnnpath/rnnlm -rnnlm $rnnmodel8 -test $testfile -lm-prob $temp/srilm.txt -lambda $lambda  -nbest -debug 2 > $scores/model8.score.txt
$rnnpath/rnnlm -rnnlm $rnnmodel9 -test $testfile -lm-prob $temp/srilm.txt -lambda $lambda  -nbest -debug 2 > $scores/model9.score.txt

