rm -rf "scores_toy"
mkdir "scores_toy"

echo "Using LM:"
./test.sh $2

sed -i model1.score.txt 
sed -i model2.score.txt 
sed -i model3.score.txt 
sed -i model4.score.txt 
sed -i model5.score.txt 
sed -i model6.score.txt 
sed -i model7.score.txt 
sed -i model8.score.txt 
sed -i model9.score.txt 

echo "Picking begin:"
python pickone.py 1 $1
python pickone.py 2 $1
python pickone.py 3 $1
python pickone.py 4 $1
python pickone.py 5 $1
python pickone.py 6 $1
python pickone.py 7 $1
python pickone.py 8 $1
python pickone.py 9 $1
echo "Voting all:"
python vote.py
