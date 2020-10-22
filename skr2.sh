#! /usr/bin/env bash
ps -ax -o pid,command | grep /sbin/ | grep -v "grep" | awk '{print $1}' > t2.txt