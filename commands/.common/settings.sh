#!/bin/bash
#ddev-generated

# Get the directory of the currently executing script
CURRENT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."

# capture the time the script started running
RUN_STARTED=$(date +%s)

# universal name for the db cache
SWAP_DIR_NAME="db-swap-cache"

# tables to exclude from the db dump - wrapped with commas so we can do a unique match
EXCLUDED_DB_TABLES=(
  ",cache,"
  ",templatecaches,"
  ",templatecachecriteria,"
  ",templatecacheelements,"
  ",templatecachequeries,"
  ",table_name,"
)

REMOTE_IGNORED_DB_TABLES_STRING=""
for TABLE in "${EXCLUDED_DB_TABLES[@]}"
do
  REMOTE_IGNORED_DB_TABLES_STRING+="--ignore-table=${target[mysqlDatabase]}.${GLOBAL_DB_TABLE_PREFIX}${TABLE} "
done

# Additional arguments for mysqldump
MYSQLDUMP_ADDITIONAL_ARGS=""
MYSQLDUMP_ADDITIONAL_ARGS+="--add-drop-table "
MYSQLDUMP_ADDITIONAL_ARGS+="--no-tablespaces "
MYSQLDUMP_ADDITIONAL_ARGS+="--comments "
MYSQLDUMP_ADDITIONAL_ARGS+="--create-options "
MYSQLDUMP_ADDITIONAL_ARGS+="--dump-date "
MYSQLDUMP_ADDITIONAL_ARGS+="--no-autocommit "
MYSQLDUMP_ADDITIONAL_ARGS+="--routines "
MYSQLDUMP_ADDITIONAL_ARGS+="--set-charset "
MYSQLDUMP_ADDITIONAL_ARGS+="--triggers "

# Arguments to dump just the schema
MYSQLDUMP_SCHEMA_ARGS=""
MYSQLDUMP_SCHEMA_ARGS+="--single-transaction "
MYSQLDUMP_SCHEMA_ARGS+="--no-data "
MYSQLDUMP_SCHEMA_ARGS+=$MYSQLDUMP_ADDITIONAL_ARGS

# Arguments to dump just the data
MYSQLDUMP_DATA_ARGS=""
MYSQLDUMP_DATA_ARGS+="--no-create-info "
MYSQLDUMP_DATA_ARGS+=$MYSQLDUMP_ADDITIONAL_ARGS
