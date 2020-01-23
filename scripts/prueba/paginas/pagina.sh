#!/bin/sh
cat ~/scripts/paginas/sesiones/* | rofi -dmenu -theme oxide | xargs - r firefox --new-tab
