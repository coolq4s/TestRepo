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
echo "used RAM $used"
shared=$(free -w | awk "NR==2 {print \$5}")
echo "shared value is $shared"
buff=$(free -w | awk "NR==2 {print \$6}")
echo "buff value is $buff"
cache=$(free -w | awk "NR==2 {print \$7}")
echo "cache value is $cache"


totalMemUsed=$($used + $shared + $buff + $cache)
echo "$totalMemUsed"


totaluse=$(($totalMemUsed * 8 / 10000))
echo " $totaluse"
totalmem=$(free -h | awk "NR==2 {print \$2}")
percentage=$(echo "scale=2; ($totaluse / $totalmem) * 100" | bc)


'

#read -p " Press any key to continue"
