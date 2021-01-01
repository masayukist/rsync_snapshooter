#!/bin/bash

set -eu

THIS_PATH=$(cd $(dirname ${0}) && pwd)

source ${BACKUP_ROOT}/config.sh
source ${BACKUP_ROOT}/include/path.sh

THIS_SCRIPT=`basename ${0}`
source ${BACKUP_ROOT}/include/logging.sh
source ${BACKUP_ROOT}/include/util.sh

# sync from the original directory referring the previous snapshot directory
PREV_SNAP_DIR=`get_prev_snapshot_dir`
PREV_SNAP_DIR_OPT=`get_opt_prev_snapshot_dir`

message "a new snapshot directory is ${SNAP_DIR}"
execute mkdir -p ${SNAP_DIR}
message "syncronization started at `date`"
execute rsync ${RSYNC_OPT} ${PREV_SNAP_DIR_OPT} --exclude-from=${RSYNC_EXCLUDE_FILE} ${ORIGINAL_DIR}/ ${SNAP_DIR}
message "syncronization finished at `date`"

if [ "${KEEP_ONLY_ONE_BACKUP}" = "yes" ]; then
    remove_snapshot_dir "${PREV_SNAP_DIR}"
else
    # remove the old snapshots and keep a per-month snapshot
    REMOVED_SNAPSHOT=`get_snapshot_dirname_xdays_ago 30`
    if [ "`date +%d`" = "01" ]; then
	message "skip removing ${REMOVED_SNAPSHOT} because of keeping a per-month snapshot"
    else
	remove_snapshot_dir "${REMOVED_SNAPSHOT}"
    fi
fi

# remove all the old snapshots 1 year ago
REMOVED_SNAPSHOT=`get_snapshot_dirname_xdays_ago 365`
remove_snapshot_dir "${REMOVED_SNAPSHOT}"
REMOVED_SNAPSHOT_LOG=`get_snapshot_logfile_xdays_ago 365`
remove_log "${REMOVED_SNAPSHOT_LOG}.xz"

message "finished at `date`"
compresslog
