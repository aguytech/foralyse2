#!/bin/bash

### paths

paths="${HOME}/.local/bin ${HOME}/.local/share/icons ${HOME}/.local/share/applications ${HOME}/.config/geany/colorschemes"
for path in ${paths}; do
	[ -d ${path} ] || mkdir -p ${path}
done

### user

# add ${HOME}/.local/bin to PATH
[ -f "${HOME}/.profile" ] && . ${HOME}/.profile
# icons
cp ${_PATH_SCRIPT}/icons/* ${HOME}/.local/share/icons/
# geany
path=${HOME}/.config/geany/colorschemes
cp ${HOME}/repo/foralyse2/guest/conf/geany/* ${HOME}/.config/geany/colorschemes/

### upgrade

sudo apt remove -y blueman gimp* libreoffice-* pidgin* thunderbird* transmission-gtk
sudo apt remove -y gnome-sudoku gnome-mines sgt-*
sudo apt update
sudo apt list --upgradable
sudo apt -y dist-upgrade
sudo apt -y autoremove

##### system

sudo apt install -y binutils-common bsdmainutils curl debconf-utils exfatprogs genisoimage git gnupg2 gparted hfsprogs htop kpartx lnav most net-tools p7zip-full p7zip-rar pv rar sysstat testdisk tmux tree unrar vim xsysinfo # openssh-server

sudo apt install -y dconf-editor engrampa galculator gpicview meld plank qt5ct qt5-gtk2-platformtheme thunar-media-tags-plugin tumbler-plugins-extra xfce4-taskmanager

### python

sudo apt-get install -y python3 python3-pip
#python3 -m pip install -U pip grip

sudo apt-get install -y python2 # python2-dev
cd /tmp
curl -sSL https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
python2 get-pip.py
python2 -m pip install -U pip

### conf

##### global

sudo cp ${_PATH_SCRIPT}/xtra/*.sh /usr/local/bin/

sudo swapoff -av
sudo sh -c 'echo vm.swappiness=10 > /etc/sysctl.d/99-swappiness.conf' # limit swap
sudo swapon -v

sudo rm /etc/localtime && sudo ln -sv /usr/share/zoneinfo/Etc/UTC /etc/localtime

##### QT5

file=/etc/X11/Xsession.d/56xubuntu-session
[ -f "${file}" ] && sudo sed -i '/export QT_QPA_PLATFORMTHEME=/ s|=.*$|=qt5ct|' ${file}
export QT_QPA_PLATFORMTHEME=qt5ct # gtk2
echo -e "\n# QT\nexport QT_QPA_PLATFORMTHEME=qt5ct " >> ${HOME}/.profile
echo -e "\n#JAVA\nexport _JAVA_OPTIONS=\"-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel \${_JAVA_OPTIONS}\"" >> ${HOME}/.profile

_echoyb "After validation, adjust settings for qt5 and close qt5ct window"
_ask
qt5ct 2>/dev/null

##### plank

cp ${_PATH_SCRIPT}/xtra/plank.desktop ${HOME}/.config/autostart/
_echoyb "After validation, adjust plank preferences and close plank window"
_ask
plank --preferences &
