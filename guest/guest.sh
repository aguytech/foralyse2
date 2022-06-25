#!/bin/bash

_PATH_SCRIPT=$( readlink -f ${0%/*} )

### functions

file=${_PATH_SCRIPT}/sub/inc.sh
! [ -f ${file} ] && echo "Unable to find file: ${file}" && exit 1
! . ${file} && echo -e "Errors encountered. \nSee log files in /var/lkog/foralyse" && exit 1

### start

_echoyb "- Use from the GUEST"

_ask "Give the shared path from the Guest (/share): "
_PATH_SHARE=${_ANSWER:-/share}

### sub

_source share.sh
_source global.sh
[ -f ${_PATH_SCRIPT}/sub/perso.sh ]  && _source perso.sh
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
[ -f ${_PATH_SCRIPT}/sub/sublimetext.sh ]  && _source sublimetext.sh
# _source kali.sh
#_source pandoc.sh
_source clean.sh

_echoy "\n-----------------------------------------------"
_echoyb "This installation is complete \nRestart the guest"
