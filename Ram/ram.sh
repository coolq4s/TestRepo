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

progress_bar() {
  local duration=${1}
    
  already_done() { for ((done=0; done<$1; done++)); do printf "#"; done }
  remaining() { for ((remain=$1; remain<$duration; remain++)); do printf " "; done }
  percentage() { printf "| %s%%" $(( (($1)*100)/($duration)*100/100 )); }
  clean_line() { printf "\r"; }
 
  for (( current_duration=1; current_duration<=$duration; current_duration++ )); do
    already_done $current_duration
    remaining $current_duration
    percentage $current_duration
    clean_line
    sleep 1
  done
 
  clean_line
}
 
# Call the function with the specific duration
progress_bar $percentage

'

read -p " Press any key to continue"
