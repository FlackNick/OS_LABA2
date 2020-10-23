#! /usr/bin/env bash
for pid in `ps -ax -o pid`
do
    echo $pid
    y=8
    if [[ y -eq 8 ]]
    then 
        echo 123123123
    fi
done