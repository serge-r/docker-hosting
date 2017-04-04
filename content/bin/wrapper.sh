#!/bin/bash
if [ -e ~/php-fcgi ];
then
        if [ -e ~/php-fcgi/php.ini ];
        then
                if [ -e ~/php-fcgi/php ];
                then
                        exec ~/php-fcgi/php  -c ~/php-fcgi/php.ini $@
                else
                        exec /usr/local/bin/php53 -c ~/php-fcgi/php.ini $@
                fi
        else
                if [ -e ~/php-fcgi/php ];
                then
                        exec ~/php-fcgi/php  $@
                else
                        exec /usr/local/bin/php53 $@
                fi
        fi
else
        exec /usr/local/bin/php53 $@
fi
