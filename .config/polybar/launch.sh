#!/bin/bash

# Takes one argument: 'i3' or 'dwm', which is passed to the polybar executable as an evironment variable

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export WINDOW_MANAGER_MODULE="${1:-i3}"
polybar --reload leftbar &
polybar --reload rightbar &
