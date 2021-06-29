#!/bin/sh

wrkspc=$( echo "$( i3-msg -t get_workspaces | jq '.[] | .name' )" | rofi -dmenu -theme oxide )

if [ "$wrkspc" != "" ]
then
    i3-msg "workspace $wrkspc"
fi
