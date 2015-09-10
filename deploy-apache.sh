#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

echo 'Where would you like to deploy it to?';
read location;

echo "What's the URL of the site?";
read url;

echo "
<Directory $location>
	Options Indexes FollowSymLinks
	Options -Indexes
	AllowOverride None
	Require all granted
</Directory>" >> /etc/apache2/apache2.conf

SITESAVAILABLE="";

if [ -f /etc/apache/sites-available/default ]; then
	SITESAVAILABLE=/etc/apache/sites-available/default;
elif [ -f 	SITESAVAILABLE=/etc/apache/sites-available/000-default.conf ]; then
	SITESAVAILABLE=/etc/apache/sites-available/default;
else
	SITESAVAILABLE="/etc/apache/sites-available/$url.conf"
fi

echo "
<VirtualHost $url:80>
	DocumentRoot $location
</VirtualHost>

<VirtualHost www.$url:80>
	DocumentRoot $location
</VirtualHost>" >> $SITESAVAILABLE;

