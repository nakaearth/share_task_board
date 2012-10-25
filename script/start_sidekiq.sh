#!/bin/bash

echo "===redius start===="
redis-server /usr/local/etc/redis.conf > log/redis.log
bundle exec sidekiq -q high,5 default > log/sidekiq.log


