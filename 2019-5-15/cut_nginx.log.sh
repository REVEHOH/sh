#mkdir /dta/scripts
#vim /data/scripts/nginx_log.sh
#!/bin/sh
logs_path="/usr/local/nginx/logs/"
mv ${logs_path}access.log ${logs_path}access_$(data -d "yesterday" + "%Y%m%d").log
kill -USER1 `cat /usr/local/nginx/logs/nginx,pid`

# finsh the shell， needs to be done at the terminal
#chmod + x /data/scripts/nignx_logs.sh 
#crontab -e
#0 1  * * * /dta/scripts/nginx_log.sh
