# SPDX-License-Identifier: GPL-3.0-only

escape()
{
	sed 's/[/]/\\&/g' <<< "$1"
}

parse_file()
{
	local cur=0
	local tot=$(wc -l < "$1")
	local prev=
	while :; do
		if [[ $prev ]]; then
			read comment rest <<< "$prev"
			prev=
		else
			if ! read comment rest; then
				break
			fi
			(( cur++ ))
		fi

		if [[ -z "$rest" ]]; then
			continue;
		fi

		if [[ "$rest" =~ ^\<BRNOTE\>(.+)\<BRNOTE\>$ && ! $2 ]]; then
			note "$(eval echo ${BASH_REMATCH[1]})"
			continue
		elif [[ ! "$rest" =~ ^\<BR\>(.+)\<BR\>(.+) ]]; then
			continue
		fi

		local fmt=${BASH_REMATCH[1]}
		local ap=$(eval echo ${BASH_REMATCH[2]})

		if [[ $cur -eq $tot ]]; then
			# calibration of $cur and $tot is not necessary
			echo >> "$1"
		fi

		read
		(( cur++ ))

		content=$(printf "$fmt" $ap)
		sed -i "${cur}s/.*/$(escape "$content")/" "$1"
		if [[ ! $cur -lt $tot ]]; then
			break
		fi

		read
		(( cur++ ))

		if [[ ! $REPLY ]]; then
			continue
		fi

		sed -i "${cur}s/.*/\n$(escape "$REPLY")/" "$1"
		(( cur++ ))
		(( tot++ ))
		prev="$REPLY"
	done < "$1"
}

bakdir="$ABSGEN/asset.bac"
mkdir -p $bakdir
exit_on_error

lncnt=0
initwr=1
while read; do
	(( lncnt++ ))
	if skip_line "$REPLY"; then
		continue
	fi

	cols=$(echo $REPLY | wc -w)
	if [[ $cols != '2' && $cols != '3' ]]; then
		error "an invalid line was found at line $lncnt"
		continue
	fi

	read target dest action <<< "$REPLY"
	src="$PWD/$ASSETLIST/$target"

	if [[ ! -f "$src" ]]; then
		error "target ‘$target’ does not exist"
		continue
	fi

	eval=
	sudo=
	if [[ -n "$action" ]]; then
		action="${action//,/ }"
		if find_word 'eval' $action; then
			eval=1
		fi

		if find_word 'sudo' $action; then
			sudo=1
		fi
	fi

	if [[ $dest =~ ^'~' ]]; then
		dest="$HOME/${dest:2}"
	fi

	if [[ ${dest:0-1} = '/' ]]; then
		dest+=$target
	fi

	skip_ln=
	if [[ -h $dest && $(readlink $dest) = $src ]]; then
		if [[ ! $eval ]]; then
			continue
		else
			skip_ln=1
		fi
	fi

	if [[ ! $skip_ln ]]; then
		dir=$(dirname $dest)
		if [[ ! -d $dir ]]; then
			if [[ -f $dir ]]; then
				error "‘$dir’ is a regular file" \
				      "(target ‘$target’)"
			elif [[ $sudo ]]; then
				sudo mkdir -p $dir
			else
				mkdir -p $dir
			fi
			if [[ $? -ne 0 ]]; then
				continue
			fi
		fi

		if [[ ! -h $dest && -f $dest ]]; then
			if ! cp $dest "$bakdir/$target~$(basename $dest)"; then
				warn "failed to back up ‘$dest’" \
				     "(target ‘$target’)"
				continue
			fi
		fi

		if [[ $sudo ]]; then
			sudo ln -sf $src $dest
		else
			ln -sf $src $dest
		fi
		if [[ $? -ne 0 ]]; then
			continue
		fi

		if [[ $initwr ]]; then
			echo_line_sep $CURSCR
			initwr=
		fi

		echo_linked $target $dest
	fi

	if [[ $eval ]]; then
		parse_file $src $skip_ln
	fi
done < "$CONFLIST/filelinks"
