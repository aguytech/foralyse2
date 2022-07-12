#!/bin/bash

######################## CONF

_PATH_BASE=$( readlink -f ${0%/*} )
_PATH_CONF=${HOME}/.config/foralyse
_PATH_LOG=/var/log/foralyse
_CMD="sudo apt"
_CMD_INS="sudo apt install -y"
_TRACE=info
_FILE_CONF=${_PATH_CONF}/foralyse

[ -f "${_FILE_CONF}" ] || { cp ${_PATH_BASE}/conf/foralyse ${_PATH_CONF}/; }

# functions
file=${_PATH_BASE}/../inc
! [ -f "${file}" ] && echo "Unable to find file: ${file}" && exit 1
! . ${file} && echo "Errors while sourcing file: ${file}" && exit 1

######################## BEGIN

_echoA "- Use from the HOST"

if [ -z "${_PATH_SHARE}" ]; then
	anstmp=/vms/share
	_askno "Give the shared path from the Host (${anstmp})"
	_PATH_SHARE=${_ANSWER:-${anstmp}}
	sed -i "/^_PATH_SHARE=/ s|=.*$|=${_PATH_SHARE}|" ${_FILE_CONF}
fi

if [ -z "${_PATH_NBD}" ]; then
	anstmp=/vms/nbd
	_askno "Give the path to mount device files (${anstmp})"
	_PATH_NBD=${_ANSWER:-${anstmp}}
	sed -i "/^_PATH_NBD=/ s|=.*$|${_PATH_NBD}|" ${_FILE_CONF}
fi

### sub

_source_sub share
_source_sub nbd
_source_sub perso

_echoa "-----------------------------------------------"
_echoA "This installation of Host is done \nGo into the guest to complete installation"
