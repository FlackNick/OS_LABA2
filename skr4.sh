#! /usr/bin/env bash
for pid in $(ps -ax -o pid)
do
PPid=`grep -s "PPid"  "/proc/"$pid"/status" | awk '{print $2}')`
Runtime=`grep -s "sum_exec_runtime"  "/proc/"$pid"/sched" | awk '{print $3}')`
Switch=`grep -s "nr_switches"  "/proc/"$pid"/sched" | awk '{print $3}')`
if [[ -n $Switch && -n $Runtime ]]
then
Art=$(bc <<< "scale=5; $Runtime/$Switch")
echo "ProcessID=$pid : Parent_ProcessID=$PPid : Average_Running_Time=$Art"
fi
done | sort -n -t = -k 3 > t4.txt