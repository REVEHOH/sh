#!/bin/sh
#假设本机为 192.168.4.100,编写脚本关闭除自己外的其他所有主机
#脚本执行,需要提前给所有其他主机传递 ssh 密钥,满足无密码连接
for i in {1..254}
do
  [ $i -eq 100 ]&&continue
  echo "poweoff 192.168.4.$1……"
  ssh 192.168.4.$i poweroff
done
