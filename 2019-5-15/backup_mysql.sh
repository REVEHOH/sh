#!/bin/sh
#define values user，passed，date(backup time label)
#dbname (The name of the database that needs to be backed up, and the
#value of this variable needs to be modified as needed, defaults  database : mysql)

user=root
passwd=123456
dbname=mysqld
date=$(date +%Y%m%d)

#check the backup dir is exist? otherwise create
[ ! -d /mysqldbackup ] && mkdir /mysqldbackup

#use mysqldump command backup database;
mysqldump -u"$user" -p"$passwd" "$dbname" > /mysqldbackup/"$dbname"-${date}.sql
