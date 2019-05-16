#!/bin/sh
read -p "请输入分钟信息(00-59) :" min
read -p "请输入小时信息(00-59) :" hour
read -p "请输入日期信息(00-59) :" date
read -p "请输入月份信息(00-59) :" month
read -p "请输入星期信息(00-59) :" weak
read -p "请输入计划任务需要执行的命令或者脚本:" program

echo "$min $hour $date $month $weak $program" >> /etc/crontab