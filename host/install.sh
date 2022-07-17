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

######################## PART

_echoA "- Use from the HOST"

_PARTS_MAN="data share nbd perso"

for _PART in ${_PARTS_MAN}; do
	_source_sub "${_PART}"
done

_echoa "\n-----------------------------------------------"
_echoA "This installation of Host is done \nGo into the guest to complete installation"
