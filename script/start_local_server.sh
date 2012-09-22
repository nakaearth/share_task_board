#!/bin/bash

echo "-----SERVER RESTART------"
sudo nginx -s stop
echo "----nginx start!-----"
sudo nginx

PID=$(ps ax | grep -v grep | grep "unicorn_rails" |grep "master" | awk '{print $1};')
echo $PID
kill -9 ${PID}

echo "----unicorn start!-----"
unicorn_rails -c config/unicorn.rb -E development -D
echo "---START SERVERS END------"
