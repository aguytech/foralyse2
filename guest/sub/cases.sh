#!/bin/bash

[ -d ${_PATH_CASE} ] || sudo mkdir -p ${_PATH_CASE}

sudo cp ${_PATH_SCRIPT}/xtra/*.sh /usr/local/bin/
sudo cp ${_PATH_SCRIPT}/xtra/mount-cases.service /etc/systemd/system/
sudo sed -i "s|_PATH_CASE|${_PATH_CASE}|g" /etc/systemd/system/mount-cases.service
sudo chmod 755 /usr/local/bin/*.sh
sudo systemctl enable mount-cases.service
sudo systemctl start mount-cases.service
