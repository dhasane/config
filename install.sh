#!/usr/bin/env sh

# conseguir los submodulos 
# git submodule update --init --recursive
# git submodule update --recursive --remote

# git pull --recurse-submodules

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

    if [ ! -L "$destino" ]
    then
        printf "origen: %s \t destino: %s\n" "$origen" "$destino"
        if [ -f "$destino" ] || [ -d "$destino" ]
        then
            printf "ya existe, moviendo a backup | "
            move "$destino" "./backup$destino"
        fi
        printf "haciendo link \t"
        link "$origen" "$destino"
        printf "\n"
    fi
}

# para todos los elementos dentro de una carpeta dada por el primer parametro, 
# hacer link a la carpeta en el segundo parametro 
for_each_dir () {
    from="$1"
    to="$2"

    val=$(ls -Ab "$from")
    echo "$from ===> $to:"
    for file in $val
    do
        hacer_link "$from" "$to" "$file"
    done
}

for_each_dir "$(pwd)/home" "$HOME"
for_each_dir "$(pwd)/config" "$HOME/.config"
