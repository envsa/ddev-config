#!/bin/bash
#ddev-generated

# skip the first line of content pipe into this
CMD_SKIP_FIRST_LINE="tail -n +2"

# commands to run inside of ddev
CMD_LOCAL_MYSQL="mysql"
CMD_LOCAL_REBUILD="composer install"
CMD_LOCAL_RSYNC="rsync"

# command to run a single mysql query
# -B (no borders)
# -N (no column names)
# -e (execute)
CMD_LOCAL_MYSQL_EXECUTE="${CMD_LOCAL_MYSQL} -BNe"

# command to run rsync
# -a (retain attributes)
# -z (compress during transit)
# --info=progress2 (show overall progress)
# --delete (delete any local files no longer held remotely)
CMD_LOCAL_RSYNC_EXECUTE="$CMD_LOCAL_RSYNC -az --info=progress2 --delete -e \"ssh -q\""

# remote commands to run on the server
CMD_REMOTE_MYSQL="mysql"
CMD_REMOTE_MYSQLDUMP="mysqldump"

# get all table names from mysql
MYSQL_SHOW_TABLES="show tables"

# drop a table `%` if it exists and ignore forign keys only while doing the drop
MYSQL_DROP_TABLE="SET FOREIGN_KEY_CHECKS = 0; drop table if exists %; SET FOREIGN_KEY_CHECKS = 1;"

# read the last updated date from the local swap file log for the current evironment
MYSQL_READ_SWAP_LOG="select updated from ${SWAP_LOG_TABLE} where environment='${ENVIRONMENT}'"

# insert a record in the swap log for the current environment
MYSQL_INSERT_SWAP_LOG="insert into ${SWAP_LOG_TABLE} (environment, updated) values ('${ENVIRONMENT}', now())"

# setting the swap date for the current environment
MYSQL_UPDATE_SWAP_LOG="update ${SWAP_LOG_TABLE} set environment='${ENVIRONMENT}', updated=now() where environment='${ENVIRONMENT}'"

# removing the record of the swap date for the current environment
MYSQL_DELETE_SWAP_LOG="delete from ${SWAP_LOG_TABLE} where environment='${ENVIRONMENT}'"

# reads the last environement we updated from (shows the current state of the ddev database)
MYSQL_READ_LAST_SWAP_LOG="select environment from ${SWAP_LOG_TABLE} order by updated desc limit 1"

# scripts to run to initialize craft installation
REMOTE_END_RUN_SCRIPTS="
  cd /app/${target[mysqlDatabase]}/current > /dev/null 2>&1;
  php craft clear-caches/all --interactive=0 > /dev/null 2>&1;
  php craft up --interactive=0 > /dev/null 2>&1;
"

if [[ "${isVerbose}" = 1 ]] ; then
  REMOTE_END_RUN_SCRIPTS="
    cd /app/${target[mysqlDatabase]}/current ;
    php craft clear-caches/all --interactive=0 ;
    php craft up --interactive=0 ;
  "
fi
