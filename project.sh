#!/bin/bash

# Initialize the 4x4 Tic-Tac-Toe board
board=( " " " " " " " " " " " " " " " " " " " " " " " " " " " " " )

# Current player (X or O)
current_player="X"

# Function to display the Tic-Tac-Toe board
function display_board {
    clear
    echo " ${board[0]} | ${board[1]} | ${board[2]} | ${board[3]} "
    echo "-----------"
    echo " ${board[4]} | ${board[5]} | ${board[6]} | ${board[7]} "
    echo "-----------"
    echo " ${board[8]} | ${board[9]} | ${board[10]} | ${board[11]} "
    echo "-----------"
    echo " ${board[12]} | ${board[13]} | ${board[14]} | ${board[15]} "
}

# Function to check if a player has won
function check_winner {
    # Check rows
    for ((i=0; i<=12; i+=4)); do
        if [ "${board[$i]}" == "$1" ] && [ "${board[$i+1]}" == "$1" ] && [ "${board[$i+2]}" == "$1" ] && [ "${board[$i+3]}" == "$1" ]; then
            return 1
        fi
    done

    # Check columns
    for ((i=0; i<4; i+=1)); do
        if [ "${board[$i]}" == "$1" ] && [ "${board[$i+4]}" == "$1" ] && [ "${board[$i+8]}" == "$1" ] && [ "${board[$i+12]}" == "$1" ]; then
            return 1
        fi
    done

    # Check diagonals
    if [ "${board[0]}" == "$1" ] && [ "${board[5]}" == "$1" ] && [ "${board[10]}" == "$1" ] && [ "${board[15]}" == "$1" ]; then
        return 1
    fi
    if [ "${board[3]}" == "$1" ] && [ "${board[6]}" == "$1" ] && [ "${board[9]}" == "$1" ] && [ "${board[12]}" == "$1" ]; then
        return 1
    fi

    # No winner yet
    return 0
}

# Function to check if the board is full (a tie)
function check_tie {
    for ((i=0; i<16; i+=1)); do
        if [ "${board[$i]}" == " " ]; then
            # There is an empty space, the game is not a tie
            return 0
        fi
    done

    # The board is full, it's a tie
    return 1
}

# Main game loop
while true; do
    display_board

    # Get player move
    echo "Player $current_player, enter your move (1-16): "
    read move

    # Validate input (check if it's a valid number and move)
    if [[ "$move" =~ ^[0-9]+$ ]] && [ "$move" -ge 1 ] && [ "$move" -le 16 ] && [ "${board[$move-1]}" == " " ]; then
        board[$move-1]=$current_player

        # Check for a winner
        check_winner "$current_player"
        if [ $? -eq 1 ]; then
            display_board
            echo "Player $current_player wins!"
            break
        fi

        # Check for a tie
        check_tie
        if [ $? -eq 1 ]; then
            display_board
            echo "It's a tie!"
            break
        fi

        # Switch to the other player
        if [ "$current_player" == "X" ]; then
            current_player="O"
        else
            current_player="X"
        fi
    else
        echo "Invalid move. Please enter a number between 1 and 16 for an empty space."
        sleep 2
    fi
done
