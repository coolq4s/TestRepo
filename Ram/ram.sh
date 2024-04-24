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
shared=$(free -w | awk "NR==2 {print \$5}")
buff=$(free -w | awk "NR==2 {print \$6}")
cache=$(free -w | awk "NR==2 {print \$7}")

totalMemUsed=$(($used + $shared + $buff + $cache))


if [ $totalMemUsed -gt 1024000 ]; then
    totaluse=$(echo "scale=2; $totalMemUsed / 1024 / 1024" | bc) # Convert to GiB
    echo "Total memory used: $totaluse GiB"
    
else
    totaluse=$(echo "scale=2; $totalMemUsed / 1024" | bc)
    echo "Total memory used: $totaluse MiB"
fi
echo "$totaluse"

#totalmem=$(free -h | awk "NR==2 {print \$2}")
#percentage=$(echo "scale=2; ($totaluse / $totalmem) * 100" | bc)


'

#read -p " Press any key to continue"
