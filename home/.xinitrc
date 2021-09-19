#!/bin/sh

# organizacion pantalla
~/scripts/home_screen.sh
# wallpaper
# ~/scripts/wall.rb

# idioma del teclado
# setxkbmap -layout la-latin1 &

# usar caps como ctrl y esc. como ctrl al usarlo junto a otra tecla
# localectl set-x11-keymap es grp:lctrl_lshift_toggle &

setxkbmap -option 'caps:ctrl_modifier'
# setxkbmap -option ctrl:swapcaps     # Swap Left Control and Caps Lock

xcape -e 'Caps_Lock=Escape' &

# cambiar entre esp e ing
# setxkbmap -option grp:alt_shift_toggle "us,es"

# notifications
dunst &

# tray
nm-applet &
blueberry-tray &

# lockscreen
xautolock -time 25 -locker "xlock -mode hop" &
xss-lock &

# programas
# thunderbird &
# telegram-desktop &
~/scripts/daemons/bin/bat_daemon

# wallpaper
~/.fehbg &

[[ -f "$HOME/.profile" ]] && . ~/.profile
[[ -f "$HOME/.xprofile" ]] && . ~/.xprofile

# iniciar el wm

exec_wn() {
    exec "$1" > "~/$1.log"
}

# exec /home/daniel/dev/penrose_config/target/release/penrose_config &> ~/.penrose.log

# exec notion
# exec gnome-session
# exec i3
# exec stumpwm
# exec dwm
exec xmonad > ~/.xmonad.log
# exec sway
# exec startxfce4
