#!/bin/sh

#while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
#    do
#    	sleep 1
#    done &

while true; do
   xsetroot -name "$( date )"
   #xsetroot -name "$( date +"%F %R" )"

   sleep 1m    # Update time every minute
done &
