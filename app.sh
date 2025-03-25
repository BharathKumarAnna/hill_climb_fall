#!/bin/bash

function roll_dice() {
    dice_no=$(( (RANDOM % 6) + 1 ))
    echo $dice_no
}

function sum() {
    local arr=("$@")
    local sum_arr=0
    for (( i=0; i<${#arr[@]}; i++ )); do
        sum_arr=$((sum_arr + arr[i]))
    done
    echo $sum_arr
}

# 🎲 Function to print dice face
function print_dice() {
    case $1 in
        1)
            echo "┌───────┐"
            echo "│       │"
            echo "│   •   │"
            echo "│       │"
            echo "└───────┘"
            ;;
        2)
            echo "┌───────┐"
            echo "│ •     │"
            echo "│       │"
            echo "│     • │"
            echo "└───────┘"
            ;;
        3)
            echo "┌───────┐"
            echo "│ •     │"
            echo "│   •   │"
            echo "│     • │"
            echo "└───────┘"
            ;;
        4)
            echo "┌───────┐"
            echo "│ •   • │"
            echo "│       │"
            echo "│ •   • │"
            echo "└───────┘"
            ;;
        5)
            echo "┌───────┐"
            echo "│ •   • │"
            echo "│   •   │"
            echo "│ •   • │"
            echo "└───────┘"
            ;;
        6)
            echo "┌───────┐"
            echo "│ •   • │"
            echo "│ •   • │"
            echo "│ •   • │"
            echo "└───────┘"
            ;;
    esac
}

<<<<<<< HEAD
echo "                                  🚩🚩🚩   Hill Climb Fall   🚩🚩🚩"

# 🔄 Loop until the user presses 'f' to flip the coin
while true; do
    read -p "Press 'f' to flip the coin: " f
    if [[ "$f" == "f" ]]; then
        toss=$(roll_dice)
        break  # Exit loop if 'f' is pressed
    else
        echo "❌ Invalid input! Please press 'f' to flip the coin."
    fi
done

echo "Toss result: $toss"
if (( toss % 2 == 0 )); then
    echo "Since we got $toss, an even number: Player A starts"
    i=0
else
    echo "Since we got $toss, an odd number: Player B starts"
    i=1
=======
dialog --msgbox "🚩🚩🚩   Hill Climb Fall   🚩🚩🚩" 10 40
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
		ch=$(dialog --inputbox "Enter 'p' to play:" 10 40 3>&1 1>&2 2>&3)
		if (( ch==p )); then
			throw=$dice_ans
			a+=($dice_ans)
			dialog --msgbox "A rolled: $throw" 10 40
			echo "step no: $sum_a"
		(( i+= 1 ))
		fi
	elif (( $sum_b<10 && i%2!=0 )); then
                echo "Player B turn"
		ch=$(dialog --inputbox "Enter 'p' to play:" 10 40 3>&1 1>&2 2>&3)
                if (( ch==p )); then
                        throw=$dice_ans
                        b+=($dice_ans)
			dialog --msgbox "A rolled: $throw" 10 40
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
	dialog --msgbox "🎉 Player A is the Winner! 🎉" 10 40

else
	dialog --msgbox "🎉 Player B is the Winner! 🎉" 10 40

>>>>>>> 80891ed (added dialogue package for animation GUI)
fi

a=()
b=()
sum_a=0
sum_b=0

while (( sum_a != 10 && sum_b != 10 )); do
    if (( sum_a < 10 && i % 2 == 0 )); then
        echo "Player A turn"
        while true; do
            read -p "Press 'p' to roll the dice: " ch
            if [[ "$ch" == "p" ]]; then
                throw=$(roll_dice)
                echo "A rolled: $throw"
                print_dice $throw  # 🎲 Show dice face
                a+=("$throw")
                sum_a=$(sum "${a[@]}")
                echo "Step count of A: $sum_a"
                if (( sum_a > 10 )); then
                    echo "⚠️ A exceeded 10! Falling back to step 0."
                    a=()
                    sum_a=0
                fi
                ((i++))
                break
            else
                echo "❌ Invalid input! Press 'p' to roll the dice."
            fi
        done
    elif (( sum_b < 10 && i % 2 != 0 )); then
        echo "Player B turn"
        while true; do
            read -p "Press 'p' to roll the dice: " ch
            if [[ "$ch" == "p" ]]; then
                throw=$(roll_dice)
                echo "B rolled: $throw"
                print_dice $throw  # 🎲 Show dice face
                b+=("$throw")
                sum_b=$(sum "${b[@]}")
                echo "Step count of B: $sum_b"
                if (( sum_b > 10 )); then
                    echo "⚠️ B exceeded 10! Falling back to step 0."
                    b=()
                    sum_b=0
                fi
                ((i++))
                break
            else
                echo "❌ Invalid input! Press 'p' to roll the dice."
            fi
        done
    fi
done

if (( sum_a == 10 )); then
    echo "🎉 Player A is the Winner! 🎉"
else
    echo "🎉 Player B is the Winner! 🎉"
fi

