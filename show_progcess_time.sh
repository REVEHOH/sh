#!/bin/bash
#定义一个显示进度函数，屏幕快速显示| / - \

rotate_line() {
	INTERVAL=0.1	#设置间隔时间
	COUNT="0"	#设置4个形状的编号，默认编号0（不代表任何图像）
while : 
do
	COUNT=`expr $COUNT + 1`
	case $COUNT in
	"1")			#值为1显示
		echo -e '-'"\b\c"
		sleep $INTRVAL
		;;
	
	"2")			#值为2显示\\,第一个\转义
		echo -e '\\'"\b\c"
		sleep $INTRVAL
		;;

	"3")		#值为3显示|
		echo -e "|\b\c"
		sleep $INTRVAL
		;;

	"4")			#值4显示/
		echo -e "/\b\c"
		sleep $INTRVAL
		;;

	"*")
		COUNT="0";;
	esac
done	
}
rotate_line
