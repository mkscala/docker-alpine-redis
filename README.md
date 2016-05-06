### Alpine Linux Redis

A lightweight [Redis][redis] [Docker image][dockerhub_project] built from source atop [Alpine Linux][alpine_linux]. Available on [GitHub][github_project].

Tags with the `-k8s` suffix are built on [Alpine-Kubernetes][alpine_kubernetes], an image for Kubernetes and other Docker cluster environments that use DNS-based service discovery. It adds the necessary `search` domain support for DNS resolution.


#### Stable 3.2.x Version Tags

* `3.2.0`, `3.2`, `3`, `stable`, `latest` (2016-05-06, [Dockerfile][dockerfile_3_2], [Release notes][release_notes_3_2])
* `3.2.0-k8s`, `3.2-k8s`, `3-k8s`, `stable-k8s`, `latest-k8s` ([Dockerfile][dockerfile_3_2_k8s] for Kubernetes)

#### Old 3.0.x Version Tags

* `3.0.7`, `3.0`, `old` (2016-01-28, [Dockerfile][dockerfile_3_0], [Release notes][release_notes_3_0])
* `3.0.7-k8s`, `3.0-k8s`, `old-k8s` ([Dockerfile][dockerfile_3_0_k8s] for Kubernetes)
* `3.0.6`, `3.0.6-k8s` (2015-12-18)
* `3.0.5` (2015-10-15)


#### Basic Usage

After the image name, just specify the executable to run followed by any options. By default, `redis-server /etc/redis.conf` will be executed.

```bash
$ docker run --rm sickp/alpine-redis:3.2.0 # redis-server /etc/redis.conf
              _._                                                  
         _.-``__ ''-._                                             
    _.-``    `.  `_.  ''-._           Redis 3.2.0 (00000000/0) 64 bit
 .-`` .-```.  ```\/    _.,_ ''-._                                   
(    '      ,       .-`  | `,    )     Running in standalone mode
|`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
|    `-._   `._    /     _.-'    |     PID: 1
`-._    `-._  `-./  _.-'    _.-'                                   
|`-._`-._    `-.__.-'    _.-'_.-'|                                  
|    `-._`-._        _.-'_.-'    |           http://redis.io        
`-._    `-._`-.__.-'_.-'    _.-'                                   
|`-._`-._    `-.__.-'    _.-'_.-'|                                  
|    `-._`-._        _.-'_.-'    |                                  
`-._    `-._`-.__.-'_.-'    _.-'                                   
    `-._    `-.__.-'    _.-'                                       
        `-._        _.-'                                           
            `-.__.-'                                               

1:M 06 May 16:32:29.429 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
1:M 06 May 16:32:29.429 # Server started, Redis version 3.2.0
1:M 06 May 16:32:29.429 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
1:M 06 May 16:32:29.429 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
1:M 06 May 16:32:29.429 * The server is now ready to accept connections on port 6379
```

Explore the image in a container shell:

```bash
$ docker run --rm -it sickp/alpine-redis:3.2.0 ash
/data #
```

Check the server version:

```bash
$ docker run --rm sickp/alpine-redis:3.2.0 redis-server -v
Redis server v=3.2.0 sha=00000000:0 malloc=jemalloc-4.0.3 bits=64 build=6b3ba93c4a89a3b9

$ docker run --rm sickp/alpine-redis:3.2.0 cat /etc/alpine-release
3.3.3
```


#### Example: Redis Server + CLI

This example starts a default Redis server in its own network. It requires Docker 1.9+ as it uses Docker's modern networking support. We then connect to it using the Redis command line interface.

##### Setup

Create a new network called `mynetwork` that will allow our containers to communicate in isolation.

```bash
$ docker network create mynetwork
bbeffd0ee68a977fb868eee76bc764a6f746ad11b8ec567c83a63ae71fc850d4

$ docker network ls
NETWORK ID          NAME                DRIVER
bd7fc5445682        host                host                
bbeffd0ee68a        mynetwork           bridge              
0527c4e41e56        bridge              bridge              
bad47935bd28        none                null  
```

