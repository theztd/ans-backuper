#!/bin/bash
# Zalohovani databazoveho stroje per databaze
#
# nejprve je potreba vytvorit zalohovaciho uzivatele,
# ktery smi selectovat a zamykat,
#
# GRANT SELECT, LOCK TABLES, RELOAD
# ON *.*
# TO  'backupsql'@'localhost'
# IDENTIFIED BY '&ihnjks00-ni9nkl';
#
# Pripadne staci nastavit pristup do db bez hesla pro mysqldump
#
##################################

BACKUPDIR="{{ backuper_db_dir }}"
BACKUP_LOG="/var/log/backuper-db.log"

[ -d ${BACKUPDIR} ] || mkdir -p ${BACKUPDIR}

MYSQLDUMP="mysqldump"

rm -fv $BACKUPDIR/*$(date --date="3 days ago" +%F)* >> ${BACKUP_LOG}


for db in `ls -l /var/lib/mysql/ | egrep "^d" | awk '{print $9}' | egrep -v 'performance_schema' | xargs`; do

  {
	   $MYSQLDUMP --opt --skip-comments --quote-names --routines --triggers --flush-logs --skip-add-locks --flush-privileges $db | gzip > $BACKUPDIR/$db-$(date +%F-%H%M).sql.gz
  } && state="OK" || state="ERROR"

	echo "$(date +%F) BACKUP ${db}   ${state}" | tee -a ${BACKUP_LOG}
done

chown root:root -R ${BACKUPDIR}
chmod 600 ${BACKUPDIR}/*
