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
#RAM
used=$(free -m | awk "NR==2 {print \$3}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
shared=$(free -m | awk "NR==2 {print \$5}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
buff=$(free -m | awk "NR==2 {print \$6}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
totaluse=$(($used+$shared+$buff))
totalmem=$(free -h | awk "NR==2 {print \$2}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
percentage=$(echo "scale=2; ($totaluse / $totalmem) * 100" | bc | sed "s/.00//g; s/Gi//g; s/Ki//g")

# Inisialisasi variabel
progress=$percentage
total=100
memfree=$(free -h | awk "NR==2 {print \$4}")
memused=$(free -h | awk "NR==2 {print \$3}")
memtotal=$(free -h | awk "NR==2 {print \$2}")

# Fungsi untuk menggambar progress bar
draw_progress_bar() {
    local percent=$((progress * 100 / total))
    local num_bar=$((percent / 3))
    local num_space=$((33 - num_bar))
    printf " RAM  ["
    printf "\033[91m%0.s|\e[0m" $(seq 1 $num_bar)
    printf "\033[92m%0.s-\e[0m" $(seq 1 $num_space)
    printf "] %d%%\r" $percent
    printf ",\033[102m\033[30m F: $memfree \033[101m\033[30m U: $memused \e[0m T: $memtotal"
}
draw_progress_bar
echo "\n"
#SWAP
used_swap=$(free -m | awk "NR==3 {print \$3}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
totaluse_swap=$(free -m | awk "NR==3 {print \$4}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
total_swap=$(free -m | awk "NR==3 {print \$2}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")

percentage_swap=$(echo "scale=2; ($totaluse_swap / $total_swap) * 100" | bc | sed "s/.00//g; s/Gi//g; s/Ki//g")

# Inisialisasi variabel
progressSwap=$percentage_swap
totalswap=100
swapfree=$(free -m | awk "NR==2 {print \$4}")
swapused=$(free -m | awk "NR==2 {print \$3}")
swaptotal=$(free -m | awk "NR==2 {print \$2}")

# Fungsi untuk menggambar progress bar swap
draw_progress_bar_swap() {
    local percentswap=$((progressSwap * 100 / totalswap))
    local num_bar_swap=$((percentswap / 3))
    local num_space_swap=$((33 - num_bar_swap))
    printf " SWAP ["
    printf "\033[91m%0.s|\e[0m" $(seq 1 $num_bar_swap)
    printf "\033[92m%0.s-\e[0m" $(seq 1 $num_space_swal)
    printf "] %d%%\r" $percentswap
    printf ",\033[102m\033[30m F: $swapfree \033[101m\033[30m U: $swapused \e[0m T: $swaptotal"
}
draw_progress_bar_swap
'

read -p " Press any key to continue"
