# Rezepte 


## Zeitzone setzen

```
TZ="Europe/Berlin"
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
```

## Install Apache2

```
apt-get --no-install-recommends -y install \
    apache2 ca-certificates


rm -R /var/www/html
ln -s /opt/www /var/www/html
```

## PHP7.0

```
# Install PHP7
apt-get --no-install-recommends -y install \
    php7.0 libapache2-mod-php7.0 php7.0-dev php7.0-gd php7.0-curl curl php-ssh2 php-pear php-pecl-http \
    php-imagick php7.0-mysql mysql-client-5.7 php7.0-xml php7.0-json php7.0-mbstring composer php7.0-zip


sed -i 's/memory_limit = 128M/memory_limit = 2048M/g' /etc/php/7.0/apache2/php.ini
sed -i 's/;pcre.backtrack_limit=100000/pcre.backtrack_limit=100000000/g' /etc/php/7.0/apache2/php.ini

```


## Versionsinformationen schreiben

```
VERSION_FILE=app/_version.php
CURDATE=`date`
sed -i "s|{CI_BUILD_ID}|$CI_BUILD_ID|g" $VERSION_FILE
sed -i "s|{CI_BUILD_REF_SLUG}|$CI_BUILD_REF_SLUG|g" $VERSION_FILE
sed -i "s|{GITLAB_USER_EMAIL}|$GITLAB_USER_EMAIL|g" $VERSION_FILE
sed -i "s|{DATE}|$CURDATE|g" $VERSION_FILE
```

Versionsfile `app/_version.php` sieht so aus:

```
<?php
define ("BUILD_CI_BUILD_ID", "{CI_BUILD_ID}");
define ("BUILD_CI_BUILD_REF_SLUG", "{CI_BUILD_REF_SLUG}");
define ("BUILD_GITLAB_USER_EMAIL", "{GITLAB_USER_EMAIL}");
define ("BUILD_DATE", "{DATE}");
```


## Postfix (Mailserver) zum versenden von mails (Achtung: evtl gehen Mails verloren)

```
if [ "$MAIL_NAME" == "" ]
then
    echo "[ERROR] MAIL_NAME not set in .env file"
    exit 1
fi

echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt
echo "postfix postfix/mailname string $MAIL_NAME" >> preseed.txt
## Use Mailbox format.
debconf-set-selections preseed.txt
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -q -y \
    postfix

postconf myorigin=$MAIL_NAME
```
