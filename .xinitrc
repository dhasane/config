#!/bin/sh

# organizacion pantalla
~/scripts/home_screen.sh
# wallpaper
# ~/scripts/wall.rb

# idioma del teclado
# setxkbmap -layout la-latin1 &

# usar caps como ctrl y esc. como ctrl al usarlo junto a otra tecla
# setxkbmap -option 'caps:ctrl_modifier' && xcape -e 'Caps_Lock=Escape' &
# localectl set-x11-keymap es grp:lctrl_lshift_toggle &

# notifications
# dunst &

# wallpaper
~/.fehbg &

[[ -f "$HOME/.profile" ]] && . ~/.profile
[[ -f "$HOME/.xprofile" ]] && . ~/.xprofile

# iniciar el wm

# exec notion
# exec gnome-session
exec i3
# exec stumpwm
# exec dwm
# exec xmonad
# exec sway
# exec startxfce4
