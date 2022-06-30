#!/bin/bash

paths="${_PATH_SHARE} ${HOME}/.config/gtk-3.0"
for path in ${paths}; do
	[ -d ${path} ] || sudo mkdir -p ${path}
done

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

# bookmarks
file=${HOME}/.config/gtk-3.0/bookmarks
grep -q "file://${_PATH_SHARE}" ${file} || echo "file://${_PATH_SHARE}" >> ${file}
