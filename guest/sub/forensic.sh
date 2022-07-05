#!/bin/bash

### global

#### binary
sudo apt install -y vbindiff bsdiff

#### network
sudo apt install -y whois

#### pwd & evtx & process
sudo apt install -y john libscca-utils pev

# radare2 via snap
#sudo snap install --edge --jailmode radare2
# from github https://github.com/radareorg/radare2/releases
file=radare2-dev_5.7.2_amd64.deb
curl -L -o /tmp/${file} https://github.com/radareorg/radare2/releases/download/5.7.2/${file}
sudo apt install -y /tmp/${file}

# r2env via pip3
python3 -m pip install -U r2env

#### hive
sudo apt install -y libhivex-bin chntpw reglookup

#### gui
sudo apt install -y bless geany ghex gpicview gtkhash wxhexeditor

### pip

python2 -m pip install -U balbuzard

python3 -m pip install -U malcarve regrippy

### base64sha

file=/usr/local/bin/b64sha
sudo curl -sS https://raw.githubusercontent.com/labcif/Base64SHA/master/b64sha -o ${file}
sudo chmod +x ${file}

### conf

#### bless
path=~/.config/bless/layouts/
[ -d "${path}" ] || mkdir -p ${path}
cp /usr/share/bless/*.layout ${path}/
