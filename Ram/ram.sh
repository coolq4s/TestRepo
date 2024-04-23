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


free -h | awk 'NR==2 {print $2}'
read -p "press enter to continue"


