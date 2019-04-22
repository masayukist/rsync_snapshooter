#!/bin/bash

export BACKUP_ROOT=$(cd $(dirname ${0}) && pwd)

source ${BACKUP_ROOT}/config.sh
source ${BACKUP_ROOT}/include/path.sh

DIRSTR=`echo ${BACKUP_ROOT} | sed 's/\//\_/g'`
LOCK_FILE=/tmp/${DIRSTR}_lock
touch ${LOCK_FILE}

flock -x -n ${LOCK_FILE} ${BACKUP_ROOT}/include/snapshot.sh
