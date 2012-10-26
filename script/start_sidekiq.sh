#!/bin/bash

echo "===redius start===="
(redis-server /usr/local/etc/redis.conf > /dev/null) >& log/redis.log
#bundle exec sidekiq > log/sidekiq.log


