#!/bin/bash
#mkdir /data/scripts
#vim /data/scripts/nginx.sh

logs_path="/usr/local/nginx/logs"
mv ${logs_path}access.log ${logs_path}access_$(date -d "yesterday" + "%Y%m%d").log
kill -USER1 `cat /usr/local/nginx/logs/nginx.pid `
#chmod +x /data/scripts/nginx_logs.sh
#crontab -e  #脚本写完后， 将脚本放入计划任务
0 1 * * * /data/scripts/nginx_log.sh
