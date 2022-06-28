#!/bin/bash

sudo usermod -G libvirt-qemu -a ${USER}

[ -d "${_PATH_SHARE}" ] || sudo mkdir -p "${_PATH_SHARE}"
sudo setfacl -Rm u:libvirt-qemu:rwx ${_PATH_SHARE}
sudo setfacl -d -Rm u:libvirt-qemu:rwx ${_PATH_SHARE}
sudo setfacl -Rm g:libvirt-qemu:rwx ${_PATH_SHARE}
sudo setfacl -d -Rm g:libvirt-qemu:rwx ${_PATH_SHARE}

_echoyb "Configure in virt-manager the shared path like this with this paramaters:"
echo "Source path: ${_PATH_SHARE}"
echo "Target path: /hostshare"
_echoyb "\nAnd add fmode and dmode by modifying XML settings options in virt-manager:"
echo -e 'filesystem type="mount" accessmode="mapped" '${yellow}'fmode="0664" dmode="0775"'${cclear}'>
  <source dir="/vms/share"/>
  <target dir="/hostshare"/>
  <address type="pci" domain="0x0000" bus="0x07" slot="0x00" function="0x0"/>
</filesystem>'
_ask
