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

watch -n1 -tc -g '
#RAM
#Count Used Ram
used=$(free -w | awk "NR==2 {print \$3}")
shared=$(free -w | awk "NR==2 {print \$5}")
buff=$(free -w | awk "NR==2 {print \$6}")
cache=$(free -w | awk "NR==2 {print \$7}")

totalMemUsed=$(($used + $shared + $buff + $cache))


if [ $totalMemUsed -gt 1024000 ]; then
    totaluse=$(echo "scale=2; $totalMemUsed / 1024 / 1024" | bc)
    totalresult=$(echo $totaluse)
    totalresult2=$(echo $totaluse GiB)
else
    totaluse=$(echo "scale=2; $totalMemUsed / 1024" | bc)
    totalresult=$(echo $totaluse)
    totalresult2=$(echo $totaluse MiB)
fi

#Count Installed RAM
totalmem=$(free -w | awk "NR==2 {print \$2}")

if [ $totalmem -gt 1024000 ]; then
    totalmemInstalled=$(echo "scale=2; $totalmem / 1024 / 1024" | bc)
    installedMem=$(echo $totalmemInstalled)
    installedMem2=$(echo $totalmemInstalled GiB)
else
    totalmemInstalled=$(echo "scale=2; $totalmem / 1024" | bc)
    installedMem=$(echo $totalmemInstalled)
    installedMem2=$(echo $totalmemInstalled MiB)
fi

#Count Free RAM
freeRAM=$(free -w | awk "NR==2 {print \$4}")
if [ $freeRAM -gt 1024000 ]; then
    totalfreeRAM=$(echo "scale=2; $freeRAM / 1024 / 1024" | bc)
    availableRAM=$(echo $totalfreeRAM)
    availableRAM2=$(echo $totalfreeRAM GiB)
else
    totalfreeRAM=$(echo "scale=2; $freeRAM / 1024" | bc)
    availableRAM=$(echo $totalfreeRAM)
    availableRAM2=$(echo $totalfreeRAM MiB)
fi

#Bar RAM
getPercent=$(echo "scale=2; ($totalresult / $installedMem) * 100" | bc )
percentage=$(printf "%.0f" "$getPercent")

progress=$percentage
total=100

draw_progress_bar_RAM() {
    local percent=$((progress * 100 / total))
    local num_bar=$((percent / 4))
    local num_space=$((25 - num_bar))
    printf " RAM  ["
    printf "\033[91m%0.s|\e[0m" $(seq 1 $num_bar)
    printf "\033[92m%0.s-\e[0m" $(seq 1 $num_space)
    printf "] %d%%\r" $percent
    printf ",\033[102m\033[30m F: $availableRAM2 \033[101m\033[30m U: $totalresult2 \e[0m T: $installedMem2"
}

draw_progress_bar_RAM
echo -n "\n"

#SWAP
used_swap=$(free -w | awk "NR==3 {print \$3}")
free_swap=$(free -w | awk "NR==3 {print \$4}")
total_swap=$(free -w | awk "NR==3 {print \$2}")

if [ $used_swap -gt 1024000 ]; then
    swap_used=$(echo "scale=2; $used_swap / 1024 / 1024" | bc)
    swapresult=$(echo $swap_used)
    swapresult2=$(echo $swap_used GiB)
else
    swap_used=$(echo "scale=2; $used_swap / 1024" | bc)
    swapresult=$(echo $swap_used)
    swapresult2=$(echo $swap_used MiB)
fi

if [ $free_swap -gt 1024000 ]; then
    free_swap_count=$(echo "scale=2; $free_swap / 1024 / 1024" | bc)
    availableSWAP=$(echo $free_swap_count)
    availableSWAP2=$(echo $free_swap_count GiB)
else
    free_swap_count=$(echo "scale=2; $free_swap / 1024" | bc)
    availableSWAP=$(echo $free_swap_count)
    availableSWAP2=$(echo $free_swap_count MiB)
fi


if [ $total_swap -gt 1024000 ]; then
    total_swap_count=$(echo "scale=2; $total_swap / 1024 / 1024" | bc)
    totalSWAP=$(echo $total_swap_count)
    totalSWAP2=$(echo $total_swap_count GiB)
