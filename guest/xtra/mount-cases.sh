#!/bin/bash

__usage() {
	echo "
${script} <mount/umount>
Mount case devices in path
case device have to be labeled like: 'case*'"
	exit 1
}

__mount() {
	_DEV=$( echo $1 | sed -n 's|^\([^:]\+\):.*|\1|p' )
	eval "$( echo $1 | cut -d' ' -f2- | tr ' ' '\n' | sed 's|^|_|' )"
	#echo -e "_DEV=${_DEV} \n_LABEL=${_LABEL} \n_UUID=${_UUID} \n_BLOCK_SIZE=${_BLOCK_SIZE} \n_TYPE=${_TYPE} \n_PARTUUID=${_PARTUUID}"
	path=${_PATH_CASE}/${_LABEL}_${_UUID}
	[ -d "${path}" ] || mkdir "${path}"
	if grep -q "${path}" /proc/mounts; then
		echo "${path} already mounted"
	else
		mount UUID=${_UUID} ${path}
	fi
}

__umount() {
	_DEV=$( echo $1 | sed -n 's|^\([^:]\+\):.*|\1|p' )
	eval "$( echo $1 | cut -d' ' -f2- | tr ' ' '\n' | sed 's|^|_|' )"
	#echo -e "_DEV=${_DEV} \n_LABEL=${_LABEL} \n_UUID=${_UUID} \n_BLOCK_SIZE=${_BLOCK_SIZE} \n_TYPE=${_TYPE} \n_PARTUUID=${_PARTUUID}"
	path=${_PATH_CASE}/${_LABEL}_${_UUID}
	if grep -q "${path}" /proc/mounts; then
		umount ${path}
	else
		echo "${path} not mounted"
	fi
	[ -d "${path}" ] && rmdir "${path}"
}

__cases() {
	local device
	while read device; do
		__${1} "${device}"
	done <<<$( sudo blkid | grep -i "label=.case" )
}

__init() {
	# variables
	script=${0##*/}

	# case path
	! [ -d "${_PATH_CASE}" ] && echo "Unable to find path: ${_PATH_CASE}" && exit 1
	# Wrong parameters numbers
	[ "$#" -lt 1 ] && echo "Wrong parameters numbers: $#" && __usage
}

_PATH_CASE=
_PATH_CASE=/foralyse/cases

__init $*

case $1 in
	mount)	__cases $1 ;;
	umount)	__cases $1 ;;
	*)				echo "Wrong command given to ${script}"; __usage ;;
esac
