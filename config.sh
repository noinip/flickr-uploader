#!/bin/bash
CONFIG="/folders2flickr"

if [[ ! -f $CONFIG/.uploadr.ini ]]; then
	cp root/.local/share/folders2flickr/uploadr.ini.sample $CONFIG/.uploadr.ini
else
	if [[ $CONFIG/.uploadr.ini -nt root/.uploadr.ini ]]; then
		cp $CONFIG/.uploadr.ini root/.uploadr.ini
	fi
fi
