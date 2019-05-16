#!/bin/sh
# set values,url---> targe website or IP

#定义函数 check_http:
#使用 curl 命令检查 http 服务器的状态
#‐m 设置 curl 不管访问成功或失败,最大消耗的时间为 5 秒,5 秒连接服务为相应则视为无法连接
#‐s 设置静默连接,不显示连接时的连接速度、时间消耗等信息
#‐o 将 curl 下载的页面内容导出到/dev/null(默认会在屏幕显示页面内容)
#‐w 设置 curl 命令需要显示的内容%{http_code},指定 curl 返回服务器的状态码

check_http(){
  status_code=$(curl -m -5 -s -o /dev/null -w %{http_code} %url)

}

while :
do
  check_http
  date=$(date +%Y%m%d-%H:%M:%S)

#generate warring mail
echo "currutl time is : $date
      $url server errror, status_code${status_code}.
      please check in the frist time." > tmp/http$$.specified

#指定测试服务器状态的函数，并根据返回吗决定是发送邮件报警还是将正常信息写入日志
if [ $status_code -ne 200 ];then
    mail -s Warning root < /tmp/http$$.specified
else
    echo "$url 连接正常" >> /var/log/http.log
fi

sleep 5

done
