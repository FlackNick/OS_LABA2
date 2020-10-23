#! /usr/bin/env bash
sum=0
counter=0
prev_ppid=-999

while read line
do
    runtime=`echo $line | cut -d ":" -f 3 | cut -d "=" -f 2`
    PPid=`echo $line | cut -d ":" -f 2 | cut -d "=" -f 2`
    if [[ $prev_ppid -eq -999 ]]
    then
        echo $line
        prev_ppid=$PPid
        sum=$runtime
        counter=1
        continue
    fi
    if [[ $PPid -eq $prev_ppid ]]
    then
        echo $line
        sum=`bc <<< "scale=3; $runtime + $sum"`
        count=$(( count + 1 ))
    else
        echo "Average_Sleeping_children_of_ParentID=$prev_ppid is" `bc <<< "scale=3; $sum / $count"`
        echo $line
        prev_ppid=$PPid
        sum=$runtime
        counter=1
    fi
done < task4.txt > task5.txt