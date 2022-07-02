#!/bin/bash

###  install

sudo apt install -y qemu-utils

###  conf

# paths
paths="${_PATH_NBD} ${HOME}/.config/gtk-3.0"
for path in ${paths}; do
	[ -d ${path} ] || sudo mkdir -p ${path}
done

# script
file=${_PATH_SCRIPT}/xtra/nbd.sh
file2=/usr/local/bin/${file##*/}
! [ -f ${file} ] && _exite "Unable to find file: ${file}"
sudo cp ${file} ${file2}
sudo chmod +x ${file2}
sudo sed -i "/^_PATH_NBD=/ s|=.*$|=${_PATH_NBD}|" ${file2}

# bookmarks
file=${HOME}/.config/gtk-3.0/bookmarks
grep -q "file://${_PATH_NBD}" ${file} || echo "file://${_PATH_NBD}" >> ${file}

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
