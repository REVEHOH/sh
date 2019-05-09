#!/bin/bash
#提取跟分区剩余空间
disk_size=$(df / | awk '/\//{print $4}')
#提取根分区剩余空间
mem_size=$(free | awk '/Mem/{print $4}')
while :
do
#注意内存和磁盘提取空间大小都是以kb为单位
if [ $disk_size -le 512000 -a $mem_size -le 102400 ];then
	mail -s Warning root << EOF
Insufficient resources,资源不足
EOF
fi

done&

