#!/bin/zsh

source $HOME/scripts/xsetup

# Need to start i3 as a child of zsh, so we can simulate a login shell
# This allows .zshenv to export variables that will be used by any
# program launched in i3
exec i3
