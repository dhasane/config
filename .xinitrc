#!/bin/sh

[[ -f "$HOME/.profile" ]] && . ~/.profile

[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# wallpaper
~/.fehbg &

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

# usar caps como ctrl y esc. como ctrl al usarlo junto a otra tecla
setxkbmap -option 'caps:ctrl_modifier' && xcape -e 'Caps_Lock=Escape' &


# fonts
xset +fp /home/dhas/.fonts
xset fp rehash

# iniciar el wm

#exec dwm
exec i3
# exec sway
# exec startxfce4
