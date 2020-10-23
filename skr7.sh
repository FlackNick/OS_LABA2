#! /usr/bin/env bash
for line in $(ps -ax -o pid,command | awk '{print $1 ":" $2}')
do
pid=$(echo $line | cut -d ":" -f 1)
command=$(echo $line | cut -d ":" -f 2)
mem=$(grep -s "read_bytes" /proc/$pid/io | cut -d ":" -f 2)
if [[ -n $mem ]]
then
echo $pid $command $mem
fi
done > t7.txt
sleep 1m
for line in $(ps -ax -o pid,command | awk '{print $1 ":" $2}')
do
Pid=$(echo $line | cut -d ":" -f 1)
Command=$(echo $line | cut -d ":" -f 2)
new_mem=$(grep -s "read_bytes" /proc/$Pid/io | cut -d ":" -f 2)
last_mem=$(grep $Pid buffer.txt | awk '{print $3}')
if [[ -n $new_mem && -n $last_mem ]]
answer=$(($new_mem - $last_mem))
echo "Pid: $Pid Command: $Command Bytes:$answer"
fi
done | sort -n -t ':' -k 3 | head -3 > t7.txt
rm buffer.txt
