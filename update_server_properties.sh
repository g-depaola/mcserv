#!/bin/bash

### Change values of server.properties
# Function to display script usage/help information
function display_usage() {
  # hint: you will have multiple echo statements here
  cat <<- EOM
Usage: $0 -g <gamemode>> -c <cblock>> -m <motd>> -d <difficulty>> -v <number>> -p <pvp>>
Options:
  -g <gamemode>>: Specify the server gamemode.
  -c <cblock>>: Enable or disable command block. (true or false)
  -m "<motd>>": Change the MOTD.
  -d <difficulty>>: Change the difficulty.
  -v <number>>: Change the max player count.
  -p <pvp>>: Enable or disable PvP. (true or false)
  -h: Display this help information.
EOM
}

# Check if no arguments are provided.
# If so, display usage information and exit
if [[ $# -eq 0 || "$1" == "-h" ]]; then
    display_usage
    exit 0
fi

# Initialize variables.
gamemode=""
cblock=""
motd=""
difficulty=""
number=""
pvp=""

# Process command-line options and arguments
while getopts ":g:c:m:d:v:p:h" opt; do
    case $opt in
        g) # option g
            gamemode=$OPTARG
            ;;
        c) # option c
            cblock=$OPTARG
            ;;
        m) # option m
            motd=$OPTARG
            ;;
        d) # option d
            difficulty=$OPTARG
            ;;
        v) # option v
            number=$OPTARG
            ;;
        p) # option p
            pvp=$OPTARG
            ;;
        h) # option h
            # display usage and exit
            display_usage
            exit 0
            ;;
        \?) # any other option
            echo "Invalid option: -$OPTARG"
            # display usage and exit
            display_usage
            exit 0
            ;;
        :) # no argument
            echo "Option -$OPTARG requires an argument."
            # display usage and exit
            display_usage
            exit 1
            ;;
        esac

done

function adjustGamemode() {
    # Check if the -g switch has a valid argument
    if [[ $gamemode == "survival" ]]; then
        sed -i 's/gamemode=survival\|gamemode=creative\|gamemode=adventure\|gamemode=spectator/gamemode=survival/g' "$properties_file"
        echo "Gamemode updated."
    elif [[ $gamemode == "creative" ]]; then
        sed -i 's/gamemode=survival\|gamemode=creative\|gamemode=adventure\|gamemode=spectator/gamemode=creative/g' "$properties_file"
        echo "Gamemode updated."
    elif [[ $gamemode == "adventure" ]]; then
        sed -i 's/gamemode=survival\|gamemode=creative\|gamemode=adventure\|gamemode=spectator/gamemode=adventure/g' "$properties_file"
        echo "Gamemode updated."
    elif [[ $gamemode == "spectator" ]]; then
        sed -i 's/gamemode=survival\|gamemode=creative\|gamemode=adventure\|gamemode=spectator/gamemode=spectator/g' "$properties_file"
        echo "Gamemode updated."
    elif [[ $gamemode != "survival" && $gamemode != "creative" && $gamemode != "adventure" && $gamemode != "spectator" ]]; then
        echo "Error: Invalid gamemode. Supported types are 'survival', 'adventure', 'spectator', and 'creative'."
        # exit
        exit 1
    fi
}

function adjustCommandBlock() {
    # Check if the -c switch has a valid argument
    if [[ $cblock == "true" ]]; then
        sed -i 's/enable-command-block=true\|enable-command-block=false/enable-command-block=true/g' "$properties_file"
        echo "Enable command block updated."
    elif [[ $cblock == "false" ]]; then
        sed -i 's/enable-command-block=true\|enable-command-block=false/enable-command-block=false/g' "$properties_file"
        echo "Enable command block updated."
    elif [[ $cblock != "true" && $cblock != "false" ]]; then
        echo "Error: Invalid option. Supported options are 'true' and 'false'."
        # exit
        exit 1
    fi
}

function adjustMOTD() {
    if [[ $motd == "" ]]; then
        echo "Error: Please input an MOTD"
        # exit
        exit 1
    else
        # Change MOTD
        sed -i "s/motd=.*/motd=$motd/g" "$properties_file"
        echo "MOTD has been updated."
    fi
}

function adjustDifficulty() {
    if [[ $difficulty == "peaceful" ]]; then
        sed -i 's/difficulty=.*/difficulty=peaceful/g' "$properties_file"
        echo "Difficulty updated."
    elif [[ $difficulty == "easy" ]]; then
        sed -i 's/difficulty=.*/difficulty=easy/g' "$properties_file"
        echo "Difficulty updated."
    elif [[ $difficulty == "medium" ]]; then
        sed -i 's/difficulty=.*/difficulty=medium/g' "$properties_file"
        echo "Difficulty updated."
    elif [[ $difficulty == "hard" ]]; then
        sed -i 's/difficulty=.*/difficulty=hard/g' "$properties_file"
        echo "Difficulty updated."
    elif [[ $gamemode != "peaceful" && $gamemode != "easy" && $gamemode != "medium" && $gamemode != "hard" ]]; then
        echo "Error: Invalid difficulty. Supported types are 'peaceful', 'easy', 'medium', and 'hard'."
        # exit
        exit 1
    fi
}

function adjustMaxPlayerCount() {
    sed -i "s/max-player=.*/difficulty=$number/g" "$properties_file"
    echo "Max player count updated."
}

function adjustPVP() {
    # Check if the -p switch has a valid argument
    if [[ $pvp == "true" ]]; then
        sed -i 's/pvp=.*/pvp=true/g' "$properties_file"
        echo "PvP status updated."
    elif [[ $pvp == "false" ]]; then
        sed -i 's/pvp=.*/pvp=false/g' "$properties_file"
        echo "PvP status updated."
    elif [[ $pvp != "true" && $pvp != "false" ]]; then
        echo "Error: Invalid option. Supported options are 'true' and 'false'."
        # exit
        exit 1
    fi
}

# Define the filename
properties_file="minecraft_server/server.properties"

# Check if the file exists
if [ -f "$properties_file" ]; then
    adjustGamemode
    adjustCommandBlock
    adjustMOTD
    adjustDifficulty
    adjustMaxPlayerCount
    adjustPVP
    echo "Properties file has been updated successfully."
    exit 0
else
    echo "File $properties_file does not exist."
    exit 1
fi