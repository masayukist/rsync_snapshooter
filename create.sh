#!/bin/bash

export BACKUP_ROOT=$(cd $(dirname ${0}) && pwd)

source ${BACKUP_ROOT}/config.sh
source ${BACKUP_ROOT}/include/path.sh

(
    flock -s 200
    ${BACKUP_ROOT}/include/snapshot.sh
) 200>${SNAPSHOTS_DIR}/lock
