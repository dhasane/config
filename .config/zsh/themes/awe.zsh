
# awesome theme :D
# utilizando como referencia:
# 	re5et
# 	simonoff

# me gustaria pensar una mejor manera de mostrar el modo de uso

# vim_ins_mode="%{$fg_bold[cyan]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg_bold[green]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

# esto cambia los colores dependiendo del estado
function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  CARETCOLOR="${${KEYMAP/vicmd/blue}/(main|viins)/magenta}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
  zle reset-prompt
}
zle -N zle-line-finish


# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

# hasta aqui va el modo vi


# if [ "$USER" = "root" ]; then CARETCOLOR="red"; else CARETCOLOR="magenta"; fi
CARETCOLOR="magenta"

# Prompt
#
# Below are the color init strings for the basic file types. A color init
# string consists of one or more of the following numeric codes:
# Attribute codes:
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes:
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white

# source ~/.config/zsh/plugins/git/git.zsh

function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))

    PR_FILLBAR=""

    # lo importante esta       aqui       el resto no lo entiendo :v
    local prompt=${#${(%):---(%n@%m%~)---()}}

    # local additional="╭─ ::$(zsh_git)" # caracteres adicionales
    local additional="╭─ ::$(git_prompt_info)" # caracteres adicionales
    local addsize=${#additional} # esto saca la longitud del texto

    # por alguna razon nunca cuadra completamente
    # entonces por eso siempre tengo que sumarle espacios en blanco
    local desfaz=9 # no estoy seguro por que ocurrira
    local total="$(($prompt+$addsize-$desfaz))"

    ###
    # Truncate the path if it's too long.
    (( PR_PWDLEN = $TERMWIDTH - $total ))
    if [[ "$total" -gt $TERMWIDTH ]]; then
        local pprompt=${#${(%):---(%~)---()}}
        (( total = $total - $pprompt + ${#${PWD##*/}} + $desfaz ))
    fi
    PR_FILLBAR="\${(l.(($TERMWIDTH - ($total)))..${PR_SPACE}.)}"
}


setopt extended_glob

setprompt () {


    # antes como que se llamaba automaticamente o algo
    # pero cuando lo puse aca, por fin pude usar las
    # variables globales definidas dentro :v
    # no entiendo, debi hacer algo mal, pero por
    # lo menos esta funcionando
    # precmd
###
# Need this so the prompt will work.

    setopt prompt_subst

###
# See if we can use colors.

    autoload zsh/terminfo
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"


###
# las variables que representan el prompt

    local      user="%{$fg_bold[cyan]%}%n%{$reset_color%}"          # nombre de usuario
    local        at="%{$fg[yellow]%}@%{$reset_color%}"              # simbolo @
    local      host="%{$fg_bold[blue]%}%m%{$reset_color%}"          # nombre del computador
    local  conector="%{$fg_bold[yellow]%}::%{$reset_color%}"        # simbolo ::



    # # tambien pense el la opcion de poner pwd en una linea adicional
    # # debajo del usuario, pero en este momento tengo pereza de intentarlo
    # local ret=""
    # if [[ "$PR_PWDLEN" -lt 0 ]]; then  # carpeta actual
    #     # solo la carpeta
    #     # esto es para cuando no haya suficiente
    #     # espacio en la pantalla para mostrar todo
    #     ret='${PWD##*/}'
    #
    #     # para truncar
    #     # (( PR_PWDLEN = PR_PWDLEN * -1 ))
    #     # ret='%~%$PR_PWDLEN...<'
    # else
    #     # path completo hasta la carpeta
    #     ret='%~'
    # fi
    # local ubicacion="%{$fg_bold[green]%}${ret}%{$reset_color%}"



    local ubicacion="%{$fg_bold[green]%}${~}%{$reset_color%}"      # carpeta actual
    # local      gits="$PR_CYAN$(zsh_git)%{$reset_color%}"          # informacion git
    local      gits="$PR_CYAN$(git_prompt_info)%{$reset_color%}"    # informacion git
    local   espacio='${(e)PR_FILLBAR}'                              # espacio de relleno
    local     caret="%{$fg_bold[$CARETCOLOR]%}> %{$reset_color%}"   # el simbolo para escribir

PROMPT="
╭─ ${user}${at}${host}${conector}${ubicacion}${espacio}${gits}
╰─${caret}"

}

setprompt

# en caso de errores
local return_code="%(?..%{$fg_bold[red]%}:( %?%{$reset_color%})"

# prompt izquierdo
RPROMPT='${return_code} ${vim_mode}'