else
    total_swap_count=$(echo "scale=2; $total_swap / 1024" | bc)
    totalSWAP=$(echo $total_swap_count)
    totalSWAP2=$(echo $total_swap_count MiB)
fi


#Bar SWAP
getswapPercent=$(echo "scale=2; ($swapresult / $totalSWAP) * 100" | bc )
percentageswap=$(printf "%.0f" "$getswapPercent")

progressSWAP=$percentageswap
totalpercentSWAP=100

draw_progress_bar_SWAP() {
    local percentSWAP=$((progressSWAP * 100 / totalpercentSWAP))
    local num_barSWAP=$((percentSWAP / 4))
    local num_spaceSWAP=$((25 - num_barSWAP))
    printf " SWAP ["
    printf "\033[91m%0.s|\e[0m" $(seq 1 $num_barSWAP)
    printf "\033[92m%0.s-\e[0m" $(seq 1 $num_spaceSWAP)
    printf "] %d%%\r" $percentSWAP
    printf ",\033[102m\033[30m F: $availableSWAP2 \033[101m\033[30m U: $swapresult2 \e[0m T: $totalSWAP2"
}

draw_progress_bar_SWAP
echo -n "\n"
echo -n "\n"
'
sudo sync && echo 3 > /proc/sys/vm/drop_caches
wait

echo "------------AFTER------------"
echo -n "\n"

watch -n1 -tc -g '
#RAM
#Count Used Ram
used=$(free -w | awk "NR==2 {print \$3}")
shared=$(free -w | awk "NR==2 {print \$5}")
buff=$(free -w | awk "NR==2 {print \$6}")
cache=$(free -w | awk "NR==2 {print \$7}")

totalMemUsed=$(($used + $shared + $buff + $cache))


if [ $totalMemUsed -gt 1024000 ]; then
    totaluse=$(echo "scale=2; $totalMemUsed / 1024 / 1024" | bc)
    totalresult=$(echo $totaluse)
    totalresult2=$(echo $totaluse GiB)
else
    totaluse=$(echo "scale=2; $totalMemUsed / 1024" | bc)
    totalresult=$(echo $totaluse)
    totalresult2=$(echo $totaluse MiB)
fi

#Count Installed RAM
totalmem=$(free -w | awk "NR==2 {print \$2}")

if [ $totalmem -gt 1024000 ]; then
    totalmemInstalled=$(echo "scale=2; $totalmem / 1024 / 1024" | bc)
    installedMem=$(echo $totalmemInstalled)
    installedMem2=$(echo $totalmemInstalled GiB)
else
    totalmemInstalled=$(echo "scale=2; $totalmem / 1024" | bc)
    installedMem=$(echo $totalmemInstalled)
    installedMem2=$(echo $totalmemInstalled MiB)
fi

#Count Free RAM
freeRAM=$(free -w | awk "NR==2 {print \$4}")
if [ $freeRAM -gt 1024000 ]; then
    totalfreeRAM=$(echo "scale=2; $freeRAM / 1024 / 1024" | bc)
    availableRAM=$(echo $totalfreeRAM)
    availableRAM2=$(echo $totalfreeRAM GiB)
else
    totalfreeRAM=$(echo "scale=2; $freeRAM / 1024" | bc)
    availableRAM=$(echo $totalfreeRAM)
    availableRAM2=$(echo $totalfreeRAM MiB)
fi

#Bar RAM
getPercent=$(echo "scale=2; ($totalresult / $installedMem) * 100" | bc )
percentage=$(printf "%.0f" "$getPercent")

progress=$percentage
total=100

draw_progress_bar_RAM() {
    local percent=$((progress * 100 / total))
    local num_bar=$((percent / 4))
    local num_space=$((25 - num_bar))
    printf " RAM  ["
    printf "\033[91m%0.s|\e[0m" $(seq 1 $num_bar)
    printf "\033[92m%0.s-\e[0m" $(seq 1 $num_space)
    printf "] %d%%\r" $percent
    printf ",\033[102m\033[30m F: $availableRAM2 \033[101m\033[30m U: $totalresult2 \e[0m T: $installedMem2"
}

