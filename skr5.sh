#! /usr/bin/env bash
prevPPid=-1
sum=0
counter=0

while read line
do
runtime=$(echo $line | cut -d ":" -f 3 | cut -d "=" -f 2)
PPid=$(echo $line | cut -d ":" -f 2 | cut -d "=" -f 2)
if [[ $prevPPid -eq -1 ]]
then
echo $line
prevPPid=$PPid
sum=$runtime
counter=1
continue
fi
if [[ $PPid -eq $prevPPid ]]
then
echo $line
sum=$(bc <<< "scale=3; $runtime + $sum")
count=$(( count + 1 ))
else
echo "Average_Sleeping_children_of_ParentID=$prevPPid is" $(bc <<< "scale=3; $sum / $count")
echo $line
prevPPid=$PPid
sum=$runtime
counter=1
fi
done < task4.txt > task5.txt