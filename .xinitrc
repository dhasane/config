#!/bin/sh

[[ -f "$HOME/.profile" ]] && . ~/.profile

[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# wallpaper
~/.fehbg &

# transparencias
# if [ "$(command -v picom)" != "" ]
# then
#     picom --config ~/.config/picom/picom.conf &
# else if [ "$(command -v compton)" != "" ]
# then
#     compton --config ~/.config/picom/picom.conf &
# fi

[ "$(command -v picom)" != "" ] && picom --config ~/.config/picom/picom.conf &
[ "$(command -v compton)" != "" ] && compton --config ~/.config/picom/picom.conf &

# colores sacados del fondo de pantalla
wal -Rs &

# quitar el mouse cuando no se use
unclutter --timeout 15 &

# battery daemon
# mostrar advertencia cuando la bateria este en 10%
~/daemons/bin/bat_daemon /sys/class/power_supply/BAT*

# idioma del teclado
# setxkbmap -layout la-latin1 &

# fonts
xset +fp /home/dhas/.fonts
xset fp rehash

# iniciar el wm

#exec dwm
exec i3
# exec sway
# exec startxfce4
