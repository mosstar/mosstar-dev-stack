# mosstar dev stack

This repository contains the docker-compose file for the development stack of the mosstar projects.

## Installation

Firstly, you have to install docker and docker-compose on your machine. Then, you can run the following command to start
the development stack.

Installation Link: https://docs.docker.com/desktop/

```bash
$ git clone git@github.com:mosstar/dev-stack.git mosstar-dev-stack
$ cd mosstar-dev-stack
$ docker-compose up --build -d
```

## Services

The following table shows the services that are included in the development stack.

| Service           | Address                              | User Name | Password   |
|-------------------|--------------------------------------|-----------|------------|
| Traefik Dashboard | http://traefik.localhost             | -         | -          |
| postgresql        | localhost:5435                       | mosstar   | mosstar123 |
| redis             | localhost:6379                       | -         | -          |
| rabbitmq          | localhost:5672                       | mosstar   | mosstar123 |
| rabbitmq console  | http://rabbitmq.localhost            | mosstar   | mosstar123 |
| geoserver         | http://geoserver.localhost/geoserver | mosstar   | mosstar123 |
| minio             | http://minio.localhost               | mosstar   | mosstar123 |
| minio console     | http://minio-console.localhost       | mosstar   | mosstar123 |
| keycloak          | http://keycloak.localhost            | mosstar   | mosstar123 |
| elasticsearch     | http://elasticsearch.localhost       | elastic   | mosstar123 |
| kibana            | http://kibana.localhost              | elastic   | mosstar123 |
| apm-server        | http://apm.localhost                 | -         | mosstar123 |
