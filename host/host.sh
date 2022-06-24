#!/bin/bash

_PATH_SCRIPT=$( readlink -f ${0%/*} )

### functions

file=${_PATH_SCRIPT}/sub/inc.sh
! [ -f ${file} ] && echo "Unable to find file: ${file}" && exit 1
! . ${file} && echo -e "Errors encountered. \nSee log files in /var/lkog/foralyse" && exit 1

### start

_echoyb "- Use from the HOST"

_ask "Give the shared path from the Host (/vms/share): "
_PATH_SHARE=${_ANSWER:-/vms/share}

_ask "Give the path to mount qcow2 files (/vms/nbd): "
_PATH_NBD=${_ANSWER:-/vms/nbd}

### sub

_source share.sh
_source nbd.sh
[ -f ${_PATH_SCRIPT}/sub/perso.sh ] && _source perso.sh

_echoy "-----------------------------------------------"
_echoyb "The installation of Host is done \nGo into the guest to complete installation"
