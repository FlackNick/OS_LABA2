#! /usr/bin/env bash
for i in $(ps -a -u root o pid,command | awk '{print $1 ":" $2}')
do
pid=$(echo $i | cut -d ":" -f 1)
command=$(echo $i | cut -d ":" -f 2)
byte=$(grep -s "read_bytes" /proc/$pid/io | cut -d ":" -f 2)
if [[ -n $byte ]]
then
echo $pid $command $byte
fi
done > temp7.txt
sleep 1m
for i in $(ps -a -u root o pid,command | awk '{print $1 ":" $2}')
do
Pid=$(echo $i | cut -d ":" -f 1)
Command=$(echo $i | cut -d ":" -f 2)
now_byte=$(grep -s "read_bytes" /proc/$Pid/io | cut -d ":" -f 2)
past_byte=$(grep $Pid temp7.txt | awk '{print $3}')
if [[ -n $now_byte && -n $past_byte ]]
count_bytes=$(($now_byte - $past_byte))
echo "Pid: $Pid Command: $Command Bytes:$count_bytes"
fi
done | sort -n -t ':' -k 3 | head -3 > task7.txt
rm temp7.txt
