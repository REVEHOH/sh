#!/bin/bash
#使用递归显示所有，在判断是否为文件，如果是文件则计数器+1
cd /var/log
sum=0
for i in `ls -r * `
do 
	if [ -f $i ];then
		let sum++
		echo "文件名： $i"
	fi
done 
echo "文件总量为：$sum"
