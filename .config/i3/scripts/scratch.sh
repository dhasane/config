#!/usr/bin/env sh

keyboard_type=$("setxkbmap -query | grep layout | awk '{print $2}'")

if [[ "$keyboard_type" == *"us"* ]]
then
    echo "sup"
    bindsym $mod+. [class="St"] scratchpad show
else
    bindsym $mod+less [class="St"] scratchpad show
fi

