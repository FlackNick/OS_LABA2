#! /usr/bin/env bash
for pid in `ps -ax -o pid`
do
    PPid=`grep -s "PPid"  "/proc/"$pid"/status" | awk '{print $2}'`
    sum_exec_runtime=`grep -s "sum_exec_runtime"  "/proc/"$pid"/sched" | awk '{print $3}'`
    nr_switches=`grep -s "nr_switches"  "/proc/"$pid"/sched" | awk '{print $3}'`
    if [[ -n $nr_switches && -n $sum_exec_runtime ]]
    then
        art=`bc <<< "scale=3;$sum_exec_runtime/$nr_switches"`
        echo "ProcessID=$pid : Parent_ProcessID=$PPid : Average_Running_Time=$art"
    fi
done | sort -n -t '=' -k 3 > text4.txt