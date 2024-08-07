# SPDX-License-Identifier: GPL-3.0-only

COMMENT='#'

SUPERUSER=
IOTARGET=$ALIASES

lncnt=0
while read name value; do
	(( lncnt++ ))
	if skip_line "$name"; then
		continue
	fi

	if [[ -z "$value" ]]; then
		error "an invalid line was found at line $lncnt, skipped"
		continue
	fi

	write_on_missing "alias $name='$value'"
done < "$CONFLIST/aliases"

IOTARGET=$BASHRC
  write_on_missing '. ~/.bash_aliases'
  source $BASHRC
