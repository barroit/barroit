cat << EOF
The following options need to be set
	keyboard model			    to	General 105-key PC
	country of origin for the keyboard  to	Japanese
EOF

waiting_user

sudo dpkg-reconfigure keyboard-configuration
exit_on_error

export COMMENT='#'
export SUPERUSER=
export IOTARGET="$HOME/.profile"
  write_on_missing 'xmodmap "$HOME/.Xmodmap"'
  source $IOTARGET