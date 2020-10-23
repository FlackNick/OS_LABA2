#!/bin/bash
ps -axu -o start,pid | sort -k1 | tail -2 | head -1 | awk '{print $2}' > text3.txt