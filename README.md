# Mosstar Development Stack

This repository contains the docker-compose file for the development stack of Mosstar projects.

## Installation

Before you begin, ensure you have Docker and Docker Compose installed on your machine. If not, you can follow the
installation guide [here](https://docs.docker.com/desktop/).

To start the development stack, run the following command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mosstar/mosstar-dev-stack/master/install.sh)"
```

This command will clone the repository and start the development stack.

## Update

To update the development stack, run the following command in the repository directory:

```bash
./update.sh
```

## Services

The development stack includes the following services:

| Service           | Address                          | User Name              | Password   |
|-------------------|----------------------------------|------------------------|------------|
| Traefik Dashboard | http://traefik.local             | -                      | -          |
| Portainer UI      | http://portainer.local           | -                      | -          |
| postgres          | localhost:5432                   | mosstar                | mosstar123 |
| redis             | localhost:6379                   | -                      | -          |
| rabbitmq          | localhost:5672                   | mosstar                | mosstar123 |
| pgAdmin           | http://pgadmin.local             | mosstar@mosstar.com.tr | mosstar123 |
| rabbitmq console  | http://rabbitmq.local            | mosstar                | mosstar123 |
| geoserver         | http://geoserver.local/geoserver | mosstar                | mosstar123 |
| minio             | http://minio.local               | mosstar                | mosstar123 |
| minio console     | http://minio-console.local       | mosstar                | mosstar123 |
| keycloak          | http://keycloak.local            | mosstar                | mosstar123 |
| elasticsearch     | http://elasticsearch.local       | elastic                | mosstar123 |
| kibana            | http://kibana.local              | elastic                | mosstar123 |
| apm-server        | http://apm.local                 | -                      | mosstar123 |

## Customization

You can customize the development stack according to your project requirements. Feel free to fork this repository, make
changes, and submit a pull request for improvements.

Your contributions are welcome!
