nginx -s stop
rm -rf /opt/nginx-1.1*
yum -y remove gcc gcc pcre-devel openssl-devel
rm -rf /usr/local/nginx
userdel nginx
