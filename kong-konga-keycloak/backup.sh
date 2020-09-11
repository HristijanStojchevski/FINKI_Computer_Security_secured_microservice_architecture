#!/bin/bash
docker exec -t kong-konga-keycloak_kong-db_1 pg_dumpall -c -U kong > dump_kong.sql
docker exec -t kong-konga-keycloak_keycloak-db_1 pg_dumpall -c -U keycloak > dump_keycloak.sql