##### Run Server

Next we create a simple Redis server instance, and give it the name `myserver`. Data is stored on the volume `/data`, which is automatically created for you on your development/container host. Because we're running in the foreground and will be removed with `--rm`, this volume will not dangle.

```bash
$ docker run --rm --net=mynetwork --name=myserver sickp/alpine-redis
              _._                                                  
         _.-``__ ''-._                                             
    _.-``    `.  `_.  ''-._           Redis 3.0.6 (00000000/0) 64 bit
.-`` .-```.  ```\/    _.,_ ''-._                                   
(    '      ,       .-`  | `,    )     Running in standalone mode
|`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
|    `-._   `._    /     _.-'    |     PID: 1
`-._    `-._  `-./  _.-'    _.-'                                   
|`-._`-._    `-.__.-'    _.-'_.-'|                                  
|    `-._`-._        _.-'_.-'    |           http://redis.io        
`-._    `-._`-.__.-'_.-'    _.-'                                   
|`-._`-._    `-.__.-'    _.-'_.-'|                                  
|    `-._`-._        _.-'_.-'    |                                  
`-._    `-._`-.__.-'_.-'    _.-'                                   
    `-._    `-.__.-'    _.-'                                       
        `-._        _.-'                                           
            `-.__.-'                                               

1:M 29 Dec 22:18:04.019 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
1:M 29 Dec 22:18:04.019 # Server started, Redis version 3.0.6
1:M 29 Dec 22:18:04.019 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
1:M 29 Dec 22:18:04.019 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
1:M 29 Dec 22:18:04.019 * The server is now ready to accept connections on port 6379
```

##### Connect

In another terminal, we now connect to our server using the Redis CLI. This ephemeral container is connected to the `mynetwork` network and runs the command `redis-cli -h myserver`. Here we specify the hostname `myserver` which Docker has automagically inserted into this container's `/etc/hosts` file.

```bash
$ docker run --rm --net=mynetwork -it sickp/alpine-redis redis-cli -h myserver
myserver:6379> info
# Server
redis_version:3.0.6
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:9e758fcb6d3a7057
redis_mode:standalone
os:Linux 4.1.13-boot2docker x86_64
arch_bits:64
multiplexing_api:epoll
gcc_version:5.3.0
process_id:1
run_id:3ebd6e81255d77d3dd5fb378905ca6826a512577
tcp_port:6379
uptime_in_seconds:185
uptime_in_days:0
hz:10
lru_clock:8585971
config_file:/etc/redis.conf

# Clients
connected_clients:1
client_longest_output_list:0
client_biggest_input_buf:0
blocked_clients:0

# Memory
used_memory:815944
used_memory_human:796.82K
used_memory_rss:7483392
used_memory_peak:815944
used_memory_peak_human:796.82K
used_memory_lua:36864
mem_fragmentation_ratio:9.17
mem_allocator:jemalloc-3.6.0

# Persistence
loading:0
rdb_changes_since_last_save:0
rdb_bgsave_in_progress:0
rdb_last_save_time:1451426362
rdb_last_bgsave_status:ok
rdb_last_bgsave_time_sec:-1
rdb_current_bgsave_time_sec:-1
aof_enabled:0
aof_rewrite_in_progress:0
aof_rewrite_scheduled:0
aof_last_rewrite_time_sec:-1
aof_current_rewrite_time_sec:-1
aof_last_bgrewrite_status:ok
aof_last_write_status:ok

# Stats
total_connections_received:2
total_commands_processed:0
instantaneous_ops_per_sec:0
total_net_input_bytes:14
total_net_output_bytes:0
instantaneous_input_kbps:0.00
instantaneous_output_kbps:0.00
rejected_connections:0
sync_full:0
sync_partial_ok:0
sync_partial_err:0
expired_keys:0
evicted_keys:0
keyspace_hits:0
keyspace_misses:0
pubsub_channels:0
pubsub_patterns:0
latest_fork_usec:0
migrate_cached_sockets:0

# Replication
role:master
connected_slaves:0
master_repl_offset:0
repl_backlog_active:0
repl_backlog_size:1048576
repl_backlog_first_byte_offset:0
repl_backlog_histlen:0

# CPU
used_cpu_sys:0.15
used_cpu_user:0.08
used_cpu_sys_children:0.15
used_cpu_user_children:0.08

# Cluster
cluster_enabled:0

# Keyspace
myserver:6379>
```


