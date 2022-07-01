#!/bin/bash

paths="${_PATH_CASE} ${HOME}/.config/gtk-3.0"
for path in ${paths}; do
	[ -d ${path} ] || sudo mkdir -p ${path}
done

# script
sudo cp ${_PATH_SCRIPT}/xtra/mount-cases.sh /usr/local/bin/mount-cases.sh
sudo chmod 755 /usr/local/bin/*.sh
sudo sed -i "/^_PATH_CASE=/ s|=.*$|=${_PATH_CASE}|" /usr/local/bin/mount-cases.sh

# service
sudo cp ${_PATH_SCRIPT}/xtra/mount-cases.service /etc/systemd/system/
sudo sed -i "s|_PATH_CASE|${_PATH_CASE}|g" /etc/systemd/system/mount-cases.service
sudo systemctl enable mount-cases.service
sudo systemctl start mount-cases.service

# bookmarks
file=${HOME}/.config/gtk-3.0/bookmarks
grep -q "file://${_PATH_CASE}" ${file} || echo "file://${_PATH_CASE}" >> ${file}
