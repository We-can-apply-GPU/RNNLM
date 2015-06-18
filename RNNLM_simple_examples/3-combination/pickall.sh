#!/usr/bin/env sh

number=9
suffix=".score.txt"
tmp="tmp"

if [ $# -ne 0  ]; then
    DIC_PATH=scores_$1
    rm -rf $DIC_PATH
    mkdir $DIC_PATH

    echo "Using LM:"
    ./test.sh $1 $2
    echo "cd $DIC_PATH"
    cd  $DIC_PATH

    for cnt in $(seq "$number")
        do
            file="model$cnt$suffix"
            sed  -i 's/test.*$//g' $file
            sed  -i 's/PPL.*$//g'  $file 
            sed  -i '1,6d'         $file 
            sed  -i '/^$/d'        $file
        done
    
    echo "Picking begin:"
    for cnt in $(seq "$number")
        do
            python ../pickone.py $cnt $1
        done
    cd ..

    echo "Voting all:"
    python vote.py $1

else
    echo "Usage: <filename> <lamda>";
    exit
fi

