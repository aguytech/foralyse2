#!/bin/bash

###  nbd

[ -d "${_PATH_NBD}" ] || sudo mkdir -p "${_PATH_NBD}"
file=${_PATH_SCRIPT}/xtra/nbd.sh
fileto=/usr/local/bin/nbd.sh
! [ -f ${file} ] && echo "Unable to find file: ${file}" && exit 1
sudo cp ${file} ${fileto}
sudo sed -i "/^_PATH_NBD=/ s|=.*$|=${_PATH_NBD}|" ${fileto}
sudo chmod +x /usr/local/bin/nbd.sh

###  Thunar custom actions

file=~/.config/Thunar/uca.xml
[ -d ~/.config/Thunar ] || mkdir -p ~/.config/Thunar
if [ -f ${file} ]; then
	[ -f ${file}.keep ] || cp -a ${file} ${file}.keep
else
	echo -e '<?xml version="1.0" encoding="UTF-8"?>\n<actions>\n</actions>' > ${file}
fi

# update already made
grep -q 1655620394868230-1 ${file} && return

sed -i '$,1d' ${file}
cat ${file} ${_PATH_SCRIPT}/conf/ca.xml > ${file}.tmp
mv ${file}.tmp ${file}

_echoyb "logout/login from your computer to apply changes"
