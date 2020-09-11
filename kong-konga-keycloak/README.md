# kong-konga-keycloak
Note: when using docker build and docker-compose make sure you are in the right directory.

See information about functionalities and things of interest at [https://docs.google.com/document/d/1ENcb4lMzz0dn91iQT1mzSpG1OSQUXCDHwbYVyXDEFX4/edit](https://docs.google.com/document/d/1ENcb4lMzz0dn91iQT1mzSpG1OSQUXCDHwbYVyXDEFX4/edit). 

For now start by logging in at [http://localhost:8000/users/login](http://localhost:8000/users/login).

## SETUP

On the first start:

SET DOCKER_HOST env for the users service in docker-compose.yml to your Local IP address.

Initialize the configuration for Kong and Keycloak:
```bash
./init.sh
```
Patch/set the kong-oidc discovery and introspection endpoints with the current PC’s local IP address
(make sure the kong container is up and running):
```bash
python patch-kong-oidc.py
```

The next time we want to start the containers, we can just use 'docker-compose up -d'.