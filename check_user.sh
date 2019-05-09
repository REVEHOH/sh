#!/bin/bash
if [ $USER == "root" ];then
	echo "你现在身份是root"
else
	echo "你现在不是root，$root"
fi
