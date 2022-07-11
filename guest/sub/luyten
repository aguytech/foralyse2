#!/bin/bash

file_soft=$( ls ${_PATH_SHARE}/trans/luyten-*.tar.gz )
if [ -z "${file_soft}" ]; then
	_echoyb "Put the pre-package of bytecode  for linux from autopsy website \nand put the file autopsy-*.zip in shared path: ${_PATH_SHARE}"
	_ask
	file_soft=$( ls ${_PATH_SHARE}/trans/luyten-*.tar.gz )
	[ -z "${file_soft}" ] && _exite "Unable to find file: ${file_soft}"
fi

path=/tmp/lt
[ -d "${path}" ] || mkdir -p ${path}
cd ${path}
tar xzf "${file_soft}"
sudo mv opt/luyten* /opt/
sudo mv usr/local/bin/luyten /usr/local/bin/
path=.java/.userPrefs/us/deathmarine/luyten
if ! [ -f ~/${path}/prefs.xml ]; then
	mkdir -p ~/${path}
	mv home/*/${path}/prefs.xml ~/${path}/
fi
mv home/*/.local/share/applications/luyten.desktop ~/.local/share/applications/
cd
rm -fR ${path}
