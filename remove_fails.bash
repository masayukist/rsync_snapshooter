#!/bin/bash

export BACKUP_ROOT=$(cd $(dirname ${0}) && pwd)

source ${BACKUP_ROOT}/config.sh
source ${BACKUP_ROOT}/include/path.sh

msg () {
	echo ${0}: ${@}
}

for x in `echo ${BACKUP_ROOT}/SNAPSHOT/*/* | sort -r`
do 
	DIR=${x}
	LOG=${x/SNAPSHOT/LOG}.log
	LOG_COMPRESS=${LOG}.xz
	echo -------------------------
	msg checking the existence of ${LOG_COMPRESS}
	if [ ! -e ${LOG_COMPRESS} ]
	then
		msg The compressed log ${LOG_COMPRESS} does not exist.
		msg $DIR is a failed backup directory. Removing...
		rm -rf ${DIR} 
		if [ -e ${LOG} ]
		then
			msg Remove the uncompressed log file ${LOG}
			rm -rf ${LOG} 
		fi
	fi
done

