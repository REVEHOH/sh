#!/bin/sh
#2 second check mysql connection number, set enable or set a time
#the shell user and passwd  Modify according to the actual situation
log_file=/var/log/mysql_count.logs
user=root
passwd=123456
while :
do
    sleep 2
    count=`mysqladmin -u "$user" -p "$passwd" status | awk '{print $4}'`
    echo "`date + %Y-%m-%d` concurrent num is: $count" >> $log_file
done
