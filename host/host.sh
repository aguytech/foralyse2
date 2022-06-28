#!/bin/bash

_PATH_SCRIPT=$( readlink -f ${0%/*} )

### functions

file=${_PATH_SCRIPT}/sub/inc.sh
! [ -f ${file} ] && _exite "Unable to find file: ${file}"
! . ${file} && _exite "Errors encountered. \nSee log files in /var/lkog/foralyse"

### begin

_echoyb "- Use from the HOST"

# user conf
_FILE_CONF=${HOME}/.config/foralyse
[ -f ${_FILE_CONF} ] || cp ${_PATH_SCRIPT}/conf/foralyse ${_FILE_CONF}

tmp=/vms/share
_ask "Give the shared path from the Host (${tmp}): "
_PATH_SHARE=${_ANSWER:-${tmp}}

tmp=/vms/nbd
_ask "Give the path to mount device files (${tmp}): "
_PATH_NBD=${_ANSWER:-${tmp}}
sed -i "/^_PATH_NBD=/ s|=.*$|${_PATH_NBD}|" ${_FILE_CONF}

### sub

_source share.sh
_source nbd.sh
[ -f ${_PATH_SCRIPT}/sub/perso.sh ] && _source perso.sh

_echoy "-----------------------------------------------"
_echoyb "The installation of Host is done \nGo into the guest to complete installation"
