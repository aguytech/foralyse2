#!/bin/bash

file_soft=$( ls ${_PATH_SHARE}/trans/cfr-*.tar.gz )
if [ -z "${file_soft}" ]; then
	_echoyb "Put the pre-package of bytecode  for linux from autopsy website \nand put the file autopsy-*.zip in shared path: ${_PATH_SHARE}"
	_ask
	file_soft=$( ls ${_PATH_SHARE}/trans/cfr-*.tar.gz )
	[ -z "${file_soft}" ] && echo "Unable to find file: ${file_soft}" &&  exit 1
fi

path=/tmp/cf
[ -d ${path} ] || mkdir -p ${path}
cd ${path}
tar xzf "${file_soft}"
sudo mv opt/cfr /opt/
sudo mv usr/local/bin/cfr /usr/local/bin/
cd
rm -fR ${path}
