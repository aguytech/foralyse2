#!/bin/bash

### global

sudo apt install -y libc6-i686:i386 libexpat1:i386 libffi7:i386 libfontconfig1:i386 libfreetype6:i386 libgcc1:i386 libglib2.0-0:i386 libice6:i386 libpcre3:i386 libpng16-16:i386 libsm6:i386 libstdc++6:i386 libuuid1:i386 libx11-6:i386 libxau6:i386 libxcb1:i386 libxdmcp6:i386 libxext6:i386 libxrender1:i386 zlib1g:i386 libx11-xcb1:i386 libdbus-1-3:i386 libxi6:i386 libsm6:i386 libcurl4:i386
sudo apt install -y libgtk2.0-0:i386 gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386 libpango1.0-0:i386

### IDA

file_soft=$( ls ${_PATH_SHARE}/trans/idafree*_linux.run )
if [ -z "${file_soft}" ]; then
	_echoyb "Download IDA free version from hex-rays.com \nand put the file idafree*_linux.run in shared path: ${_PATH_SHARE}"
	_ask
	file_soft=$( ls ${_PATH_SHARE}/trans/idafree*_linux.run )
	[ -z "${file_soft}" ] && echo "Unable to find file: ${file_soft}" &&  exit 1
fi

path=/opt/idafree
sudo mkdir ${path}
sudo chown ${USER}:${USER} ${path}
_echoyb "After validation, give this path for installation: ${path}"
_ask
sudo chmod +x ${file_soft}
${file_soft}

sudo ln -sv ${path}/ida /usr/local/bin/idafree 
file=~/.local/share/applications/
[ -f ${file} ] && rm ${file}
cp ${_PATH_SCRIPT}/conf/idafree.desktop  ~/.local/share/applications/
