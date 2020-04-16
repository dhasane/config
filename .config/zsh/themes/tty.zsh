
# awesome theme :D
# utilizando como referencia:
# 	re5et
# 	simonoff

# vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
# vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
# vim_mode=$vim_ins_mode
#
# function zle-keymap-select {
#   vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
#   zle reset-prompt
# }
# zle -N zle-keymap-select
#
# function zle-line-finish {
#   vim_mode=$vim_ins_mode
# }
# zle -N zle-line-finish
# # Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# # Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# # Thanks Ron! (see comments)
# function TRAPINT() {
#   vim_mode=$vim_ins_mode
#   return $(( 128 + $1 ))
# }


# if [ "$USER" = "root" ]; then CARETCOLOR="red"; else CARETCOLOR="magenta"; fi

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

# setprompt () {

	###
    # Modify Git prompt
    # ZSH_THEME_GIT_PROMPT_PREFIX=" ["
    # ZSH_THEME_GIT_PROMPT_SUFFIX="]"
#
# local      user='%{$fg_bold[cyan]%}%n%{$reset_color%}'
# local        at='%{$fg[yellow]%}@%{$reset_color%}'
# local      host='%{$fg_bold[blue]%}%m%{$reset_color%}'
# local  conector='%{$fg_bold[yellow]%}::%{$reset_color%}'
# local ubicacion='%{${fg_bold[green]}%}%~%{$reset_color%}'
# local       git='${(e)PR_FILLBAR}$PR_CYAN$(git_prompt_info)%{$reset_color%}'
#
#
# PROMPT="
# ${user}${at}${host}${conector}$ubicacion${git}
# %{${fg[$CARETCOLOR]}%}> %{${reset_color}%}"
#
# }
#
# setprompt
#
# local return_code="%(?..%{$fg_bold[red]%}:( %?%{$reset_color%})"
#
# RPROMPT='${return_code} ${vim_mode}'
#
#
#











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

function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))

    ###
    # Truncate the path if it's too long.

    PR_FILLBAR=""
    PR_PWDLEN=""

    local prompt=${#${(%):---(%n@%m%~)---()}}
    # local prompt=${#$(%n@%m%~)}

    local additional="╭─ ::$(zsh_git)"
    local addsize=${#additional}

    local total="$(($prompt+$addsize))"

    if [[ "$total" -gt $TERMWIDTH ]]; then
        PR_PWDLEN="$(($TERMWIDTH - $total))"
    else
        PR_FILLBAR="\${(l.(($TERMWIDTH - ($total)))..${PR_SPACE}.)}"
    fi
}

source ~/.config/zsh/plugins/git/git.zsh
setopt extended_glob

setprompt () {
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
# The prompt.

    local      user='%{$fg_bold[cyan]%}%n%{$reset_color%}'          # nombre de usuario
    local        at='%{$fg[yellow]%}@%{$reset_color%}'              # simbolo @
    local      host='%{$fg_bold[blue]%}%m%{$reset_color%}'          # nombre del computador
    local  conector='%{$fg_bold[yellow]%}::%{$reset_color%}'        # simbolo ::
    local ubicacion='%{$fg_bold[green]%}%~%{$reset_color%}'         # carpeta actual
    local      gits='$PR_CYAN$(zsh_git)%{$reset_color%}'            # informacion git
    local   espacio='${(e)PR_FILLBAR}'                              # espacio de relleno
    local     caret='%{$fg_bold[$CARETCOLOR]%}> %{$reset_color%}'   # el simbolo para escribir
    if [[ -n $SSH_CONNECTION ]]; then
      local     filer='<--------->'
    else
      local     filer='           '
    fi

PROMPT="
 ${user}${at}${host}${conector}${ubicacion}${filer}${espacio}${gits}
${caret}"

}

setprompt

local return_code="%(?..%{$fg_bold[red]%}:( %?%{$reset_color%})"

RPROMPT='${return_code} ${vim_mode}'


