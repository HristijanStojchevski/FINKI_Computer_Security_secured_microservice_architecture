#!/bin/bash

export DOCKER_HOST_IP=$(docker-machine ip)

docker-compose up -d --build