#!/usr/bin/env bash

# conseguir los submodulos 
# git submodule update --init --recursive
# git submodule update --recursive --remote

git pull --recurse-submodules

TAB_SPACES='    '

# ./{*,.*}
# for f in {*,.*} 
# do 
#     echo "$f -> ~/$f"
# done

# find . -exec echo "File is {} -> ~/{}" \;

move ()
{
    dir="$2"
    tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -a "$dir" ] ||
        mkdir -p "$dir" &&
        mv "$@"
}

link() {
    # echo "ln -sv $1 $2"
    ln -sv "$1" "$2"
}

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
            move "$origen" "./backup/$origen"
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

for_each_dir "$(pwd)/home" "$HOME"

echo
echo ".config:"
echo

for_each_dir "$(pwd)/config" "$HOME/.config"
