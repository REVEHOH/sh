#!/bin/bash
#解包
yum -y install gcc pcre-devel openssl-devel &> /dev/null
useradd nginx
tar -zvxf /root/lnmp_soft.tar.gz
cd /root/lnmp_soft
tar -zvxf nginx-1.10.3.tar.gz
cd nginx-1.10.3
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module
make && make install
/usr/local/nginx/sbin/nginx 
/usr/local/nginx/sbin/nginx -V
cd ~
