#ddev-generated
This directory holds "targets/sources" aka host configurations.

Create files of any names (except README.txt) in this directory to provide access to remote systems via this form configuration:

```sh
target=(
  # The SSH user used to connect to the remote webapp server.
  [sshUser]=
  # The SSH host of the remote webapp. Enclose IPv6 addresses in [].
  [sshHost]=
  # The SSH port
  [sshPort]=22
  # The hostname that the webapp uses to reach the MySQL/MariaDB database (the connection will be tunneled through SSH to sshUser@sshHost)
  [mysqlHost]=mysql.myserver.com
  [mysqlPort]=3306
  [mysqlUser]=
  [mysqlPass]=
  [mysqlDatabase]=
  # Provide a RegEx against which each database table is checked. If it matches, its data won't be downloaded (structure is unaffected by this).
  # This is an example to ignore some common TYPO3 tables with cached or easily rebuildable data.
  [ignoredDbTablesPattern]="^(sys_log|.*_sessions|cf_.*|.*cache.*|sys_file_processedfile|sys_refindex|sys_lockedrecords|tx_realurl_urldata|index_debug|index_fulltext|index_grlist|index_phash|index_rel|index_section|index_stat_search|index_stat_word|index_words|tx_crawler_queue|tx_extensionmanager_domain_model_extension)$"
)
```

PS:
The files are interpreted by Bash so you can use bash logic to fill in values
