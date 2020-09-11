#!/bin/bash

export DOCKER_HOST_IP=$(docker-machine ip)
echo $DOCKER_HOST_IP
docker-compose up -d kong-db
docker-compose up -d keycloak-db
sleep 10

cat ./kong-konga-keycloak/dump_kong.sql | docker exec -i mutualproject-activityroom_with_secured_microservice_architecture_kong-db_1 psql -U kong -d postgres
cat ./kong-konga-keycloak/dump_keycloak_basic.sql | docker exec -i mutualproject-activityroom_with_secured_microservice_architecture_keycloak-db_1 psql -U keycloak -d postgres

docker-compose up -d --build