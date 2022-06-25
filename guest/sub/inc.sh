#!/bin/bash

# colors
white='\e[0;0m'; red='\e[0;31m'; green='\e[0;32m'; blue='\e[0;34m'; magenta='\e[0;95m'; yellow='\e[0;93m'; cyan='\e[0;96m';
whiteb='\e[1;1m'; redb='\e[1;31m'; greenb='\e[1;32m'; blueb='\e[1;34m'; magentab='\e[1;95m'; yellowb='\e[1;93m'; cyanb='\e[1;96m'; cclear='\e[0;0m';

# PATH
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"

# logs
path_log=/var/log/foralyse
_FILE_DONE=${path_log}/foralyse.done
sudo [ -d ${path_log} ] || sudo mkdir -p ${path_log}
sudo chown ${USER}:${USER} -R ${path_log}
[ -f ${_FILE_DONE} ] || touch ${_FILE_DONE}

exec 1> >( tee -a ${path_log}/foralyse.log )    2> >( tee -a ${path_log}/foralyse.err )

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
_ask() {
	msg="$*"
	[ -z "${msg}" ] && msg="Validate to continue: "
	echo  -en "${yellow}${msg}${cclear}"
	read _ANSWER
}
_source() {
	if ! grep -q ^$1 ${_FILE_DONE}; then
		echo -e "\n${yellowb}> $1${cclear}"
		local file="${_PATH_SCRIPT}/sub/$1"
		! [ -f "${file}" ] && echo "Unable to find file: ${file}" && exit 1
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
