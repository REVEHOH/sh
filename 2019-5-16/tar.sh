#!/bin/sh
[ ! -d /data ] && mkdir /candidate_master
[ -z $1 ] && exit
if [[ -d $1 ]]; then
  tar -czf /data/$1.-`date +%Y%m%d`.tar.gz $1
else
    echo "该目录不存在"
fi
