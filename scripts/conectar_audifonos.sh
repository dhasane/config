#!/bin/sh

connect()
{
    rep=0
	ret="inicio"
	while [ -n "$ret" ]
	do
        rep=$((rep+1))
        ret=$(bluetoothctl connect 00:18:09:A2:DC:0D | grep Fail)
		# echo "$ret"
	done
    echo "connected after $rep attempts"
}

if [ -z "$1" ]
then
    sudo rfkill unblock bluetooth
    connect
else
    while getopts dr option
    do
        if [ "$option" = "d" ] || [ "$option" = "r" ]; then
            sudo rfkill block bluetooth
        fi
        if [ "$option" = "r" ]; then
            sudo rfkill unblock bluetooth
            connect
        fi
    done
fi



# if [ "$1" = "-d" ]
# then # desconectar audifonos
#     sudo rfkill block bluetooth
# elif [ "$1" = "-r" ]
# then # deconectar y reconectar
#     sudo rfkill block bluetooth
#     sudo rfkill unblock bluetooth
#     connect
# else # conectar audifonos
#
#     sudo rfkill unblock bluetooth
#     connect
# fi
