#!/bin/sh
running=0
sleep=0
stoped=0
zombie=0
#在proc目录下所有以数字开始的都是当前计算机正在运行的进程的进程PID
#每个PID编号的目录下记录有进程相关信息
for pid in /proc/[1-9]*
do
  procs=$[procs+1]
  stat=$(awk '{print $3}' $pid/stat)
  #每个pid目录下都有一个stat文件，该文件的第三列是该进程的状态信息
  case $stat in
    R)
      running=$[running+1]
      ;;
    T)
      stoped=$[stoped+1]
      ;;
    S)
      sleep=$[sleep+1]
      ;;
    Z)
    zombie=$[zombie+1]
      ;;
esac
done
echo "进程信息如下"
echo "总进程数量为：$pros"
echo "Running进程数为：$running"
echo "Stoped进程数为：$stoped"
echo "Sleep进程数为: $sleeping"
echo "Zombie进程数为: $zombie"
