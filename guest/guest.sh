#!/bin/bash

_PATH_SCRIPT=$( readlink -f ${0%/*} )

### functions

file=${_PATH_SCRIPT}/sub/inc.sh
! [ -f ${file} ] && echo "Unable to find file: ${file}" && exit 1
! . ${file} && echo -e "Errors encountered. \nSee log files in /var/lkog/foralyse" && exit 1

### begin

_echoyb "- Use from the GUEST"

# user conf
_FILE_CONF=${HOME}/.config/foralyse
[ -f ${_FILE_CONF} ] || cp ${_PATH_SCRIPT}/conf/foralyse ${_FILE_CONF}

tmp=/foralyse/share
_ask "Give the shared path from the Guest (${tmp}): "
_PATH_SHARE=${_ANSWER:-${tmp}}
sed -i "/^_PATH_SHARE=/ s|=.*$|${_PATH_SHARE}|" ${_FILE_CONF}

tmp=/foralyse/case
_ask "Give the path to mount case (${tmp}): "
_PATH_CASE=${_ANSWER:-${tmp}}
sed -i "/^_PATH_CASE=/ s|=.*$|${_PATH_CASE}|" ${_FILE_CONF}

tmp=/foralyse/nbd
_ask "Give the path to mount dumped disk (${tmp}): "
_PATH_NBD=${_ANSWER:-${tmp}}
sed -i "/^_PATH_NBD=/ s|=.*$|${_PATH_NBD}|" ${_FILE_CONF}

### sub

_source share.sh
_source nbd.sh
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
