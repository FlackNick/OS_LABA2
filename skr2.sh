#! /usr/bin/env bash
ps -ax pid,command | grep /sbin/ | grep -v "grep" | awk '{print $1}' > task2.txt