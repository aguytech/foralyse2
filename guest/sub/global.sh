#!/bin/bash

### profile

# add ~/.local/bin to PATH
path=${HOME}/.local/bin
[ -d ${path} ] || mkdir -p ${path}
[ -f ~/.profile ] && . ~/.profile

### upgrade

sudo apt remove -y bluema gimp* libreoffice-* pidgin* thunderbird* transmission-gtk
sudo apt remove -y gnome-sudoku gnome-mines sgt-*
sudo sed -i '/# deb .*partner$/ s|# ||' /etc/apt/sources.list
sudo apt update
sudo apt list --upgradable
sudo apt -y dist-upgrade
sudo apt -y autoremove

##### system

sudo apt install -y binutils-common bsdmainutils curl debconf-utils exfat-utils git gnupg2 gparted hfsprogs htop kpartx lnav most net-tools p7zip-full p7zip-rar pv rar sysstat testdisk tmux tree unrar vim xsysinfo # openssh-server

sudo apt install -y dconf-editor firefox-locale-fr galculator gpicview meld plank qt5ct qt5-gtk2-platformtheme thunar-media-tags-plugin tumbler-plugins-extra

### python

sudo apt-get install -y python3 python3-pip

sudo apt-get install -y python2 # python2-dev
cd /tmp
curl -sSL https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
python2 get-pip.py
python2 -m pip install -U pip

### conf

##### global

sudo swapoff -av && sudo sh -c 'echo vm.swappiness=10 > /etc/sysctl.d/99-swappiness.conf' # limit swap

sudo rm /etc/localtime && sudo ln -sv /usr/share/zoneinfo/Etc/UTC /etc/localtime

##### QT5

file=/etc/X11/Xsession.d/56xubuntu-session
[ -f "${file}" ] && sudo sed -i '/export QT_QPA_PLATFORMTHEME=/ s|=.*$|=qt5ct|' ${file}
export QT_QPA_PLATFORMTHEME=qt5ct # gtk2
echo -e "\n# QT\nexport QT_QPA_PLATFORMTHEME=qt5ct " >> ~/.profile
echo -e "\n#JAVA\nexport _JAVA_OPTIONS=\"-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel \${_JAVA_OPTIONS}\"" >> ~/.profile

_echoyb "After validation, set fusion / darker for qt5"
_ask
qt5ct >/dev/null

### user

paths="~/.local/share/icons ~/.local/share/applications"
for path in ${paths}; do
	[ -d ${path} ] || mkdir -p ${path}
done

cp ${_PATH_SCRIPT}/conf/icons/* ~/.local/share/icons/

##### plank

path=~/.config/autostart
[ -d ${path} ] || mkdir ${path}
echo '[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=plank
Comment=plank
Exec=plank
OnlyShowIn=XFCE;
RunHook=0
StartupNotify=false
Terminal=false
Hidden=false' > ${path}/plank.desktop

_echoyb "After validation, adjust plank preferences"
_ask
plank --preferences &

##### menu

#_echoyb "After validation, modify menu"
#_ask
#menulibre

