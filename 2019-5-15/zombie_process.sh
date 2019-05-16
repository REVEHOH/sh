#!/bin/sh
#/var/www/html 为测试目录， 脚本会清空该目录下所有0个字节的文件
dir="/var/www/html"
find $dir -type f -size 0 -exec rm -rf {} \;
