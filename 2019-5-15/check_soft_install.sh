#!/bin/sh
#check sofware is install
if [ $# -eq 0 ];then
  echo "need to a sofware-name to be a parameter"
  echo "use : $0 software-name……"
fi

#$@提取所有的位置变量的值，相当与$
for package in "$@"
do
    if rpm -q ${package} &> /dev/null ;then
        echo -e "${package}\033[32m  already installed\033[0m]"
    else
        echo -e  "${package}\033[34m;1m is not installed\033[0m"
    fi
done
