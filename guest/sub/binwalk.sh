#!/bin/bash

### dependencies

sudo apt install -y mtd-utils gzip bzip2 tar arj lhasa p7zip p7zip-full cabextract cramfsswap squashfs-tools lzop srecord

python3 -m pip install -U nose coverage pycryptodome pyqtgraph capstone matplotlib

##### github

# Install squashfs to extract non-standard SquashFS images
cd /tmp && curl -O https://raw.githubusercontent.com/aguytech/squashfs4.5/master/build.sh
sh build.sh

# Install jefferson to extract JFFS2 file systems
python3 -m pip install -U cstruct
cd /tmp && git clone https://github.com/sviehb/jefferson
cd jefferson && sudo python3 setup.py install
cd .. && sudo rm -fR jefferson

# Install ubi_reader to extract UBIFS file systems
sudo apt install -y liblzo2-dev
python3 -m pip install -U python-lzo
cd /tmp && git clone https://github.com/jrspruitt/ubi_reader
cd ubi_reader && sudo python3 setup.py install
cd .. && sudo rm -fR ubi_reader

# Install yaffshiv to extract YAFFS file systems
cd /tmp && git clone https://github.com/devttys0/yaffshiv
cd yaffshiv && sudo python3 setup.py install
cd .. && sudo rm -fR yaffshiv

# Install unstuff (closed source) to extract StuffIt archive files
mkdir /tmp/sdtraces
cd /tmp/sdtraces && curl -sS http://downloads.tuxfamily.org/sdtraces/stuffit520.611linux-i386.tar.gz | tar -zxv
sudo cp bin/* /usr/local/bin/
cd .. && sudo rm -fR sdtraces

#### binwalk

cd /tmp && git clone https://github.com/ReFirmLabs/binwalk
cd binwalk && sudo python3 setup.py install
cd .. && sudo rm -fR binwalk

binwalk -h
