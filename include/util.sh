#!/bin/bash

get_snapshot_dirname_xdays_ago ()
{
    YEAR=`date -d "${1} days ago" +%Y`
    DATE=`date -d "${1} days ago" +%m%d`
    DIR=${SNAPSHOTS_DIR}/${YEAR}/${DATE}
    echo ${DIR}
}

get_snapshot_logfile_xdays_ago ()
{
    YEAR=`date -d "${1} days ago" +%Y`
    DATE=`date -d "${1} days ago" +%m%d`
    LOGFILE=${LOG_BASE_DIR}/${YEAR}/${DATE}.log
    echo ${LOGFILE}
}

get_prev_snapshot_dir ()
{
    DAY_AGO=1
    PREV_SNAP_DIR=`get_snapshot_dirname_xdays_ago ${DAY_AGO}`
    while [ ! -e ${PREV_SNAP_DIR} ]
    do
        if [ ${DAY_AGO} -ge 365 ]
        then
            message "no suitable snapshot is discovered within 365 days."
            echo ""
            return
        fi
        DAY_AGO=`expr ${DAY_AGO} + 1`
        PREV_SNAP_DIR=`get_snapshot_dirname_xdays_ago ${DAY_AGO}`
    done
    echo ${PREV_SNAP_DIR}
}

get_opt_prev_snapshot_dir ()
{
    PREV_SNAP_DIR=`get_prev_snapshot_dir`
    echo "--link-dest ${PREV_SNAP_DIR}"
}

remove_snapshot_dir ()
{
    #REMOVED_SNAPSHOT=`get_snapshot_dirname_xdays_ago 31`
    REMOVED_SNAPSHOT=${1}

    message "the old snapshot ${REMOVED_SNAPSHOT} is a candidate for being removed"
	
    if [ -e ${REMOVED_SNAPSHOT} ]; then
	execute rm -r ${REMOVED_SNAPSHOT}
	message "finished removing the old snapshot at `date`"
    else
	message "the old snapshot ${REMOVED_SNAPSHOT} does not exist"
    fi
}

remove_file ()
{
    REMOVED_FILE=${1}
    
    if [ -e ${REMOVED_FILE} ]; then
	execute rm ${REMOVED_FILE}
	message "finished removing the file ${REMOVED_FILE}"
    else
	message "${REMOVED_FILE} does not exist and not removed"
    fi
}