#### Example: Redis Master / Slave + Data Containers

##### Setup

Create a new network called `mynetwork` that will allow our containers to communicate in isolation.

```bash
$ docker network create mynetwork
bbeffd0ee68a977fb868eee76bc764a6f746ad11b8ec567c83a63ae71fc850d4
```

Create data-only containers for the master and slave instances. This allows you to easily upgrade the server containers, while maintaining the persistent data stores.

```bash
$ docker create --name=redis-master-data sickp/alpine-redis
1996974d4891995d476e8f015972d10388cb301fe585217760e31edc8005aa5a

$ docker create --name=redis-slave-data sickp/alpine-redis
dd8f12ab673805468fc0dbd7dadedb37aa87c20732725a1530ff150963c41a6c
```

##### Run Master and Slave Servers

Start the master instance.

```bash
$ docker run --rm --name=redis-master --net=mynetwork --volumes-from=redis-master-data sickp/alpine-redis
```

Start the slave instance, setting `slaveof redis-master 6379`.

```bash
$ docker run --rm --name=redis-slave  --net=mynetwork --volumes-from=redis-slave-data  sickp/alpine-redis redis-server /etc/redis.conf --slaveof redis-master 6379
```

##### Connect

Connect to the master instance.

```bash
$ docker run --rm --net=mynetwork -it sickp/alpine-redis redis-cli -h redis-master
```

Connect to the slave instance.

```bash
$ docker run --rm --net=mynetwork -it sickp/alpine-redis redis-cli -h redis-slave
```


#### History

- 2016-05-06 - Added new stable Redis 3.2.0. Added more `-k8s` tags.
- 2016-02-09 - Added support for ALPINE_NO_RESOLVER in Kubernetes version.
- 2016-01-30 - Updated to Redis 3.0.7.
- 2016-01-27 - Added Kubernetes versions (-k8s), until Alpine Linux/musl adds DNS search support.
- 2015-12-29 - Official Docker Redis compatibility, and improved documentation.
- 2015-12-25 - Updated to Alpine Linux 3.3 (gcc 5.3.0), enable option passthrough to `redis-server`.
- 2015-12-18 - Updated to Redis 3.0.6.
- 2015-12-11 - Initial version.

[alpine_kubernetes]:  https://hub.docker.com/r/janeczku/alpine-kubernetes/
[alpine_linux]:       https://hub.docker.com/_/alpine/
[dockerhub_project]:  https://hub.docker.com/r/sickp/alpine-redis/
[dockerfile_3_0]:     https://github.com/sickp/docker-alpine-redis/tree/master/versions/3.0.7/Dockerfile
[dockerfile_3_0_k8s]: https://github.com/sickp/docker-alpine-redis/tree/master/versions/3.0.7-k8s/Dockerfile
[dockerfile_3_2]:     https://github.com/sickp/docker-alpine-redis/tree/master/versions/3.2.0/Dockerfile
[dockerfile_3_2_k8s]: https://github.com/sickp/docker-alpine-redis/tree/master/versions/3.2.0-k8s/Dockerfile
[github_project]:     https://github.com/sickp/docker-alpine-redis/
[redis]:              http://redis.io/
[release_notes_3_0]:  https://raw.githubusercontent.com/antirez/redis/3.0/00-RELEASENOTES
[release_notes_3_2]:  https://raw.githubusercontent.com/antirez/redis/3.2/00-RELEASENOTES
