#!/bin/bash

message ()
{
    THIS_SCRIPT=`basename ${0}`
    mkdir -p ${LOG_DIR}
    echo -e "`date`\t${THIS_SCRIPT}: $*" >> ${LOG_FILE} 2>&1
}

execute ()
{
    THIS_SCRIPT=`basename ${0}`
    mkdir -p ${LOG_DIR}
    echo -e "`date`\t${THIS_SCRIPT}: $*" >> ${LOG_FILE} 2>&1
    $* >> ${LOG_FILE} 2>&1
}

compresslog ()
{
    message "compress log file"
    xz ${LOG_FILE}
}
