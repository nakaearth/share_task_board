#!/bin/bash
PATH=/usr/local/sbin:$PATH
echo "-----Shutdown ALL SERVERS ------"
echo "-----Nginx STOP ------"
sudo nginx -s stop

echo "----unicorn STOP!-----"
PID=$(ps ax | grep -v grep | grep "unicorn_rails" |grep "master" | awk '{print $1};')
echo $PID
kill -9 ${PID}

echo "---Shutdown SERVERS END------"
