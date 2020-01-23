#!/bin/sh
paginas="$HOME/.paginas"
pag=$(cat "$paginas" | rofi -dmenu -theme oxide)
# xargs -r firefox --new-tab
if [ "$pag" != "" ]; then
	firefox --new-tab "$pag"
	#sed "|$pag|d" "$paginas"
fi
