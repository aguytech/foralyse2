#!/bin/bash

###  SHARE

file=/etc/initramfs-tools/modules
grep -q ^9p ${file} || sudo sh -c "echo '
# qemu share 
9p
9pnet
9pnet_virtio' >> ${file}"
sudo update-initramfs -u

grep -q '^/hostshare' /etc/fstab || sudo sh -c 'echo "
# qemu share
/hostshare                                /share        9p     noauto,trans=virtio,version=9p2000.L,rw,umask=002    0 0" >> /etc/fstab'

[ -d ${_PATH_SHARE} ] || sudo mkdir -p ${_PATH_SHARE}
sudo mount /share

###  CASE

sudo cp ${path_perso}/xtra/*.sh /usr/local/bin/
sudo cp ${path_perso}/xtra/mount-case.service /etc/systemd/system/
sudo sed -i "s|_PATH_CASE|${_PATH_CASE}|g" /etc/systemd/system/mount-case.service
sudo chmod 755 /usr/local/bin/*.sh
sudo systemctl enable mount-case.service
sudo systemctl start mount-case.service
