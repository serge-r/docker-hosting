#!/bin/bash

# Velosiped for checking user permissions
# and mapping user

$NEW_UID=$(stat -c %u /home/sites/public_html)
$NEW_GID=$(stat -c %g /home/sites/public_html)

echo "I found, that public_html has UID=$NEW_UID and GID=$NEW_GID"
echo "Creating user with same UID and GID"

/usr/sbin/groupadd sites -g $NEW_GID
/usr/sbin/useradd sites -d /home/sites/ -s /sbin/nologin -u $NEW_UID -g $NEW_GID -M -N

chown -R sites:sites /home/sites
chown -R sites:sites /var/www/cgi-bin/sites
chmod o+x /home/sites/

exec /usr/sbin/httpd -D FOREGROUND
