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
	[ -z "${_UUID}" ] && path=${_PATH_CASE}/${_LABEL}_${_PARTUUID}

	[ -d "${path}" ] || mkdir "${path}"

	if grep -q "${path}" /proc/mounts; then
		echo "${path} already mounted"
	else
		if [ "${_UUID}" ]; then
			mount UUID=${_UUID} ${path}
		else
			mount PARTUUID=${_PARTUUID} ${path}
		fi
		echo "${path} mounted"
	fi
}

__umount() {
	_DEV=$( echo $1 | sed -n 's|^\([^:]\+\):.*|\1|p' )
	eval "$( echo $1 | cut -d' ' -f2- | tr ' ' '\n' | sed 's|^|_|' )"
	#echo -e "_DEV=${_DEV} \n_LABEL=${_LABEL} \n_UUID=${_UUID} \n_BLOCK_SIZE=${_BLOCK_SIZE} \n_TYPE=${_TYPE} \n_PARTUUID=${_PARTUUID}"
	path=${_PATH_CASE}/${_LABEL}_${_UUID}
	[ -z "${_UUID}" ] && path=${_PATH_CASE}/${_LABEL}_${_PARTUUID}

	if grep -q "${path}" /proc/mounts; then
		umount ${path}
		echo "${path} unmounted"
	else
		echo "${path} already unmounted"
	fi

	[ -d "${path}" ] && rmdir "${path}"
}

__cases() {
	local device
	local cases=$( sudo blkid | grep -i "label=.case" )
	if [ "${cases}" ]; then
		while read device; do
			__${1} "${device}"
		done <<<$( sudo blkid | grep -i "label=.case" )
	else
		echo "Case devices not found"
	fi
}

__init() {
	# variables
	script=${0##*/}

	# case path
	! [ -d "${_PATH_CASE}" ] && echo "Unable to find path: _PATH_CASE=${_PATH_CASE}" && exit 1
	# Wrong parameters numbers
	[ "$#" -lt 1 ] && echo "Wrong parameters numbers: $#" >&2 && __usage
}

_PATH_CASE=

__init $*

case $1 in
	mount)	__cases $1 ;;
	umount)	__cases $1 ;;
	*)				echo "Wrong command given to ${script}" >&2; __usage ;;
esac
