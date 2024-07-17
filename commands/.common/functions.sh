#!/bin/bash
#ddev-generated

function set_remote_server_credentials() {
  # Build the remote mysql credentials
  REMOTE_DB_CREDS=""
  if [[ -n "${target[mysqlUser]}" ]] ; then
    REMOTE_DB_CREDS+="--user=${target[mysqlUser]} "
  fi
  if [[ -n "${target[mysqlPass]}" ]] ; then
    REMOTE_DB_CREDS+="--password=${target[mysqlPass]} "
  fi
  if [[ -n "${target[mysqlHost]}" ]] ; then
    REMOTE_DB_CREDS+="--host=${target[mysqlHost]} "
  fi
  if [[ -n "${target[mysqlPort]}" ]] ; then
    REMOTE_DB_CREDS+="--port=${target[mysqlPort]} "
  fi
  REMOTE_DB_CREDS+="${target[mysqlDatabase]}"
}

function dump_remote_db() {
  set_remote_server_credentials

  echo -e "${CLR_GRN}Exporting ${CLR_WHT}${target[mysqlDatabase]} ${targetName}${CLR_GRN} tables to swap cache ${CLR_END}"

  local listTablesQuery="select table_name from information_schema.tables where table_schema = '${target[mysqlDatabase]}';"
  local ensureSwapDirExists="mkdir -p ${REMOTE_SWAP_CACHE_DIR}; "
  local removeSqlFilesInSwapCache="rm ${REMOTE_SWAP_CACHE_DIR}*.sql; "
  local outputTableList="${CMD_REMOTE_MYSQL} ${REMOTE_DB_CREDS} -BNe \\\"${listTablesQuery}\\\""

  local outputMessage="echo -n \".\" ;"

  if [[ "${isVerbose}" = 1 ]] ; then
    outputMessage="echo -e \" - exporting %\" ;"
  fi

  local sshCommand="ssh ${target[sshUser]}@${target[sshHost]} -q -p ${target[sshPort]} \"${ensureSwapDirExists}${ensureSwapDirExists}${outputTableList} | xargs -I % sh -c '
    if ! [[ \\\" ${EXCLUDED_DB_TABLES[*]} \\\" =~ \",%,\" ]] ; then
      ${outputMessage}
      ${CMD_REMOTE_MYSQLDUMP} ${REMOTE_DB_CREDS} %>${REMOTE_SWAP_CACHE_DIR}%.sql ;
    fi
  '\""

  # if isVerbose = 1 output ssh command
  if [[ "${isVerbose}" = 1 ]] ; then
    echo -e "${CLR_BLK}${sshCommand}${CLR_END}"
  fi
  # set output colour to yellow
  echo -e "${CLR_YEL_D}"

  # execute ssh command
  eval $sshCommand

  echo -e "${CLR_END}"
}

function copy_remote_db_files_to_local() {
  # use rsync to copy remote files locally
  echo -e "${CLR_GRN}Copying ${CLR_WHT}${target[mysqlDatabase]} ${targetName}${CLR_GRN} swap cache to ${CLR_WHT}local${CLR_GRN} swap cache${CLR_YEL_D}"

  mkdir -p $LOCAL_SWAP_CACHE_DIR

  local rsyncCommand="${CMD_LOCAL_RSYNC_EXECUTE} \"${target[sshUser]}@${target[sshHost]}:${REMOTE_SWAP_CACHE_DIR}\" ${LOCAL_SWAP_CACHE_DIR}"

  if [[ "${isVerbose}" = 1 ]] ; then
    echo -e "${CLR_BLK}${rsyncCommand}${CLR_END}"
  fi

  # set output colour to yellow
  echo -e "${CLR_YEL_D}"

  eval $rsyncCommand

  echo -e "${CLR_END}"
}
