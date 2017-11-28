#!/bin/bash

message ()
{
    mkdir -p ${LOG_DIR}
    echo ${THIS_SCRIPT}: $* >> ${LOG_FILE} 2>&1
}

execute ()
{
    mkdir -p ${LOG_DIR}
    echo ${THIS_SCRIPT}: $* >> ${LOG_FILE} 2>&1
    $* >> ${LOG_FILE} 2>&1
}

compresslog ()
{
    xz ${LOG_FILE}
}
