#!/bin/bash
#本脚本编写完成后,放置在/etc/init.d/目录下,就可以被 Linux 系统自动识别到该脚本 
#如果本脚本名为/etc/init.d/nginx,则 service nginx start 就可以启动该服务 
#service nginx stop 就可以关闭服务 
#service nginx restart 可以重启服务 
#service nginx status 可以查看服务状态

program=/usr/local/nginx/sbin/nginx
pid=/usr/local/nginx/logs/ngixn.pid
start(){
	if [ -f $pid ];then
	echo "ngixn 服务已经处于开启状态"
	else
		$program
	fi
}
stop(){
	if [ -! -f $pid ];then 
		echo "nginx服务已经关闭"
	else
		$program -s stop
		echo "关闭服务ok"
	fi
}
status(){
	if [  -f $pid ];then
		echo "服务正在运行"
	else
		$program -s stop
		echo "服务关闭"
	fi
}

case $1 in

start)
	start;;
stop)
	stop;;
status)
	status;;
*)
	echo "你输入的语法格式错误"
esac

