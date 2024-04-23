#!/bin/bash

cleanup() {
    rm -rf ram.sh
    rm -rf TestRepo
    echo "Cleaning up temporary files"
    echo ""
    echo ""
    echo -e "To try again this script,\nyou can copy the command from github"
    echo ""
    echo ""
}

trap cleanup EXIT

clear

while true; do
    used=$(free -m | awk "NR==2 {print \$3}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
    shared=$(free -m | awk "NR==2 {print \$5}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
    buff=$(free -m | awk "NR==2 {print \$6}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
    totaluse=$(($used+$shared+$buff))
    totalmem=$(free -h | awk "NR==2 {print \$2}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")

    # Calculate percentage used
    percentage=$(echo "scale=2; ($totaluse / $totalmem) * 100" | bc)

    # Draw the bar
    printf "Total Memory Usage: $totaluse MB / $totalmem MB\n"
    printf "Memory Usage: %.2f%% [%.0s=]{1..%.0f}\n" $percentage $(seq 1 $(echo "$percentage / 2" | bc))
    printf "\n"

    sleep 1
    clear
done
