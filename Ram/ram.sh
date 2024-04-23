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

watch -n1 -tc'
total=$(free -h | awk "NR==2 {print $2}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
echo -e " $total"
'

read -p " Press any key to continue"
