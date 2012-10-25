#!/bin/bash

echo "===redius start===="
redis-server /usr/local/etc/redis.conf > log/redis.log
bundle exec sidekiq > log/sidekiq.log


