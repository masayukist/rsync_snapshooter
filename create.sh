#!/bin/bash

export THIS_PATH=$(cd $(dirname ${0}) && pwd)

source ${THIS_PATH}/config.sh
source ${THIS_PATH}/include/path.sh

(
    flock -s 200
    ${THIS_PATH}/include/snapshot.sh
) 200>${THIS_PATH}/snapshots/lock
