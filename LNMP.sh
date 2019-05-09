#!/bin/bash
#使用yum安装LNMP，需要提前配置号yum源，否则脚本会失败



yum -y install httpd mariadb-devel mariadb-server mariadb
yum -y install php php-mysql

systemctl start httpd mariadb
systemctl enable httpd mariadb
