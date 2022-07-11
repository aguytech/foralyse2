#!/bin/bash

_PATH_BASE=$( readlink -f ${0%/*} )

### functions

file=${_PATH_BASE}/../inc
! [ -f "${file}" ] && echo "Unable to find file: ${file}" && exit 1
! . ${file} && echo "Errors while sourcing file: ${file}" && exit 1

### begin

_echoyb "- Use from the GUEST"

if [ -z "${_PATH_SHARE}" ]; then
	anstmp=/foralyse/share
	_ask "Give the shared path from the Guest (${anstmp}): "
	_PATH_SHARE=${_ANSWER:-${anstmp}}
	sed -i "/^_PATH_SHARE=/ s|=.*$|=${_PATH_SHARE}|" ${_FILE_CONF}
fi

if [ -z "${_PATH_CASE}" ]; then
	anstmp=/foralyse/cases
	_ask "Give the path to mount cases (${anstmp}): "
	_PATH_CASE=${_ANSWER:-${anstmp}}
	sed -i "/^_PATH_CASE=/ s|=.*$|=${_PATH_CASE}|" ${_FILE_CONF}
fi

if [ -z "${_PATH_NBD}" ]; then
	anstmp=/foralyse/nbd
	_ask "Give the path to mount dumped disk (${anstmp}): "
	_PATH_NBD=${_ANSWER:-${anstmp}}
	sed -i "/^_PATH_NBD=/ s|=.*$|=${_PATH_NBD}|" ${_FILE_CONF}
fi

# share
if grep -q "^/hostshare.*${_PATH_SHARE}" /etc/fstab \
	&& [ -d "${_PATH_SHARE}" ] \
	&& ! grep -q "^/hostshare.*${_PATH_SHARE}" /proc/mounts
then
	sudo mount ${_PATH_SHARE}
fi

### sub

parts="share cases nbd global perso"
parts+=" forensic autopsy binwalk regripper volatility"
parts+=" wireshark idafree bytecode luyten cfr clean"
# kali pandoc
for part in ${parts}; do
	_source ${part}
done

_echoy "\n-----------------------------------------------"
_echoyb "This installation is complete \nRestart the guest"
