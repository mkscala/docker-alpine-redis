### Alpine Linux Redis

A [Redis][redis] [Docker image][alpine_redis] built on top of [Glider Labs's Alpine Linux 3.3][gliderlabs_alpine] Docker image.


#### Tags

* [`3.0.6`][dockerfile_3_0_6], [`3.0`][dockerfile_3_0_6], [`3`][dockerfile_3_0_6], [`latest`][dockerfile_3_0_6] ([Dockerfile][dockerfile_3_0_6], [Release notes][redis_changes], 2015 Dec 18)
* [`3.0.5`][dockerfile_3_0_5] ([Dockerfile][dockerfile_3_0_5], 2015 Oct 15)


#### Latest Version

```ash
$ docker run --rm sickp/alpine-redis -v
Redis server v=3.0.6 sha=00000000:0 malloc=jemalloc-3.6.0 bits=64 build=d73722c1867d4aff
```

#### History

- 2015 Dec 25 - Updated to Alpine Linux 3.3 (gcc 5.3.0), enable option passthrough to `redis-server`.
- 2015 Dec 18 - Updated to Redis 3.0.6.
- 2015 Dec 11 - Initial version.

[alpine_redis]:      https://hub.docker.com/r/sickp/alpine-redis/
[gliderlabs_alpine]: https://hub.docker.com/r/gliderlabs/alpine/
[dockerfile_3_0_5]:  https://github.com/sickp/docker-alpine-redis/tree/master/versions/3.0.5/Dockerfile
[dockerfile_3_0_6]:  https://github.com/sickp/docker-alpine-redis/tree/master/versions/3.0.6/Dockerfile
[redis]:             http://redis.io/
[redis_changes]:     https://raw.githubusercontent.com/antirez/redis/3.0/00-RELEASENOTES
