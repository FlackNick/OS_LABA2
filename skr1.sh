#! /usr/bin/env bash
ps u | sed 1d | wc -l > t1.txt
ps u | sed 1d | awk '{print $2 ": " $11}' >> text1.txt