#!/bin/bash


sed -i \
    -e 's/ErrorLog.*/ErrorLog \/dev\/stderr/' \
    -e 's/CustomLog.*/CustomLog \/dev\/stdout combined/' \
    /etc/apache2/sites-available/000-default.conf


sed -i \
    -e 's/log_errors = On/log_errors = Off/' \
    -e 's/display_errors = Off/display_errors = On/' \
    -e 's/display_startup_errors = Off/display_startup_errors = On/' \
    /etc/php5/apache2/php.ini

# enable mcrypt
ln -fs ../../mods-available/mcrypt.ini /etc/php5/apache2/conf.d/20-mcrypt.ini
ln -fs ../../mods-available/mcrypt.ini /etc/php5/cli/conf.d/20-mcrypt.ini

source /etc/apache2/envvars

set -m

trap 'kill $(jobs -p) && wait' EXIT

/usr/sbin/apache2 -DFOREGROUND &

wait
