#!/bin/bash

######################## CONF

_TRACE=debug
_PATH_BASE=$( readlink -f ${0%/*} )
_PATH_REPO_BS=$( readlink -f ${_PATH_BASE}/../bs )
_PATH_CONF=${HOME}/.config/foralyse
_PATH_LOG=/var/log/foralyse
_CMD="sudo apt"
_CMD_INS="sudo apt install -y"
_FILE_CONF=${_PATH_CONF}/foralyse

# _FILE_CONF
[ -d "${_PATH_CONF}" ] || mkdir -p ${_PATH_CONF}
[ -f "${_FILE_CONF}" ] || { cp ${_PATH_BASE}/conf/foralyse ${_FILE_CONF}; }

# inc
file=${_PATH_REPO_BS}/inc
! [ -f "${file}" ] && echo "Unable to find file: ${file}" && exit 1
! . ${file} && echo "Errors while sourcing file: ${file}" && exit 1

######################## DATA

_echoA "- Use from the HOST"

if [ -z "${_PATH_SHARE}" ]; then
	anstmp=/vms/share
	_askno "Give the shared path from the Host (${anstmp})"
	_PATH_SHARE=${_ANSWER:-${anstmp}}
	_confset _PATH_SHARE "${_PATH_SHARE}"
fi

if [ -z "${_PATH_NBD}" ]; then
	anstmp=/vms/nbd
	_askno "Give the path to mount device files (${anstmp})"
	_PATH_NBD=${_ANSWER:-${anstmp}}
	_confset _PATH_NBD "${_PATH_NBD}"
fi

if [ -z "${_HALT}" ]; then
	_askyn "Enable halt between each parts?"
	_HALT=${_ANSWER}
	_confset _HALT "${_HALT}"
fi

######################## SUB

_source_sub share
_source_sub nbd
_source_sub perso

_echoa "\n-----------------------------------------------"
_echoA "This installation of Host is done \nGo into the guest to complete installation"
