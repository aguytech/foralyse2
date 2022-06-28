#!/bin/bash

action=$1 && shift

case ${action} in
	start)
		[ -z "$1" ] && echo "No mount point given to mount.sh" && exit 1
		if blkid | grep -q "LABEL=\"$1\"" && grep -q "^UUID=.* */$1 *" /etc/fstab; then
			mount $1
		fi
	;;

	stop)
		umount $1
	;;
	*)
		echo "No command given to ${0##*/}"
		exit 1
	;;
esac
