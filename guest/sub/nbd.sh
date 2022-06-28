#!/bin/bash

###  nbd

[ -d "${_PATH_NBD}" ] || sudo mkdir -p "${_PATH_NBD}"
file=${_PATH_SCRIPT}/xtra/nbd.sh
fileto=/usr/local/bin/nbd.sh
! [ -f ${file} ] && echo "Unable to find file: ${file}" && exit 1
sed -i "/^_PATH_NBD=/ s|=.*$|=${_PATH_NBD}|" ${file}
sudo cp ${file} ${fileto}
sudo sed -i "/^_PATH_NBD=/ s|=.*$|=${_PATH_NBD}|" ${fileto}
sudo chmod +x /usr/local/bin/nbd.sh

###  Thunar custom actions

[ -d ~/.config/Thunar ] || mkdir -p ~/.config/Thunar
file=~/.config/Thunar/uca.xml
if [ -f ${file} ]; then
	cp -a ${file} ${file}.$(date +%s)
else
	echo -e '<?xml version="1.0" encoding="UTF-8"?>\n<actions>\n</actions>' > ${file}
fi
if ! grep -q 1655620394868230-1 ${file}; then
	sed -i '$,1d' ${file}
	cat ${file} conf/ca.xml > ${file}.tmp
	mv ${file}.tmp ${file}
fi

_echoyb "logout/login from your computer to apply changes"