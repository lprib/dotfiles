export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

export LESSHISTFILE=/dev/null # avoid .lesshist spam in ~

# MOVE SHIT OUT OF THE HOME DIRECTORY AND INTO .config

# This is required so that bash can source an alternate rc and modify it's HISTFILE
# This is to avoid bash creating .bash_history in home dir
alias bash="bash --init-file $XDG_CONFIG_HOME/bash/.bashrc"

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/.pythonrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# Put path additions here:
export PATH=/home/liam/scripts:$PATH
source $HOME/.cargo/env

export EDITOR=nvim
