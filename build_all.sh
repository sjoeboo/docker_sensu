#!/bin/bash

docker build -t sjoeboo/sensu:base base/
docker build -t sjoeboo/sensu:api api/
docker build -t sjoeboo/sensu:server server/
docker build -t sjoeboo/sensu:client client/
