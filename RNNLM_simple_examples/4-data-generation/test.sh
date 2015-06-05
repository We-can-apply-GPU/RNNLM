#!/bin/bash

rnnpath=../..
srilm_path=../../srilm/lm/bin/i686
trainfile=../../data/train_hw3
validfile=../../data/valid_hw3
testfile=../../data/test_hw3
rnnmodel=../../models/model_4
temp=../../temp

if [ ! -e $rnnmodel ]; then
    echo "model file not found... run first train.sh"
    exit
fi

#################################################
# N-GRAM MODEL IS TRAINED HERE, USING SRILM TOOLS
#################################################

$srilm_path/ngram-count -text $trainfile -order 5 -lm $temp/templm -gt3min 1 -gt4min 1 -kndiscount -interpolate -unk
$srilm_path/ngram -lm $temp/templm -order 5 -ppl $testfile -debug 2 > $temp/temp.ppl -unk

$rnnpath/convert <$temp/temp.ppl >$temp/ngram.txt

echo "Perplexity of the ngram model:"
$srilm_path/ngram -lm $temp/templm -order 5 -ppl $testfile -unk

##################################################
# MODELS ARE COMBINED HERE, PERPLEXITY IS REPORTED
##################################################

echo "Perplexity of the full rnn model when combined with 5-gram model:"
$rnnpath/rnnlm -rnnlm $rnnmodel -test $testfile -lm-prob $temp/ngram.txt -lambda 0.5

#############################################################
# NOW, WE RANDOMLY SAMPLE 10 MILLION WORDS FROM THE RNN MODEL
#############################################################

echo "Generating data..."
$rnnpath/rnnlm -rnnlm $rnnmodel -gen 10000000 -debug 0 > $temp/ptb.model.hidden200.class100.gen.txt

#now we build ngram model based on the sampled data
$srilm_path/ngram-count -text $temp/ptb.model.hidden200.class100.gen.txt -order 5 -unk -lm $temp/genlm

echo "Perplexity of the rnn model approximated by 5-gram model:"
$srilm_path/ngram -lm $temp/genlm -order 5 -unk -ppl $testfile
echo "Perplexity of the rnn model approximated by 5-gram model, combined with the baseline 5-gram model:"
$srilm_path/ngram -lm $temp/genlm -order 5 -unk -ppl $testfile -mix-lm $temp/templm -lambda 0.3
