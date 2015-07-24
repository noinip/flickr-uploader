#!/bin/bash
CONFIG="/folders2flickr"
INIT="/etc/my_init.d"

if [[ ! -f $CONFIG/.uploadr.ini ]]; then
	cp $INIT/uploadr.ini $CONFIG/.uploadr.ini
else
	if [[ $CONFIG/.uploadr.ini -nt $INIT/.uploadr.ini ]]; then
		cp $CONFIG/.uploadr.ini $INIT/.uploadr.ini
	fi
fi
