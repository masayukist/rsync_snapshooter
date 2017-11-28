#!/bin/bash

set -eu

THIS_PATH=$(cd $(dirname ${0}) && pwd)
BACKUP_ROOT=$(cd ${THIS_PATH}/.. && pwd)

source ${BACKUP_ROOT}/config.sh
source ${BACKUP_ROOT}/include/path.sh

THIS_SCRIPT=`basename ${0}`
source ${BACKUP_ROOT}/include/logging.sh
source ${BACKUP_ROOT}/include/util.sh

# sync from the original directory referring the previous snapshot directory

PREV_SNAP_DIR_OPT=`get_opt_prev_snapshot_dir`

message "a new snapshot directory is ${SNAP_DIR}"
execute mkdir -p ${SNAP_DIR}
message "syncronization started at `date`"
execute rsync --delete -e ssh ${PREV_SNAP_DIR_OPT} --exclude-from=${RSYNC_EXCLUDE_FILE} -avlz ${ORIGINAL_DIR}/ ${SNAP_DIR}
message "syncronization finished at `date`"

# remove the old snapshots and keep a per-month snapshot

REMOVED_SNAPSHOT=`get_snapshot_dirname_xdays_ago 31`

if [ "`date +%d`" = "01" ]; then
    message "skip removing ${REMOVED_SNAPSHOT} because of keeping a per-month snapshot"
else
    remove_snapshot_dir ${REMOVED_SNAPSHOT}
fi

# remove all the old snapshots 1 year ago

REMOVED_SNAPSHOT=`get_snapshot_dirname_xdays_ago 365`
remove_snapshot_dir ${REMOVED_SNAPSHOT}
REMOVED_SNAPSHOT_LOG=`get_snapshot_logfile_xdays_ago 365`
remove_file ${REMOVED_SNAPSHOT_LOG}.xz

compresslog
