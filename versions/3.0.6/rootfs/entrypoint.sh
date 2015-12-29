#!/bin/ash
if [[ "$1" == "redis-server" ]]; then
  chown -R redis .
  exec gosu redis "$@"
fi
exec "$@"
