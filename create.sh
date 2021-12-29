#!/bin/bash

set -euo pipefail

export BACKUP_ROOT=$(cd $(dirname ${0}) && pwd)

if [ ! -e ${BACKUP_ROOT}/config.sh ]; then
    echo ERROR: generate ${BACKUP_ROOT}/config.sh based on ${BACKUP_ROOT}/config.sh.sample
    exit 1
fi

source ${BACKUP_ROOT}/config.sh
source ${BACKUP_ROOT}/include/path.sh
source ${BACKUP_ROOT}/include/logging.sh

message "starting logging."

DIRSTR=`echo ${BACKUP_ROOT} | sed 's/\//\_/g'`
LOCK_FILE=/tmp/${DIRSTR}_lock
touch ${LOCK_FILE}

message "starting snapshot.sh script."
execute flock -x -n ${LOCK_FILE} ${BACKUP_ROOT}/include/snapshot.sh
