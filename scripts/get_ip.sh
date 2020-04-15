#!/bin/sh

IP=""
while :
do
    nueva_ip="$(curl -s ifconfig.me)"
    if [ "$IP" != "$nueva_ip" ]
    then telegram-send "$nueva_ip"
        IP="$nueva_ip"
        notify-send "cambio de ip: $nueva_ip"
    fi

    sleep 15m

done


