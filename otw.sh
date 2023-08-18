#!/bin/bash

set -euo pipefail

c1grep() { grep "$@" || test $? = 1; }

main() {
	local REMOTE=

	case "$1" in 
		bandit*)
			REMOTE="$1@bandit.labs.overthewire.org:2220";;
		krypton*)
			REMOTE="$1@krypton.labs.overthewire.org:2231";;
		leviathan*)
			REMOTE="$1@leviathan.labs.overthewire.org:2223";;
		narnia*)
			REMOTE="$1@narnia.labs.overthewire.org:2226";;
		narnia*)
			REMOTE="$1@narnia.labs.overthewire.org:2226";;
		behemoth*)
			REMOTE="$1@behemoth.labs.overthewire.org:2221";;
		formulaone*)
			REMOTE="$1@formulaone.labs.overthewire.org:2232";;
		*)
			echo "No matching wargame!"; exit 1;;
	esac
	
	[ ! -f ~/.ssh/otw_creds ] && touch ~/.ssh/otw_creds
	local PASS=$( c1grep "$1 " ~/.ssh/otw_creds | tr -s ' ' | cut -d' ' -f2)

	if [ -z "$PASS" ]; then
		read -p "Password for $1? " PASS
		echo -e "$1 $PASS" >> ~/.ssh/otw_creds
		# we cant redirect directly or the file will be emptied
		# sponge from moreutils is also good for this
		if command -v sort_otw; then
			cat <<< "$(sort_otw ~/.ssh/otw_creds)" > ~/.ssh/otw_creds
		fi
	else
		echo "Using pass $PASS";
	fi
	
	export TERM=vt100
	echo "Connecting to $REMOTE...";
	exec sshpass -p"$PASS" /usr/bin/ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "ssh://$REMOTE"
}

main "$@"

