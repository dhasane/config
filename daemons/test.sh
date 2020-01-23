#!/bin/sh

while :
do
    val=$(ps -p $1 -o %cpu,%mem,cmd)
    echo "$val"
    echo "$val" >> "log_$1"
    sleep 10
done

