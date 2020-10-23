#! /usr/bin/env bash
for line in `ps -axu -o pid,command | awk '{print $1 "," $2}'`
do
    pid=`echo $line | cut -d "," -f 1`
    command=`echo $line | cut -d "," -f 2`
    mem=`grep -s "read_bytes" "/proc/$pid/io" | cut -d ":" -f 2`
    if [[ -n $mem ]]
    then
        echo $pid $command $mem
    fi
done > text7.txt
sleep 1m
for line in `ps -axu -o pid,command | awk '{print $1 "," $2}'`
do
    Pid=`echo $line | cut -d "," -f 1`
    Command=`echo $line | cut -d "," -f 2`
    new_mem=`grep -s "read_bytes" "/proc/$Pid/io" | cut -d ":" -f 2`
    last_mem=`grep $Pid buffer.txt | awk '{print $3}'`
    if [[ -n $new_mem && -n $last_mem ]]
        answer=$(($new_mem - $last_mem))
        echo "PID: $Pid Command: $Command Memory: $answer"
    fi
done | sort -n -t ':' -k 3 | head -3 > text7.txt
rm buffer.txt
