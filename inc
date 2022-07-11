#!/bin/bash

_echoy() {
	echo -e "${yellow}$*${cclear}"
}
_echoyb() {
	echo -e "${yellowb}$*${cclear}"
}
_echor() {
	echo -e "${red}$*${cclear}"
}
_echorb() {
	echo -e "${redb}$*${cclear}"
}
_exite() {
	echo -e "!!  $*  !!" >&2
	exit 1
}
_ask() {
	msg="$*"
	[ -z "${msg}" ] && msg="Validate to continue: "
	echo  -en "${yellow}${msg}${cclear}"
	read _ANSWER
}
_source() {
	# skip perso if not found
	[ "$1" = perso ] && ! [ -f ${_PATH_BASE}/perso/perso ] && return

	if ! grep -q ^$1 ${_FILE_DONE}; then
		echo -e "\n${yellowb}> $1${cclear}"
		local file="${_PATH_BASE}/sub/$1"
		! [ -f "${file}" ] && _exite "Unable to find file: ${file}"
		if . "${file}"; then
			echo $1 >> ${_FILE_DONE}
			echo -e "${yellowb}< $1${cclear}\n"
			_ask
		else
			echo -e "${redb}See file log $1 for errors${cclear}"
			exit
		fi
	fi
}

# colors
white='\e[0;0m'; red='\e[0;31m'; green='\e[0;32m'; blue='\e[0;34m'; magenta='\e[0;95m'; yellow='\e[0;93m'; cyan='\e[0;96m';
whiteb='\e[1;1m'; redb='\e[1;31m'; greenb='\e[1;32m'; blueb='\e[1;34m'; magentab='\e[1;95m'; yellowb='\e[1;93m'; cyanb='\e[1;96m'; cclear='\e[0;0m';
# data
_FILE_DONE=${HOME}/.config/foralyse.done
_FILE_CONF=${HOME}/.config/foralyse
path_log=/var/log/foralyse

# create paths
for path in ${HOME}/.config ${HOME}/.local/bin /var/log/foralyse; do
	[ -d "${path}" ] || mkdir -p ${path}
done
sudo chown ${USER}:${USER} -R ${path_log}

# exec
exec 1> >( tee -a ${path_log}/foralyse.log )    2> >( tee -a ${path_log}/foralyse.err )
# PATH
export PATH="${HOME}/.local/bin:${PATH}"
# done
[ -f "${_FILE_DONE}" ] || touch ${_FILE_DONE}
# user conf
[ -f "${_FILE_CONF}" ] || cp ${_PATH_BASE}/conf/foralyse ${_FILE_CONF}
. ${_FILE_CONF}
