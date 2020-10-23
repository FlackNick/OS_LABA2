#! /usr/bin/env bash
ps -axu -o pid,command | grep /sbin/ | grep -v "grep" | awk '{print $1}' > text2.txt