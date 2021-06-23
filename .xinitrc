#!/bin/sh

sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
userresources=$HOME/.config/X11/.Xresources
usermodmap=$HOME/.config/X11/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
MONITOR_LEFT=$(xgetres monitorLeft)
MONITOR_RIGHT=$(xgetres monitorRight)
xrandr --output $MONITOR_RIGHT --rotate normal
xrandr --output $MONITOR_LEFT --left-of $MONITOR_RIGHT --rotate right

setxkbmap -option caps:swapescape

xsetroot -solid $(xgetres darkerBg)

# Need to start i3 as a child of zsh, so we can simulate a login shell
# This allows .zshenv to export variables that will be used by any
# program launched in i3
exec zsh -c i3
