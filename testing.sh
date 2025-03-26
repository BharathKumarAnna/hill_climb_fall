#!/bin/bash

# Function to roll the dice
function roll_dice() {
    echo $(( (RANDOM % 6) + 1 ))
}

# Function to calculate sum
function sum_array() {
    local arr=($@)
    local sum_arr=0
    for num in "${arr[@]}"; do
        ((sum_arr += num))
    done
    echo $sum_arr
}



# Function to print dice face
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



# Welcome screen
dialog --title "🎮 Welcome!" --msgbox "🚩🚩🚩 Hill Climb Fall 🚩🚩🚩\n\nPress OK to start the game!" 10 40

# Toss to decide who starts
while true; do
    toss_choice=$(dialog --title "🎲 Coin Toss" --inputbox "Press 'f' to flip the coin:" 10 40 3>&1 1>&2 2>&3)
    if [[ "$toss_choice" == "f" ]]; then
        toss=$(roll_dice)
        break
    fi
    dialog --title "❌ Invalid Input" --msgbox "Please press 'f' to flip the coin!" 10 40
done

if (( toss % 2 == 0 )); then
    starter="A"
    i=0
else
    starter="B"
    i=1
fi

dialog --title "🎲 Coin Toss Result" --msgbox "Toss result: $toss\n\n$starter starts the game!" 10 40

# Initialize player positions
declare -a a=()
declare -a b=()
sum_a=0
sum_b=0
log_file="game_log.txt"


# Reset log file
echo "Game Start - $(date)" > $log_file


# Main game loop
while (( sum_a != 10 && sum_b != 10 )); do
    if (( i % 2 == 0 )); then
        player="A"
        sum_val=$sum_a
    else
        player="B"
        sum_val=$sum_b
    fi

    ch=$(dialog --title "🎮 $player's Turn - Hill Climb Fall" --inputbox "📊 **Game Status:**\n\nPlayer A: $sum_a\nPlayer B: $sum_b\n\n🎲 $player's Turn!\nEnter 'p' to roll the dice:" 15 50 3>&1 1>&2 2>&3)
    
    if [[ "$ch" == "p" ]]; then
        throw=$(roll_dice)

        # Store dice roll
        if [[ "$player" == "A" ]]; then
            a+=($throw)
            sum_a=$(sum_array "${a[@]}")
        else
            b+=($throw)
            sum_b=$(sum_array "${b[@]}")
        fi
        
        dice_face=$(print_dice $throw)
        dialog --title "🎲 Dice Roll" --msgbox "$player rolled a $throw!\n\n$dice_face\n\nCurrent Position:\nA: $sum_a\nB: $sum_b" 15 40
        
        # Check if the player overshot 10
        if [[ "$player" == "A" && $sum_a -gt 10 ]]; then
            dialog --title "Oops! 🔄" --msgbox "Player A exceeded 10! Resetting to 0." 10 40
            a=()
            sum_a=0
        elif [[ "$player" == "B" && $sum_b -gt 10 ]]; then
            dialog --title "Oops! 🔄" --msgbox "Player B exceeded 10! Resetting to 0." 10 40
            b=()
            sum_b=0
        fi

	 # Save the status to the log file
        echo "Player $player rolled $throw | A: $sum_a | B: $sum_b" >> $log_file

        ((i += 1))
    fi

done

# Declare winner
if ((sum_a == 10)); then
    dialog --title "🎉 Winner!" --msgbox "🏆 Player A wins! 🏆" 10 40
    echo "🏆 Player A wins!" >> $log_file
else
    dialog --title "🎉 Winner!" --msgbox "🏆 Player B wins! 🏆" 10 40
    echo "🏆 Player B wins!" >> $log_file
fi

dialog --title "📜 Game Summary" --textbox "$log_file" 15 50
