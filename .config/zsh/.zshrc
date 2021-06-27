setopt autocd extendedglob nomatch noflowcontrol
setopt notify completeinword interactivecomments auto_pushd
setopt pushd_ignore_dups pushdminus long_list_jobs

ZSH="/home/liam/.oh-my-zsh"

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(colored-man-pages command-not-found zsh-vi-mode zsh-syntax-highlighting z)

# prev_aliases=$(alias -L) # cache previous aliases
source $ZSH/oh-my-zsh.sh
# unalias -m "*" # remove all aliases set by oh-my-zsh
eval "$prev_aliases" #reinstate previous aliases

HISTFILE=$XDG_DATA_HOME/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000


source $ZDOTDIR/.aliases
