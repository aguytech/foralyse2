#!/bin/bash

sudo add-apt-repository -y ppa:wireshark-dev/stable
sudo apt update
sudo apt install -y tshark wireshark

cp ${_PATH_BASE}/xtra/org.wireshark.Wireshark.desktop ~/.local/share/applications/
