#!/bin/bash

### global

sudo apt-get update
sudo apt install -y afflib-tools testdisk ewf-tools xmount fdupes java-common
sudo apt-get install -y imagemagick libde265-0 libheif1

### java

file_soft=$(ls ${_PATH_SHARE}/trans/jdk-8*linux-x64.tar.gz)
if [ -z "${file_soft}" ]; then
	_echoyb "Download jdk v8 from Oracle website \nand put the file jdk-8*linux-x64.tar.gz in shared path: ${_PATH_SHARE}"
	_ask
	file_soft=$(ls ${_PATH_SHARE}/trans/jdk-8*linux-x64.tar.gz)
	[ -z "${file_soft}" ] && _exite "Unable to find file: ${file_soft}"
fi

file=/usr/local/bin/oracle-java-installer.sh
sudo curl -sS https://raw.githubusercontent.com/aguytech/oracle-java-installer/master/oracle-java-installer.sh -o ${file}
sudo sed -i 's|tar -xvzf|tar -xzf|' /usr/local/bin/oracle-java-installer.sh
sudo chmod +x ${file}
sudo ${file} --install ${file_soft}
. /etc/profile.d/jdk.sh
${file} --status ${file_soft}

### sleuthkit

file_soft=$(ls ${_PATH_SHARE}/trans/sleuthkit-java_*_amd64.deb)
if [ -z "${file_soft}" ]; then
	_echoyb "Download sleuthkit deb file from sleuthkit website \nand put the file sleuthkit-java_*_amd64.deb in shared path: ${_PATH_SHARE}"
	_ask
	file_soft=$(ls ${_PATH_SHARE}/trans/sleuthkit-java_*_amd64.deb)
	[ -z "${file_soft}" ] && _exite "Unable to find file: ${file_soft}"
fi

# get versions
# read sleuthkit_version_major sleuthkit_version_minor <<<$(echo ${file_soft}|sed 's|^.*/sleuthkit-java_\([0-9_\.]\+\)-\([0-9]\)_amd64.deb|\1 \2|')

sudo apt install -y ${file_soft}

### autopsy

file_soft=$(ls ${_PATH_SHARE}/trans/autopsy-*.zip)
if [ -z "${file_soft}" ]; then
	_echoyb "Download autopsy for linux from autopsy website \nand put the file autopsy-*.zip in shared path: ${_PATH_SHARE}"
	_ask
	file_soft=$(ls ${_PATH_SHARE}/trans/autopsy-*.zip)
	[ -z "${file_soft}" ] && _exite "Unable to find file: ${file_soft}"
fi

_echoy unzip ${file_soft}
sudo unzip -q -d /opt/ ${file_soft}

path=/opt/autopsy
sudo mv $(ls -d /opt/autopsy-*) ${path}
sudo chown -R ${USER}:${USER} ${path}
cd /opt/autopsy
sh unix_setup.sh

ln -sv ${path}/bin/autopsy ~/.local/bin/autopsy
cp ${_PATH_SCRIPT}/conf/autopsy.desktop ~/.local/share/applications/

_echoyb "After validation, close opened autopsy"
_ask
autopsy --nosplash

### addons

_echoyb "For other addons, see:"
echo '
##### ReportModules / ForensicExpertWitnessReport
https://github.com/chriswipat/forensic_expert_witness_report_module

##### IngestModules / FileHistory
https://medium.com/@markmckinnon_80619/windows-file-history-plugin-a6208da4efa5

##### IngestModules / Volatility
https://markmckinnon-80619.medium.com/volatility-autopsy-plugin-module-8beecea6396
'
