#!/bin/bash

cleanup() {
    rm -rf ram.sh
    rm -rf TestRepo
    echo " Cleaning up temporary files"
    echo ""
    echo ""
    echo -e " To try again this script,\n you can copy the command from github"
    echo ""
    echo ""
}

trap cleanup EXIT

clear

watch -n1 -tc '
used=$(free -m | awk "NR==2 {print \$3}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
shared=$(free -m | awk "NR==2 {print \$5}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
buff=$(free -m | awk "NR==2 {print \$6}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
totaluse=$(($used+$shared+$buff))
totalmem=$(free -h | awk "NR==2 {print \$2}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
percentage=$(echo "scale=2; ($totaluse / $totalmem) * 100" | bc | sed "s/.00//g; s/Gi//g; s/Ki//g")
bar_length=$(echo "scale=0; $percentage / 2" | bc)
echo "Total Usage: $totaluse"
echo "Total Memory: $totalmem"
echo "Percentage Used: $percentage%"
echo -ne "#                          ($percentage%)\r"



bar_size=$percentage
bar_char_done="#"
bar_char_todo="-"
bar_percentage_scale=2

function show_progress {
    current="$1"
    total="$2"

    # calculate the progress in percentage 
    percent=$(bc <<< "scale=$bar_percentage_scale; 100 * $current / $total" )
    # The number of done and todo characters
    done=$(bc <<< "scale=0; $bar_size * $percent / 100" )
    todo=$(bc <<< "scale=0; $bar_size - $done" )

    # build the done and todo sub-bars
    done_sub_bar=$(printf "%${done}s" | tr " " "${bar_char_done}")
    todo_sub_bar=$(printf "%${todo}s" | tr " " "${bar_char_todo}")

    # output the bar
    echo -ne "\rProgress : [${done_sub_bar}${todo_sub_bar}] ${percent}%"

    if [ $total -eq $current ]; then
        echo -e "\nDONE"
    fi
}
'

read -p " Press any key to continue"
