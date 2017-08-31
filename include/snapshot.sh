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

# remove the old snapshots

REMOVED_SNAPSHOT=`get_snapshot_dirname_xdays_ago 31`

message "the old snapshot ${REMOVED_SNAPSHOT} is a candidcate for being removed"
if [ "`date +%d`" = "01" ]; then
    message "skip removing ${REMOVED_SNAPSHOT} because of keeping a per-month snapshot"
    exit
fi
	
if [ -e ${REMOVED_SNAPSHOT} ]; then
    execute rm -rf ${REMOVED_SNAPSHOT}
    message "finished removing the old snapshot at `date`"
else
    message "the old snapshot ${REMOVED_SNAPSHOT} does not exist"
fi
