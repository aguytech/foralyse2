#!/bin/bash

_PATH_BASE=$( readlink -f ${0%/*} )

### functions

file=${_PATH_BASE}/../inc
! [ -f "${file}" ] && echo "Unable to find file: ${file}" && exit 1
! . ${file} && echo "Errors while sourcing file: ${file}" && exit 1

### begin

_echoA "- Use from the HOST with Xubuntu 18.04 bionic already installed"

anstmp=/vms/share
_ask "Give the shared path from the Host (${anstmp}): "
_PATH_SHARE=${_ANSWER:-${anstmp}}

anstmp=/vms/nbd
_ask "Give the path to mount device files (${anstmp}): "
_PATH_NBD=${_ANSWER:-${anstmp}}
sed -i "/^_PATH_NBD=/ s|=.*$|${_PATH_NBD}|" ${_FILE_CONF}

### sub

_source_sub share
_source_sub nbd
_source_sub perso

_echoa "-----------------------------------------------"
_echoA "The installation of Host is done \nGo into the guest to complete installation"
