#!/bin/sh
exec gosu redis redis-server /etc/redis.conf
