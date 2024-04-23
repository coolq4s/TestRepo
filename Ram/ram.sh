#!bin/bash

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

rm -rf TestRepo

clear


i=1
sp="/-\|"
echo -n ' '
while true
do
    printf "\b${sp:i++%${#sp}:1}"
done



exit
