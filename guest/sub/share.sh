#!/bin/bash

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
