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

watch -n1 '
total=$(free -h | awk "NR==2 {print \$2}" | sed "s/Mi//g; s/Gi//g; s/Ki//g")
used=$(free -m | awk "NR==2 {print \$3}")
percentage=$((used * 100 / total))

echo "Total RAM: $total"
echo "Memory Used: $used MiB"
echo "Memory Usage: $percentage%"

# Display memory bar
echo "Memory Bar:"
for ((i = 0; i < percentage; i++)); do
    echo -n "*"
done
echo ""
'
