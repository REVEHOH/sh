#!/bin/sh
#设置变量定义添加到防火墙规则的服务和端口号
#使用firewall-cmd --get-serivces 可以查看firewall支持哪些服务
servive="nfs http ssh"
port="80 22 8080"

#循环将每个服务添加到防火墙规则中
for i in  $service
do
  echo "adding $i  service to firewall"
  firewall-cmd --add-service=${i}
done

#循环每个端口添加到防火墙规则中
for i in $port
do
  echo "Adding $i Port to firewall"
  firewall-cmd --add-port=${i}/tcp
done
#将以上设置的临时防火墙规则，转换为永久规则(确保重启后有效)
firewall-cmd --runtime-to-permannet
