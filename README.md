# docker-hosting
Docker files for create simple hosting platform.

It's a simple image, based on docker.io/centos image.

Tested on ubuntu1~16.04.4 and centOS 7.3.1611:
* Docker version 1.12.6, build 78d1802
* Docker version 17.03.1-ce, build c6d412e

## How it works
It's simple image for easy deploying a container with a custom php and php.ini to use an any web-app.

You should create and mapping directory into container with this structure:
* **public_html** - for your content (php,html and other)
* **logs** - for access and error logs
* **php-fcgi** (optional) - for use a own php binaries and a php.ini

For resolve issue with users rights, to corret writing into mapping folder, I get owner UID and GID from **public_html** and create user **sites** with same UID and GID into container.

For use your own *php.ini* file, you must put in **php-fcgi/** directory.  
For use your own *php binary*, you must compile it as cgi-fcgi, and put in **php-fcgi/** directory as **php**

## Software into container

* **Apache/2.4.6** - a stock httpd from base centos repo
*  **PHP 5.3.29** - a custom PHP 5.3, build as fast-cgi
```
/usr/local/bin/php53 -m
[PHP Modules]
bcmath
cgi-fcgi
Core
ctype
curl
date
dom
ereg
fileinfo
filter
ftp
gd
gettext
hash
iconv
json
libxml
mbstring
mcrypt
mysql
mysqli
openssl
pcre
Phar
posix
Reflection
session
SimpleXML
soap
sockets
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlrpc
xmlwriter
xsl
zlib

[Zend Modules]
```
## Usage example
Clone repo:
```bash
[root@centos7 ~]#git clone https://github.com/serge-r/docker-hosting
```
Build an image:
```bash
[root@centos7 ~]#cd docker-hosting/
[root@centos7 docker-hosting]#docker build ./ -t docker-hosting
```
Make sure, that building was successfully there is no any errors, and you have a new image, named docker-hosting.
```
[root@centos7 docker-hosting]# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
docker-hosting      latest              39ad7b0e598a        5 minutes ago      388 MB
centos              latest              98d35105a391        3 weeks ago         192 MB
```
Them, create directories for content and logs:
```
[root@centos7 docker-hosting]#mkdir -p /home/serge/web{php-fpm,public_html,logs}
[root@centos7 docker-hosting]#chown -R serge:serge /home/serge/web
```
Put some content into **public_html**. I create a simple *phpinfo()* sample:
```
[root@centos7 docker-hosting]#echo '<?php phpinfo(); ?>' > /home/serge/web/public_html/phpinfo.php
``` 
Make sure, that created directories now owned by root. To start container, owner UID and GID must be different from 0. It necessary to create user into container.

In this example, I make files owned by user **serge**:
```
[root@centos7 docker-hosting]#chown -R serge:serge /home/serge/web
```
Next, run!
```
[root@centos7 docker-hosting]#docker run -d -p 8080:80 -v /home/serge/web:/home/sites --name="MyTestSite" docker-hosting
23be14bdc6b5443d7078939257f1ea05eeec257027a33f11a590796a9f4c950d
[root@centos7 docker-hosting]#docker ps
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS                           NAMES
23be14bdc6b5        docker-hosting      "/opt/entrypoint.sh"   2 seconds ago       Up 2 seconds        443/tcp, 0.0.0.0:8080->80/tcp   MyTestSite
```
Test:
```
[root@centos7 docker-hosting]#curl -I localhost:8080/phpinfo.php
HTTP/1.1 200 OK
Date: Thu, 06 Apr 2017 05:48:52 GMT
Server: Apache/2.4.6 (CentOS) mod_fcgid/2.3.9
X-Powered-By: PHP/5.3.29
Content-Type: text/html; charset=UTF-8
```