draw_progress_bar_RAM
echo -n "\n"

#SWAP
used_swap=$(free -w | awk "NR==3 {print \$3}")
free_swap=$(free -w | awk "NR==3 {print \$4}")
total_swap=$(free -w | awk "NR==3 {print \$2}")

if [ $used_swap -gt 1024000 ]; then
    swap_used=$(echo "scale=2; $used_swap / 1024 / 1024" | bc)
    swapresult=$(echo $swap_used)
    swapresult2=$(echo $swap_used GiB)
else
    swap_used=$(echo "scale=2; $used_swap / 1024" | bc)
    swapresult=$(echo $swap_used)
    swapresult2=$(echo $swap_used MiB)
fi

if [ $free_swap -gt 1024000 ]; then
    free_swap_count=$(echo "scale=2; $free_swap / 1024 / 1024" | bc)
    availableSWAP=$(echo $free_swap_count)
    availableSWAP2=$(echo $free_swap_count GiB)
else
    free_swap_count=$(echo "scale=2; $free_swap / 1024" | bc)
    availableSWAP=$(echo $free_swap_count)
    availableSWAP2=$(echo $free_swap_count MiB)
fi


if [ $total_swap -gt 1024000 ]; then
    total_swap_count=$(echo "scale=2; $total_swap / 1024 / 1024" | bc)
    totalSWAP=$(echo $total_swap_count)
    totalSWAP2=$(echo $total_swap_count GiB)
else
    total_swap_count=$(echo "scale=2; $total_swap / 1024" | bc)
    totalSWAP=$(echo $total_swap_count)
    totalSWAP2=$(echo $total_swap_count MiB)
fi


#Bar SWAP
getswapPercent=$(echo "scale=2; ($swapresult / $totalSWAP) * 100" | bc )
percentageswap=$(printf "%.0f" "$getswapPercent")

progressSWAP=$percentageswap
totalpercentSWAP=100

draw_progress_bar_SWAP() {
    local percentSWAP=$((progressSWAP * 100 / totalpercentSWAP))
    local num_barSWAP=$((percentSWAP / 4))
    local num_spaceSWAP=$((25 - num_barSWAP))
    printf " SWAP ["
    printf "\033[91m%0.s|\e[0m" $(seq 1 $num_barSWAP)
    printf "\033[92m%0.s-\e[0m" $(seq 1 $num_spaceSWAP)
    printf "] %d%%\r" $percentSWAP
    printf ",\033[102m\033[30m F: $availableSWAP2 \033[101m\033[30m U: $swapresult2 \e[0m T: $totalSWAP2"
}

draw_progress_bar_SWAP
echo -n "\n"
echo -n "\n"
echo "             This info will close in 3 seconds"
sleep 3s'

echo -n "------------REALTIME------------"
echo -n "\n"
watch -n1 -tc -g '
#RAM
#Count Used Ram
used=$(free -w | awk "NR==2 {print \$3}")
shared=$(free -w | awk "NR==2 {print \$5}")
buff=$(free -w | awk "NR==2 {print \$6}")
cache=$(free -w | awk "NR==2 {print \$7}")

totalMemUsed=$(($used + $shared + $buff + $cache))


if [ $totalMemUsed -gt 1024000 ]; then
    totaluse=$(echo "scale=2; $totalMemUsed / 1024 / 1024" | bc)
    totalresult=$(echo $totaluse)
    totalresult2=$(echo $totaluse GiB)
else
    totaluse=$(echo "scale=2; $totalMemUsed / 1024" | bc)
    totalresult=$(echo $totaluse)
    totalresult2=$(echo $totaluse MiB)
fi

#Count Installed RAM
totalmem=$(free -w | awk "NR==2 {print \$2}")

if [ $totalmem -gt 1024000 ]; then
    totalmemInstalled=$(echo "scale=2; $totalmem / 1024 / 1024" | bc)
    installedMem=$(echo $totalmemInstalled)
    installedMem2=$(echo $totalmemInstalled GiB)
else
    totalmemInstalled=$(echo "scale=2; $totalmem / 1024" | bc)
    installedMem=$(echo $totalmemInstalled)
    installedMem2=$(echo $totalmemInstalled MiB)
