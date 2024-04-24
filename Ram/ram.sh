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
    totaluse=$(echo "scale=2; $totalMemUsed / 1024 / 1024" | bc)
    totalresult=$(echo $totaluse)
    totalresult2=$(echo $totaluse GiB)

else
    totaluse=$(echo "scale=2; $totalMemUsed / 1024" | bc)
    totalresult=$(echo $totaluse)
    totalresult2=$(echo $totaluse MiB)
fi
echo "Total Memory Used $totalresult" | sed "s/MiB//g; s/GiB//g"


totalmem=$(free -w | awk "NR==2 {print \$2}")
echo "Total Installed RAM $totalmem"
if [ $totalmem -gt 1024000 ]; then
    totalmemInstalled=$(echo "scale=2; $totalmem / 1024 / 1024" | bc)
    installedMem=$(echo $totalmemInstalled)
    installedMem2=$(echo $totalmemInstalled GiB)

else
    totalmemInstalled=$(echo "scale=2; $totalmem / 1024" | bc)
    installedMem=$(echo $totalmemInstalled)
    installedMem2=$(echo $totalmemInstalled MiB)
fi

echo "Total Ram Count $installedMem2"

'

#read -p " Press any key to continue"
