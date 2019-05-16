#!/bin/sh
user=$(awk -F: '/bash$/{print $i}'  /etc/passwd )
for i in $ssh_user
do
  awk -F : -v x=$i '$1==x{print $1,$2}' /etc/shoadow

done
