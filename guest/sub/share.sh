#!/bin/bash

###  SHARE

[ -d ${_PATH_SHARE} ] || sudo mkdir -p ${_PATH_SHARE}

file=/etc/initramfs-tools/modules
grep -q ^9p ${file} || sudo sh -c "echo '
# qemu share 
9p
9pnet
9pnet_virtio' >> ${file}"
sudo update-initramfs -u

grep -q '^/hostshare' /etc/fstab || sudo sh -c 'echo "
# qemu share
/hostshare                                '${_PATH_SHARE}'        9p     noauto,trans=virtio,version=9p2000.L,rw,umask=002    0 0" >> /etc/fstab'

sudo mount ${_PATH_SHARE}

###  CASE

[ -d ${_PATH_CASE} ] || sudo mkdir -p ${_PATH_CASE}

sudo cp ${_PATH_SCRIPT}/xtra/*.sh /usr/local/bin/
sudo cp ${_PATH_SCRIPT}/xtra/mount-cases.service /etc/systemd/system/
sudo sed -i "s|_PATH_CASE|${_PATH_CASE}|g" /etc/systemd/system/mount-cases.service
sudo chmod 755 /usr/local/bin/*.sh
sudo systemctl enable mount-cases.service
sudo systemctl start mount-cases.service
