setfont /usr/share/kbd/consolefonts/ter-112n.psf.gz

# Put path additions here:
export PATH=/home/liam/scripts:$PATH

export EDITOR=nvim

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi
