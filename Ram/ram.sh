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

# Inisialisasi variabel
progress=$percentage
total=100

# Fungsi untuk menggambar progress bar
draw_progress_bar() {
    local percent=$((progress * 100 / total))
    local num_bar=$((percent / 2))
    local num_space=$((50 - num_bar))
    printf "["
    echo -e "\e[31m"
    printf "%0.s|" $(seq 1 $num_bar)
    echo -e "\e[0m"
    printf "%0.s-" $(seq 1 $num_space)
    printf "] %d%%\r" $percent
}
draw_progress_bar
'

read -p " Press any key to continue"
