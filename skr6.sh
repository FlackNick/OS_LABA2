#! /usr/bin/env bash
max_size=0
pid_max_size=0
for pid in $(ps -ax -o pid)
do
size=`grep -s "VmSize" "/proc/"$pid"/status" | awk '{print $2}'`
if [[ $size -gt $max_size ]]
then
max_size=$size
pid_max_size=$pid
fi
done
top -p $pid_max_size -b -n 1 > buffer.txt
vm_size=$(cat buffer.txt | grep $pid_max_size | awk '{print $5 }')
echo "Pid:$pid_max_size MEM in /proc $max_size MEM in top $vm_size" > t6.txt
rm buffer.txt