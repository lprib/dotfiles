setfont /usr/share/kbd/consolefonts/ter-112n.psf.gz

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export LESSHISTFILE=/dev/null # avoid .lesshist spam in ~
export XAUTHORITY=$XDG_CONFIG_HOME/X11/.Xauthority
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/.pythonrc

# This is required so that bash can source an alternate rc and modify it's HISTFILE
# This is to avoid bash creating .bash_history in home dir
alias bash="bash --init-file $XDG_CONFIG_HOME/bash/.bashrc"

# Put path additions here:
export PATH=/home/liam/scripts:$PATH
source $HOME/.cargo/env

export EDITOR=nvim

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx $XDG_CONFIG_HOME/X11/.xinitrc
fi

