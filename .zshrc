setopt autocd extendedglob nomatch noflowcontrol notify completeinword interactivecomments 

export ZSH="/home/liam/.oh-my-zsh"

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(colored-man-pages zsh-vi-mode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000


source .aliases
