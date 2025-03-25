#!/bin/bash

function roll_dice() {
    dice_no=$(( (RANDOM % 6) + 1 ))
    return $dice_no
}

roll_dice
dice_ans=$?
#echo "dice no : $dice_ans"


function sum() {
local arr=("$@")
local sum_arr=0
for (( i=0;i<${#arr[@]};i++ ))
do
	sum_arr=$((sum_arr + arr[i]))
done

return $sum_arr
}

#p=(1 2 3)
#sum "${p[@]}"
#sum_ans=$?
#echo "sum is : $sum_ans"

echo "					🚩🚩🚩   Hill Climb Fall   🚩🚩🚩" 
a=()
b=()
i=0
sum "${a[@]}"
sum_a=$?
sum "${b[@]}"
sum_b=$?
while (($sum_a!=10 && $sum_b!=10))
do
	if (( $sum_a<10 && i%2==0 )); then
		echo "Player A turn"
		read -p "enter p to play" ch
		if (( ch==p )); then
			throw=$dice_ans
			a+=($dice_ans)
			echo "step no: $sum_a"
		(( i+= 1 ))
		fi
	elif (( $sum_b<10 && i%2!=0 )); then
                echo "Player B turn"
                read -p "enter p to play" ch
                if (( ch==p )); then
                        throw=$dice_ans
                        b+=($dice_ans)
                        echo "step no: $sum_b"
                (( i+= 1 ))
		fi
	elif (( $sum_a > 10 )); then
		a=()
	elif (( $sum_b > 10 )); then
		b=()
	else
		echo "Nothing"
	fi
        
done

if (($sum_a==10)); then
	echo "Player A is the Winner..."
else
	echo "Player B is the Winner..."
fi

















