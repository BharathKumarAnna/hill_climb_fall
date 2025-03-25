#!/bin/bash

function roll_dice() {
    dice_no=$(( (RANDOM % 6) + 1 ))
    echo $dice_no
}



function sum() {
local arr=("$@")
local sum_arr=0
for (( i=0;i<${#arr[@]};i++ ))
do
	sum_arr=$((sum_arr + arr[i]))
done
echo $sum_arr
}

#p=(1 2 3)
#sum "${p[@]}"
#sum_ans=$?
#echo "sum is : $sum_ans"

echo "					🚩🚩🚩   Hill Climb Fall   🚩🚩🚩" 
a=()
b=()
i=0
sum_a=0
sum_b=0
while (( $sum_a!=10 && $sum_b!=10 ))
do
	if (( sum_a<10 && i%2==0 )); then
		echo "Player A turn"
		read -p "enter p to play: " ch
		if (( ch==p )); then
			throw=$(roll_dice)
			echo "A rolled: $throw"
			((a+=$throw))
			sum_a=$(sum "${a[@]}")
			echo "step no of A: $sum_a"
			if ((sum_a>10 )); then
				echo "A falls back to step 0"
				a=()
				sum_a=0
			fi
		(( i+=1 ))
		fi
	elif (( $sum_b<10 && i%2!=0 )); then
                echo "Player B turn"
                read -p "enter p to play: " ch
                if (( ch==p )); then
			throw=$(roll_dice)
			echo "B rolled: $throw"
			((b+=$throw))
			sum_b=$(sum "${b[@]}")
			echo "step no of B : $sum_b"
			if (( sum_b>10 )); then
				echo "B falls back to step 0"
				b=()
				sum_b=0
			fi
                (( i+= 1 ))
		fi
	fi
	
        
done

if ((sum_a==10)); then
	echo "Player A is the Winner..."
else
	echo "Player B is the Winner..."
fi
