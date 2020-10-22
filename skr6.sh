#! /usr/bin/env bash
MaxSize=0
Pid_of_MaxSize=0
for pid in $(ps -a -u root o pid)
do
Size=`grep -s "VmSize" "/proc/"$pid"/status" | awk '{print $2}'`
if [[ $Size -gt $MaxSize ]]
then
MaxSize=$Size
Pid_of_MaxSize=$pid
fi
done
top -p $Pid_of_MaxSize -b -n 1 > task6.txt
vmSize=$(cat task6.txt | grep $Pid_of_MaxSize | awk '{print $5 }')