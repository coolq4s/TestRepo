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
echo " Total Usage: $totaluse"
echo " Total Memory: $totalmem"

# Inisialisasi variabel
progress=$percentage
total=100
memfree=$(free -h | awk "NR==2 {print \$4}")

# Fungsi untuk menggambar progress bar
draw_progress_bar() {
    local percent=$((progress * 100 / total))
    local num_bar=$((percent / 3))
    local num_space=$((33 - num_bar))
    printf " ["
    printf "\e[31m%0.s|\e[0m" $(seq 1 $num_bar)
    printf "%0.s-" $(seq 1 $num_space)
    printf "] %d%%\r" $percent
    printf ", Free : $memfree"
}
draw_progress_bar
'

read -p " Press any key to continue"
