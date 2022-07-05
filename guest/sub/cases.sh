#!/bin/bash

paths="${_PATH_CASE} ${HOME}/.config/gtk-3.0"
for path in ${paths}; do
	[ -d "${path}" ] || sudo mkdir -p ${path}
done

# script
file=${_PATH_BASE}/xtra/mount-cases.sh
file2=/usr/local/bin/${file##*/}
! [ -f "${file}" ] && _exite "Unable to find file: ${file}"
sudo cp ${file} ${file2}
sudo chmod 755 ${file2}
sudo sed -i "/^_PATH_CASE=/ s|=.*$|=${_PATH_CASE}|" ${file2}

# service
sudo cp ${_PATH_BASE}/xtra/mount-cases.service /etc/systemd/system/
sudo sed -i "s|_PATH_CASE|${_PATH_CASE}|g" /etc/systemd/system/mount-cases.service
sudo systemctl enable mount-cases.service
sudo systemctl start mount-cases.service

# bookmarks
file=${HOME}/.config/gtk-3.0/bookmarks
grep -q "file://${_PATH_CASE}" ${file} || echo "file://${_PATH_CASE}" >> ${file}
