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

watch -n 1 -tc '
clear
echo "=== RAM Usage ==="
free -h | grep Mem | awk "{printf(\"Used: %s/%s\\n\", \$3, \$2)}"
echo "--------------------"
echo "Memory Usage Bar:"

mem_total=$(free | grep Mem | awk "{print \$2}")
mem_used=$(free | grep Mem | awk "{print \$3}")
mem_percent=$((mem_used * 100 / mem_total))

bar_length=$((mem_percent / 2))
bar_fill=$(printf "%0.s=" $(seq 1 $bar_length))
bar_empty=$(printf "%0.s " $(seq $((50 - bar_length)) 50))

echo -e "[$bar_fill$bar_empty] $mem_percent%"
'

exit
