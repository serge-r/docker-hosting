#!/bin/bash

# Script create a base enviroment - sample of content
# Apache's config and php-wrapper

echo "Create directory structures for user sites"
/usr/bin/mkdir -p /home/sites/{logs,public_html,php-fcgi,mysql}

echo "Create a test content ofni.php and index.html for user sites"
echo '<?php phpinfo(); ?>' > /home/sites/public_html/ofni.php
echo '<h1>Hello!</h1>' > /home/sites/public_html/index.html

echo "Make directory for php wrapper (/var/www/cgi-bin/sites)"
/usr/bin/mkdir -p /var/www/cgi-bin/sites

echo "Copy a wrapper"
/usr/bin/mv /opt/content/bin/wrapper.sh /var/www/cgi-bin/sites/php-fcgi
/usr/bin/chmod +x /var/www/cgi-bin/sites/php-fcgi

echo "Copy a php binary"
/usr/bin/mv /opt/content/bin/php53 /usr/local/bin/
/usr/bin/chmod +x /usr/local/bin/php53

echo "Copy a Apache config"
/usr/bin/mv /opt/content/sites.conf /etc/httpd/conf.d/sites.conf

echo "Copy an entrypoint"
/usr/bin/mv /opt/content/bin/entrypoint.sh /opt
/usr/bin/chmod +x /opt/entrypoint.sh
