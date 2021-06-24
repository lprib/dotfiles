source $HOME/scripts/globals

for file in $ZDOTDIR/completions/*; do
	source $file
done
