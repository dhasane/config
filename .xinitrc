#!/bin/sh

[[ -f "$HOME/.profile" ]] && . ~/.profile

# idioma del teclado
# setxkbmap -layout la-latin1 &

# usar caps como ctrl y esc. como ctrl al usarlo junto a otra tecla
# setxkbmap -option 'caps:ctrl_modifier' && xcape -e 'Caps_Lock=Escape' &
# localectl set-x11-keymap es grp:lctrl_lshift_toggle &

# notifications
# dunst &

# wallpaper
# feh ~/.fehbg &
~/scripts/home_screen.sh
~/scripts/wall.rb

source ~/.xprofile
# iniciar el wm

#exec dwm
exec i3
# exec xmonad
# exec sway
# exec startxfce4
