# mosstar dev stack

## Introduction
Firstly, you have to install docker and docker-compose on your machine. Then, you can run the following command to start the development stack.

Installation Link: https://docs.docker.com/desktop/

```bash
$ docker-compose up -d
```

## Services
The following table shows the services that are included in the development stack.

| Service           | Address                              | User Name | Password   |
|-------------------|--------------------------------------|-----------|------------|
| Traefik Dashboard | http://traefik.localhost             | -         | -          |
| postgresql        | localhost:5435                       | postgres  | postgres   |
| redis             | localhost:6379                       | -         | -          |
| rabbitmq          | localhost:5672                       | admin     | admin123   |
| rabbitmq console  | http://rabbitmq.localhost            | admin     | admin123   |
| geoserver         | http://geoserver.localhost/geoserver | admin     | admin123   |
| minio             | http://minio.localhost               | admin     | admin123   |
| minio console     | http://minio-console.localhost       | admin     | admin123   |
| keycloak          | http://keycloak.localhost            | admin     | admin123   |
| elasticsearch     | http://elasticsearch.localhost       | elastic   | elastic123 |
| kibana            | http://kibana.localhost              | elastic   | elastic123 |
| apm-server        | http://apm.localhost                 | -         | token123   |
