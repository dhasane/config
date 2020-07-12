
if [[ $DISPLAY ]]; then
  export TERM="st"
  export TERMINAL="st"
fi

  export EDITOR="nvim"

  export BROWSER="firefox"

  # export FILE="pcmanfm"
  export FILE="thunar"

  export PATH="$PATH:$HOME/scripts"

  export PATH="$PATH:$HOME/.local/bin/"

  # lenguajes

  export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"

  export PATH="$PATH:$HOME/inst/flutter/bin"

  export PATH="$PATH:$HOME/.cargo/bin"
if [ -e /home/dhas/.nix-profile/etc/profile.d/nix.sh ]; then . /home/dhas/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
