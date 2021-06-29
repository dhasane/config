#
# Git
#

# robado de oh-my-zsh y de spaceship
# https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md#git-git

GIT_SYMBOL=" "
GIT_PREFIX=" [ "
GIT_SUFFIX=" ]"
GIT_UNION=" ->"

# Check if the current directory is in a Git repository.
# USAGE:
#   is_git
is_git() {
  # See https://git.io/fp8Pa for related discussion
  [[ $(command git rev-parse --is-inside-work-tree 2>/dev/null) == true ]]
}

source ~/.config/zsh/plugins/git/git_status.zsh

function zsh_git_branch() {
  is_git || return
  local ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  echo "${ref#refs/heads/}"
}

function zsh_git() {
    is_git || return

        local branch="$GIT_PREFIX$GIT_SYMBOL$(zsh_git_branch)$GIT_SUFFIX"
        local sts="$(zsh_git_status)"

        if [[ -z $sts ]];
        then
            echo "$branch"
            # return "$branch"
        else
            echo "$branch$GIT_UNION$GIT_PREFIX$sts$GIT_SUFFIX"
            # return "$branch$GIT_UNION$GIT_PREFIX$sts$GIT_SUFFIX"
        fi
}

# el original de oh my zsh
# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
# function git_branch() {
#   local ref
#   ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
#   local ret=$?
#   if [[ $ret != 0 ]]; then
#     [[ $ret == 128 ]] && return  # no git repo.
#     ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
#   fi
#   echo "$GIT_SYMBOL${ref#refs/heads/}"
# }





