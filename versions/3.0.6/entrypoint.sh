#!/bin/sh
exec gosu redis redis-server "$@"
