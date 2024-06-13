# Mosstar Development Stack

This repository contains the docker-compose file for the development stack of Mosstar projects.

## Installation

Before you begin, ensure you have Docker and Docker Compose installed on your machine. If not, you can follow the installation guide [here](https://docs.docker.com/desktop/).

To start the development stack, run the following command:

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mosstar/mosstar-dev-stack/master/install.sh)"
```

## Services

The development stack includes the following services:

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

## Customization

You can customize the development stack according to your project requirements. Feel free to fork this repository, make changes, and submit a pull request for improvements.

Your contributions are welcome!
