#!/bin/sh
val=$(find ~/scripts/paginas/sesiones/* | rofi -dmenu )
primer=true
while read -r pag
do
	echo "$pag"
	if [ "$primer" = true ]; then
		firefox --new-window "$pag"
		primer=false
	else
		firefox --new-tab "$pag"
	fi
done < "$val"
