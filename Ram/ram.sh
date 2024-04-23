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
used=$(free -w | awk "NR==2 {print \$3}")
echo "$used"
shared=$(free -w | awk "NR==2 {print \$5}")
echo "shared value is $shared"
buff=$(free -w | awk "NR==2 {print \$6}")
echo "buff value is $buff"
cache=$(free -w | awk "NR==2 {print \$7}")
echo "cache value is $cache"


totalMemUsed=$(("$used + $shared + $buff + $cache"))


totaluse=$(($totalMemUsed * 8 / 10000))
echo " $totaluse"
totalmem=$(free -h | awk "NR==2 {print \$2}")
percentage=$(echo "scale=2; ($totaluse / $totalmem) * 100" | bc)

# Inisialisasi variabel
progress=$percentage
total=100
memfree=$(free -m | awk "NR==2 {print \$4}")
memused=$(free -w | awk "NR==2 {print \$3}")
membuff=$(free -w | awk "NR==2 {print \$6}")
memshare=$(free -w | awk "NR==2 {print \$5}")
memtotal=$(free -m | awk "NR==2 {print \$2}")

#memCount=$(($memused+$membuff+$memshare))
#memTotalCount=$(echo "$memCount * 8 / 1000000" | bc)
#echo "$memCount"

# Fungsi untuk menggambar progress bar
#draw_progress_bar() {
    local percent=$((progress * 100 / total))
    local num_bar=$((percent / 4))
    local num_space=$((25 - num_bar))
    printf " RAM  ["
    printf "\033[91m%0.s|\e[0m" $(seq 1 $num_bar)
    printf "\033[92m%0.s-\e[0m" $(seq 1 $num_space)
    printf "] %d%%\r" $percent
    printf ",\033[102m\033[30m F: $memfree \033[101m\033[30m U: $memTotalCount \e[0m T: $memtotal"
}
draw_progress_bar
echo "\n"
#SWAP
used_swap=$(free -m | awk "NR==3 {print \$3}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
totalfree_swap=$(free -m | awk "NR==3 {print \$4}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
total_swap=$(free -m | awk "NR==3 {print \$2}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")

percentage_swap=$(echo "scale=2; ($used_swap / $total_swap) * 100" | bc | sed "s/.00//g; s/Gi//g; s/Ki//g")

# Inisialisasi variabel
progressSwap=$percentage_swap
totalswap=100
swapfree=$(free -h | awk "NR==3 {print \$4}")
swapused=$(free -h | awk "NR==3 {print \$3}")
swaptotal=$(free -h | awk "NR==3 {print \$2}")

# Fungsi untuk menggambar progress bar swap
draw_progress_bar_swap() {
    local percentswap=$((progressSwap * 100 / totalswap))
    local num_bar_swap=$((percentswap / 4))
    local num_space_swap=$((25 - num_bar_swap))
    printf " SWAP ["
    printf "\033[91m%0.s|\e[0m" $(seq 1 $num_bar_swap)
    printf "\033[92m%0.s-\e[0m" $(seq 1 $num_space_swap)
    printf "] %d%%\r" $percentswap
    printf ",\033[102m\033[30m F: $swapfree \033[101m\033[30m U: $swapused \e[0m T: $swaptotal"
}
draw_progress_bar_swap
'

read -p " Press any key to continue"
