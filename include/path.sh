#!/bin/bash

SNAPSHOTS_DIR=${BACKUP_ROOT}/snapshots

YEAR=`date +%Y`
DATE=`date +%m%d`

SNAP_DIR=${SNAPSHOTS_DIR}/${YEAR}/${DATE}
LOG_DIR=${BACKUP_ROOT}/log/${YEAR}
LOG_FILE=${LOG_DIR}/${DATE}.log
RSYNC_EXCLUDE_FILE=${BACKUP_ROOT}/exclude.ptn
