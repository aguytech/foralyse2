#!/bin/bash

######################## CONF

_TRACE=debug
_PATH_BASE=$( readlink -f ${0%/*} )
_PATH_CONF=${HOME}/.config/foralyse
_PATH_REPO_BS=$( readlink -f ${_PATH_BASE}/../bs )
_PATH_LOG=/var/log/foralyse
_CMD="sudo apt"
_CMD_INS="sudo apt install -y"
_FILE_CONF=${_PATH_CONF}/foralyse

[ -d "${_PATH_CONF}" ] || mkdir -p ${_PATH_CONF}
[ -f "${_FILE_CONF}" ] || { cp ${_PATH_BASE}/conf/foralyse ${_FILE_CONF}; }

# functions
file=${_PATH_BASE}/../inc
! [ -f "${file}" ] && echo "Unable to find file: ${file}" && exit 1
! . ${file} && echo "Errors while sourcing file: ${file}" && exit 1

######################## BEGIN

_echoA "- Use from the GUEST"

if [ -z "${_PATH_SHARE}" ]; then
	anstmp=/foralyse/share
	_askno "Give the shared path from the Guest (${anstmp})"
	_PATH_SHARE=${_ANSWER:-${anstmp}}
	sed -i "/^_PATH_SHARE=/ s|=.*$|=${_PATH_SHARE}|" ${_FILE_CONF}
fi

if [ -z "${_PATH_CASE}" ]; then
	anstmp=/foralyse/cases
	_askno "Give the path to mount cases (${anstmp})"
	_PATH_CASE=${_ANSWER:-${anstmp}}
	sed -i "/^_PATH_CASE=/ s|=.*$|=${_PATH_CASE}|" ${_FILE_CONF}
fi

if [ -z "${_PATH_NBD}" ]; then
	anstmp=/foralyse/nbd
	_askno "Give the path to mount dumped disk (${anstmp})"
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

parts="share cases nbd init global conf root perso"
parts+=" forensic binwalk regripper autopsy volatility"
parts+=" wireshark idafree bytecode luyten cfr clean"
# kali pandoc
for part in ${parts}; do
	_source_sub ${part}
done

_echoa "\n-----------------------------------------------"
_echoA "This installation is done \nRestart the guest"
