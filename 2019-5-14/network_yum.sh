#!/bin/bash
rm -rf /etc/yum.repos.d/*.repo
cd /etc/yum.repos.d/
wget http://192.168.4.254/rhel.repo
 
