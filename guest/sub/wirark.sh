#!/bin/bash

sudo add-apt-repository -y ppa:wireshark-dev/stable
${_CMD} update
${_CMD_INS} tshark wireshark

cp ${_PATH_BASE}/xtra/org.wireshark.Wireshark.desktop ~/.local/share/applications/
