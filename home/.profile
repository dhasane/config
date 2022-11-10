#!/bin/env sh
# ~/.profile: executed by the command interpreter for login shells.

# el primer argumento es la variable
# los argumentos de 2 .. N son los programas
# que se intentaran poner como esta variable
# en caso de encontrarse en el sistema
# sirve para poner programas de fallback
if_exists_export()
{
    # esto no sirve en zsh
    # https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion
    #     for i in {2..$#} # esto sirve con zsh y usar $@[$i]
    for i in ${@:2} # todo desde el segundo argumento
    do
        [ "$(command -v "$i")" != "" ] &&
            export "$1"="$i" &&
            break
    done
}

if_exists_export TERMINAL kitty alacritty st
if_exists_export TERM kitty alacritty st
if_exists_export EDITOR emacsclient nvim vim vi
if_exists_export BROWSER firefox
if_exists_export FILE thunar pcmanfm

# export VISUAL

# PATH ------------------------------

# incluir en PATH en caso de existir
add_to_path()
{
    # verifica que no este en el path
    # y que el directorio exista
    # [[ $PATH != *$1(:*|) ]] &&
        [ -d "$1" ] && PATH="$1:$PATH"
}

source_if_exists()
{
    [ -e "$1" ] && . "$1"
}


add_to_path "$HOME"/scripts
add_to_path "$HOME"/bin
add_to_path "$HOME"/.local/bin
#  # lenguajes
add_to_path "$HOME"/.gem/ruby/3.0.0/bin
add_to_path "$HOME"/inst/flutter/bin
add_to_path "$HOME"/.cargo/bin
add_to_path "$HOME"/dragonruby/dragonruby

source_if_exists "$HOME"/.nix-profile/etc/profile.d/nix.sh

# >>> coursier install directory >>>
export PATH="$PATH:/home/daniel/.local/share/coursier/bin"
# <<< coursier install directory <<<