fi

#Count Free RAM
freeRAM=$(free -w | awk "NR==2 {print \$4}")
if [ $freeRAM -gt 1024000 ]; then
    totalfreeRAM=$(echo "scale=2; $freeRAM / 1024 / 1024" | bc)
    availableRAM=$(echo $totalfreeRAM)
    availableRAM2=$(echo $totalfreeRAM GiB)
else
    totalfreeRAM=$(echo "scale=2; $freeRAM / 1024" | bc)
    availableRAM=$(echo $totalfreeRAM)
    availableRAM2=$(echo $totalfreeRAM MiB)
fi

#Bar RAM
getPercent=$(echo "scale=2; ($totalresult / $installedMem) * 100" | bc )
percentage=$(printf "%.0f" "$getPercent")

progress=$percentage
total=100

draw_progress_bar_RAM() {
    local percent=$((progress * 100 / total))
    local num_bar=$((percent / 4))
    local num_space=$((25 - num_bar))
    printf " RAM  ["
    printf "\033[91m%0.s|\e[0m" $(seq 1 $num_bar)
    printf "\033[92m%0.s-\e[0m" $(seq 1 $num_space)
    printf "] %d%%\r" $percent
    printf ",\033[102m\033[30m F: $availableRAM2 \033[101m\033[30m U: $totalresult2 \e[0m T: $installedMem2"
}

draw_progress_bar_RAM
echo -n "\n"

#SWAP
used_swap=$(free -w | awk "NR==3 {print \$3}")
free_swap=$(free -w | awk "NR==3 {print \$4}")
total_swap=$(free -w | awk "NR==3 {print \$2}")

if [ $used_swap -gt 1024000 ]; then
    swap_used=$(echo "scale=2; $used_swap / 1024 / 1024" | bc)
    swapresult=$(echo $swap_used)
    swapresult2=$(echo $swap_used GiB)
else
    swap_used=$(echo "scale=2; $used_swap / 1024" | bc)
    swapresult=$(echo $swap_used)
    swapresult2=$(echo $swap_used MiB)
fi

if [ $free_swap -gt 1024000 ]; then
    free_swap_count=$(echo "scale=2; $free_swap / 1024 / 1024" | bc)
    availableSWAP=$(echo $free_swap_count)
    availableSWAP2=$(echo $free_swap_count GiB)
else
    free_swap_count=$(echo "scale=2; $free_swap / 1024" | bc)
    availableSWAP=$(echo $free_swap_count)
    availableSWAP2=$(echo $free_swap_count MiB)
fi


if [ $total_swap -gt 1024000 ]; then
    total_swap_count=$(echo "scale=2; $total_swap / 1024 / 1024" | bc)
    totalSWAP=$(echo $total_swap_count)
    totalSWAP2=$(echo $total_swap_count GiB)
else
    total_swap_count=$(echo "scale=2; $total_swap / 1024" | bc)
    totalSWAP=$(echo $total_swap_count)
    totalSWAP2=$(echo $total_swap_count MiB)
fi


#Bar SWAP
getswapPercent=$(echo "scale=2; ($swapresult / $totalSWAP) * 100" | bc )
percentageswap=$(printf "%.0f" "$getswapPercent")

progressSWAP=$percentageswap
totalpercentSWAP=100

draw_progress_bar_SWAP() {
    local percentSWAP=$((progressSWAP * 100 / totalpercentSWAP))
    local num_barSWAP=$((percentSWAP / 4))
    local num_spaceSWAP=$((25 - num_barSWAP))
    printf " SWAP ["
    printf "\033[91m%0.s|\e[0m" $(seq 1 $num_barSWAP)
    printf "\033[92m%0.s-\e[0m" $(seq 1 $num_spaceSWAP)
    printf "] %d%%\r" $percentSWAP
    printf ",\033[102m\033[30m F: $availableSWAP2 \033[101m\033[30m U: $swapresult2 \e[0m T: $totalSWAP2"
}

draw_progress_bar_SWAP
echo -n "\n"
echo -n "\n"
echo -n "Press CTRL+C to close this tool"
'

clear
read -p " Press any key to continue"
exit