nginx -Vbuilt by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) built by gcc 4.8.5 20150623 (Red Habuilt by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_modulebuilt by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_modulebuilt by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_modulebuilt by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_modulebuilt by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_modulebuilt by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_modulebuilt by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_modulet 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module
#!/bin/bash
#函数声明：

ln -s /usr/local/nginx/sbin/nginx /usr/sbin/
nginx
nginx -V
#查找文件
find /* -name "nginx*.tar.gz" -type f -exec tar -xzvf {} -C /opt/ \;
sleep 2

[ $? -eq 0 ]&& echo "查找成功，解压缩到/opt/目录下" || echo "解压失败"
cd /opt/nginx-1.12*built by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module
#利用与安装依赖包
#1.检查yum仓库是否正常
#错误时，下载阿里云的仓库文件，更新yum源
	 Yum_num=`yum repolist  | tail -1 | awk '{print $2}'`
        if [ $Yum_num == 0 ];then
                 echo "yum 仓库位空"
		wget http://mirrors.aliyun.com/repo/Centos-7.repo -O /etc/yum.repos.d/
		yum clean all
		yum makecache
ln -s /usr/local/nginx/sbin/nginx /usr/sbin/
nginx
nginx -V
		yum update
        fi
	Yum_num=`yum repolist  | tail -1 | awk '{print $2}'`
	[ $Yum_num == 0 ] && echo "yum源错误"&&exit 
#安装依赖包
	yum -y install gcc pcre-devel openssl-devel &> /dev/nullbuilt by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module
	echo "依赖包安装成功：gcc、pcre-devel、 openssl-devel"
nginx -V
	rpm -q gcc pcre-devel openssl-devel 
	
useradd -s /sbin/nolognin nginx &> /dev/null
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module 
make&&make install
[ $? -eq  0 ] && echo "安装成功.." || echo "安装失败"
echo "正在启动服务..."
sleep 2
/usr/local/nginx/sbin/nginx
lt by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module
/usr/local/nginx/sbin/nginx -V

