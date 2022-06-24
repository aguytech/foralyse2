#!/bin/bash

### volatility3

python3 -m pip install -U pefile yara-python capstone pycryptodome jsonschema leechcorepyc python-snappy

python3 -m pip install -U volatility3
cd ~/.local/bin && ln -sv vol vol3

### volatility2

# https://github.com/volatilityfoundation/volatility/wiki/Installation

##### global

sudo apt install -y pcregrep libpcre++-dev python-dev

python2 -m pip install distorm3 ipython openpyxl pycrypto pytz ujson yara-python

##### libforensic1394

sudo apt install -y cmake

cd /tmp
git clone https://github.com/FreddieWitherden/libforensic1394
cd libforensic1394
mkdir build && cd build
cmake -G"Unix Makefiles" ../
sudo make install
cd ../python
sudo python setup.py install
sudo ln -sv /usr/local/lib/libforensic1394.so.0.3.0 /usr/lib/libforensic1394.so.2

cd
sudo rm -fR /tmp/libforensic1394
sudo apt remove -y cmake
sudo apt -y autoremove

##### volatility

cd /opt
sudo git clone https://github.com/volatilityfoundation/volatility.git
cd volatility
sudo rm -fR .git
sudo python setup.py install

cd /usr/local/bin
sudo ln -sv vol.py vol2

_echoy vol2
vol2 -h

_echoy vol3
vol3 -h
