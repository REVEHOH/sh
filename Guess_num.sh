#!/bin/bash

num=$[ RANDOM%100 + 1 ]
while :
do
read -p "请输入你一个数字[ 1~ 100]:" user_num
if [ $user_num -eq $num ];then
	echo "你猜对了"
	exit;
elif [ $user_num -gt $num ];then
	echo "你猜大了"
else 
	echo "你猜小了"
fi

done
