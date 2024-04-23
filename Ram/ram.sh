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
'


read -p " Press any key to continue"
