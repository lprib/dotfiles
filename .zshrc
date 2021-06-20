setopt autocd extendedglob nomatch noflowcontrol
setopt notify completeinword interactivecomments auto_pushd
setopt pushd_ignore_dups pushdminus long_list_jobs

ZSH="/home/liam/.oh-my-zsh"

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(colored-man-pages zsh-vi-mode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
# remove all aliases set by oh-my-zsh
unalias -m "*"

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000


source .aliases
