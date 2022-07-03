#!/bin/bash

_PATH_BASE=$( readlink -f ${0%/*} )

### functions

file=${_PATH_BASE}/sub/inc.sh
! [ -f ${file} ] && echo "Unable to find file: ${file}" && exit 1
! . ${file} && echo "Errors while importing ${file}" && exit 1

### begin

_echoyb "- Use from the GUEST"

# user conf
_FILE_CONF=${HOME}/.config/foralyse
[ -f ${_FILE_CONF} ] || cp ${_PATH_BASE}/conf/foralyse ${_FILE_CONF}
. ${_FILE_CONF}

if [ -z "${_PATH_SHARE}" ]; then
	tmp=/foralyse/share
	_ask "Give the shared path from the Guest (${tmp}): "
	_PATH_SHARE=${_ANSWER:-${tmp}}
	sed -i "/^_PATH_SHARE=/ s|=.*$|=${_PATH_SHARE}|" ${_FILE_CONF}
fi

if [ -z "${_PATH_CASE}" ]; then
	tmp=/foralyse/cases
	_ask "Give the path to mount cases (${tmp}): "
	_PATH_CASE=${_ANSWER:-${tmp}}
	sed -i "/^_PATH_CASE=/ s|=.*$|=${_PATH_CASE}|" ${_FILE_CONF}
fi

if [ -z "${_PATH_NBD}" ]; then
	tmp=/foralyse/nbd
	_ask "Give the path to mount dumped disk (${tmp}): "
	_PATH_NBD=${_ANSWER:-${tmp}}
	sed -i "/^_PATH_NBD=/ s|=.*$|=${_PATH_NBD}|" ${_FILE_CONF}
fi

# share
if grep -q "^/hostshare.*${_PATH_SHARE}" /etc/fstab \
	&& [ -d "${_PATH_SHARE}" ] \
	&& ! grep -q "^/hostshare.*${_PATH_SHARE}" /proc/mounts
then sudo mount ${_PATH_SHARE}
fi

### sub

_source share.sh
_source cases.sh
_source nbd.sh
_source global.sh
[ -f ${_PATH_BASE}/perso/perso.sh ]  && . ${_PATH_BASE}/perso/perso.sh
_source forensic.sh
_source autopsy.sh
_source binwalk.sh
_source regripper.sh
_source volatility.sh
_source wireshark.sh
_source idafree.sh
_source bytecode.sh
_source luyten.sh
_source cfr.sh
# _source kali.sh
#_source pandoc.sh
_source clean.sh

_echoy "\n-----------------------------------------------"
_echoyb "This installation is complete \nRestart the guest"
