# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

#if [[ $DISPLAY ]]; then
#   export TERM="st"
#   export TERMINAL="st"
#fi

# el primer argumento es la variable
# los argumentos de 2 .. N son los programas
# que se intentaran poner como esta variable
# en caso de encontrarse en el sistema
# sirve para poner programas de fallback
if_exists_export()
{
    as=$1
    for i in {2..$#}
    do
        program=$@[${i}]
        [ "$(command -v $program)" != "" ] && export $as="$program" && break
    done
}

if_exists_export TERMINAL alacritty
if_exists_export EDITOR emacsclient nvim vim vi
if_exists_export BROWSER firefox

#  export FILE="pcmanfm"
#  export FILE="thunar"

# PATH ------------------------------

# incluir en PATH en caso de existir
add_to_path()
{
    # verifica que no este en el path
    # y que el directorio exista
    [[ $PATH != *"$1"(:*|) ]] && [ -d "$1" ] && PATH="$1:$PATH"
}

add_to_path $HOME/scripts
add_to_path $HOME/bin
add_to_path $HOME/.local/bin
#  # lenguajes
add_to_path $HOME/.gem/ruby/2.7.0/bin
add_to_path $HOME/inst/flutter/bin
add_to_path $HOME/.cargo/bin
add_to_path $HOME/dragonruby/dragonruby

# $HOME/scripts/ssh-agent-autostart.sh

if [ -e /home/dhas/.nix-profile/etc/profile.d/nix.sh ]; then . /home/dhas/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

