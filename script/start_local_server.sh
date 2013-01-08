#!/bin/bash
PATH=/usr/local/sbin:$PATH
echo "-----SERVER RESTART------"
echo "----nginx start!-----"
sudo nginx -c /usr/local/etc/nginx/nginx.conf

echo "----unicorn start!-----"
unicorn_rails -c config/unicorn.rb -E development -D
echo "---START SERVERS END------"
