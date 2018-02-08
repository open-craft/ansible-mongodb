#!/bin/bash

TMPDIR='{{ MONGODB_SERVER_BACKUP_DIR }}'

rm -rf "$TMPDIR"
sudo -u mongodb mkdir -p "$TMPDIR"
DBNAMES=`echo "show databases;" | \
         sudo -u mongodb mongo --quiet -u '{{ mongodb_root_admin_name }}' -p '{{ mongodb_root_admin_password }}' 127.0.0.1:{{ mongodb_net_port }}/admin | \
         awk '{ print $1; }'`

for DBNAME in $DBNAMES; do
    sudo -u mongodb mongodump -u '{{ mongodb_root_admin_name }}' -p '{{ mongodb_root_admin_password }}' --authenticationDatabase admin --db "$DBNAME" --out "$TMPDIR"
done
