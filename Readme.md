
Pretty simple dockerized sensu images. Defaults to redis for transport and storage (hostname `redis`), has system-profiler extension installed to get metrics (shipping is up to you).

`base` is the main image. has sensu installed, default configs, run.sh script, etc.

`api` is `base`, but defaulted to run the api service. Can spin up many.
`server` is `base`, but defaulted to run the server service. Can spin up many.
`client` is `base`, but defaulted to run the client service. Also can do a little more runtime config.


Runtime config:



`EXTRA_PLUGINS` can be used to pass a space delimited list of sensu plugins to install, in addition to the default list the `client` image has (See Dockerfile)

`SENSU_CLIENT_SUBSCRIPTIONS` can be used to set a space delimited list of subscriptions defaults to `default`

`/etc/sensu/user_conf.d/` is where you should mount any custom configs for any of the services.  will be merged with/override the defaults.


An all in one compose:

A docker-compose to run the api, server, client, redis, and dashboard might look like:

Basically, you need redis. Everything needs access to redis (so, if you were doing this across systems, export the redis port). Uchiwa needs access to the api. Thats it!

```
---
  redis:
    image: redis
  sensu-api:
    image: sjoeboo/sensu:api
    volumes:
      - ~/dev/sensu_docker/user_config.d:/etc/sensu/user_conf.d
    links:
      - redis:redis
  uchiwa:
    image: uchiwa/uchiwa
    ports:
      - 3000:3000
    volumes:
      - ~/dev/uchiwa:/config
    links:
      - sensu-api:sensu-api
  sensu-server1:
    image: sjoeboo/sensu:server
    volumes:
      - ~/dev/sensu_docker/user_config.d:/etc/sensu/user_conf.d
    links:
      - redis:redis
  sensu-client1:
    image: sjoeboo/sensu:client
    volumes:
      - ~/dev/sensu_docker/user_config.d:/etc/sensu/user_conf.d
    links:
      - redis:redis
    environment:
      SENSU_CLIENT_NAME: "client-01"
```
