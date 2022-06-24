#!/bin/bash

### global

#### network
sudo apt install -y whois

#### pwd & evtx & process
sudo apt install -y john libscca-utils pev radare2

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
[ -d ${path} ] || mkdir -p ${path}
cp /usr/share/bless/*.layout ${path}/
