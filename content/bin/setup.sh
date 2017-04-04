#!/bin/bash

# Script create a base enviroment - sample of content
# Apache's config and php-wrapper

echo "Set up a user sites"
useradd sites -m -s /sbin/nologin

echo "Create directory structures for user sites"
mkdir /home/sites/{logs,public_html,php-fcgi,mysql}

echo "Create a test content ofni.php and index.html for user sites"
echo '<?php phpinfo(); ?>' > /home/sites/public_html/ofni.php
echo '<h1>Hello!</h1>' > /home/sites/public_html/index.html

echo "Change rights for content and folders for user sites"
chown -R sites:sites /home/sites
chmod o+x /home/sites

echo "Make directory for php wrapper (/var/www/cgi-bin/sites)"
mkdir -p /var/www/cgi-bin/sites

echo "Copy a wrapper"
mv /opt/content/bin/wrapper.sh /var/www/cgi-bin/sites/php-fcgi
chmod +x /var/www/cgi-bin/sites/php-fcgi

echo "Change rights for wrapper directory"
chown -R sites:sites /var/www/cgi-bin/sites

echo "Copy a php binary"
mv /opt/content/bin/php53 /usr/local/bin/
chmod +x /usr/local/bin/php53

echo "Copy a Apache config"
mv /opt/content/sites.conf /etc/httpd/conf.d/sites.conf

echo "Make a config test"
apachectl configtest

echo "Clean /opt/"
rm -rf /opt/content
