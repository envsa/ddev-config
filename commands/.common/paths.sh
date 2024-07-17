#!/bin/bash
#ddev-generated

# remote location where sql files are stored and rsynced locally to LOCAL_SWAP_CACHE
REMOTE_SWAP_CACHE_DIR="/var/db-backups/${SWAP_DIR_NAME}/${DDEV_PROJECT}/"

# where the local copy of all db sql files live relative to the /scripts/ folder (where the script eg: pull_db.sh is located)
LOCAL_SWAP_CACHE_DIR="${DDEV_PROJECT_DIR}storage/${SWAP_DIR_NAME}/${targetName}/"
