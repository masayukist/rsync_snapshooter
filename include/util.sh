#!/bin/bash

get_snapshot_dirname_xdays_ago ()
{
    YEAR=`date -d "${1} days ago" +%Y`
    DATE=`date -d "${1} days ago" +%m%d`
    DIR=${SNAPSHOTS_DIR}/${YEAR}/${DATE}
    echo ${DIR}
}

get_opt_prev_snapshot_dir ()
{
    DAY_AGO=1
    PREV_SNAP_DIR=`get_snapshot_dirname_xdays_ago ${DAY_AGO}`
    while [ ! -e ${PREV_SNAP_DIR} ]
    do
        if [ ${DAY_AGO} -ge 30 ]
        then
            message "no suitable snapshot is discovered."
            echo ""
            return
        fi
        DAY_AGO=`expr ${DAY_AGO} + 1`
        PREV_SNAP_DIR=`get_snapshot_dirname_xdays_ago ${DAY_AGO}`
    done
    echo "--link-dest ${PREV_SNAP_DIR}"
}
