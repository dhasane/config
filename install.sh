#!/usr/bin/env sh

# conseguir los submodulos 
# git submodule update --init --recursive
# git submodule update --recursive --remote

git pull --recurse-submodules

# para imprimir
TAB_SPACES='    '

# crea los directorios que sean necesarios y mueve el archivo a la
# ubicacion dada
move ()
{
    dir="$2"
    tmp="$2"

    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -e "$dir" ] || mkdir -p "$dir"
    mv "$1" "$(dirname "$2")"
}

link() {
    # echo "ln -sv $1 $2"
    ln -sv "$1" "$2"
}

# importante pasar una ruta absoluta como primer parametro
# debido a la forma en la que funciona ln
hacer_link () {
    origen="$1/$3"
    destino="$2/$3"

    # echo "$origen $(dirname $destino) $destino"
    echo "origen: $origen"
    echo "destino: $destino"

    if [ ! -L "$destino" ]
    then
        if [ -f "$destino" ] || [ -d "$destino" ]
        then
            echo "$TAB_SPACES ya existe, moviendo a backup"
            move "$destino" "./backup$destino"
        fi

        echo "$TAB_SPACES haciendo link"
        link "$origen" "$destino"
    else
        echo "$TAB_SPACES ya existe"
    fi
    echo
}

for_each_dir () {
    from="$1"
    to="$2"

    val=$(ls -Ab "$from")
    echo "$from $to"
    for file in $val
    do
        hacer_link "$from" "$to" "$file"
    done
}

echo
echo "home:"
echo

for_each_dir "$(pwd)/home" "$HOME"

echo
echo ".config:"
echo

for_each_dir "$(pwd)/config" "$HOME/.config"
