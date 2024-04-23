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

used=$(free -h | awk 'NR==3 {print $3}' | sed "s/Mi//g; s/Gi//g; s/Ki//g")
shared=$(free -h | awk 'NR==5 {print $5}' | sed "s/Mi//g; s/Gi//g; s/Ki//g")
buff=$(free -h | awk 'NR==6 {print $6}' | sed "s/Mi//g; s/Gi//g; s/Ki//g")
total=$(free -h | awk 'NR==2 {print $2}' | sed "s/Mi//g; s/Gi//g; s/Ki//g")

totalused=($used+$shared+$buff)
echo -e " $totalused"

echo -e " $total"


read -p " Press any key to continue"
