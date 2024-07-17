#!/bin/bash
#ddev-generated

# set the directory for the ddev config
DDEV_CONFIG_DIR=${DDEV_CONFIG_DIR:-"/mnt/ddev_config/"}

# set the directory for the ddev project
DDEV_PROJECT_DIR=${DDEV_PROJECT_DIR:-"/var/www/html/"}

# set the target directory
TARGET_DIR="${DDEV_CONFIG_DIR}commands/.targets/"

# include colours and messages
source "${DDEV_CONFIG_DIR}commands/.common/colours.sh"
source "${DDEV_CONFIG_DIR}commands/.common/messages.sh"

