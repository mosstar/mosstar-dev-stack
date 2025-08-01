# Mosstar Development Stack

This repository contains the docker compose file for the development stack of Mosstar projects.

## Installation

Before you begin, ensure you have Docker and Docker Compose installed on your machine. If not, you can follow the
installation guide [here](https://docs.docker.com/desktop/).

### MacOS

To start the development stack, run the following command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mosstar/mosstar-dev-stack/main/install.sh)"
```

This command will clone the repository and start the development stack.

### Windows

To start the development stack, run the following commands:

```bash
git clone https://github.com/mosstar/mosstar-dev-stack.git
cd mosstar-dev-stack
cp .env.sample .env
docker compose up -d
```

After running these commands, the development stack will be up and running.  
Copy `windows-hosts.txt` content and paste it to `C:\Windows\System32\drivers\etc\hosts` file.

## Update

To update the development stack, run the following command in the repository directory:

```bash
./update.sh [--with-build] [--recreate-env] [--no-git-pull]
```

The `--with-build` option will rebuild the images before starting the stack.  
The `--recreate-env` option will recreate the `.env` file.  
The `--no-git-pull` option will prevent the script from pulling the latest changes from the repository.

## Services

The development stack includes the following services:

| Service           | Address                          | User Name         | Password   |
|-------------------|----------------------------------|-------------------|------------|
| Traefik Dashboard | http://traefik.local             | -                 | -          |
| Portainer UI      | http://portainer.local           | -                 | -          |
| postgres          | localhost:5432                   | mosstar           | mosstar123 |
| mongodb           | localhost:27017                  | mosstar           | mosstar123 |
| redis             | localhost:6379                   | -                 | -          |
| rabbitmq          | localhost:5672                   | mosstar           | mosstar123 |
| pgAdmin           | http://pgadmin.local             | mosstar@local.dev | mosstar123 |
| rabbitmq console  | http://rabbitmq.local            | mosstar           | mosstar123 |
| geoserver         | http://geoserver.local/geoserver | mosstar           | mosstar123 |
| minio             | http://minio.local               | mosstar           | mosstar123 |
| minio console     | http://minio-console.local       | mosstar           | mosstar123 |
| keycloak          | http://keycloak.local            | mosstar           | mosstar123 |
| elasticsearch     | http://elasticsearch.local       | elastic           | mosstar123 |
| kibana            | http://kibana.local              | elastic           | mosstar123 |
| apm-server        | http://apm.local                 | -                 | mosstar123 |
| grafana           | http://grafana.local             | mosstar           | mosstar123 |
| n8n               | http://n8n.local                 | -                 | -          |
| mailpit (ui)      | http://mailpit.local             | -                 | -          |
| mailpit (smtp)    | localhost:1025                   | mosstar           | mosstar123 |

## Development Tools and Programs Used in @mosstar

| Program                   | Category         | Link                                           |
|---------------------------|------------------|------------------------------------------------|
| iTerm2                    | Terminal         | https://iterm2.com/                            |
| Fork                      | Git GUI          | https://git-fork.com/                          |
| JetBrains Toolbox         | IDE              | https://www.jetbrains.com/toolbox-app/         |
| Visual Studio Code        | Code Editor      | https://code.visualstudio.com/                 |
| Docker Desktop            | Containerization | https://www.docker.com/products/docker-desktop |
| Apidog                    | API Client       | https://apidog.com/                            |
| Postman                   | API Client       | https://www.postman.com/                       |
| Navicat                   | Database Client  | https://www.navicat.com/en/products            |
| DBeaver                   | Database Client  | https://dbeaver.io/                            |
| MongoDB Compass           | MongoDB Client   | https://www.mongodb.com/products/tools/compass |
| Redis Insight             | Redis Client     | https://redis.io/insight/                      |
| Google Chrome             | Web Browser      | https://www.google.com/chrome/                 |
| Firefox Developer Edition | Web Browser      | https://www.mozilla.org/tr/firefox/developer/  |
| Figma                     | Design           | https://www.figma.com/                         |
| Zoom                      | Communication    | https://zoom.us/                               |
| Google Meet               | Communication    | https://meet.google.com/                       |
| Google Chat               | Communication    | https://chat.google.com/                       |
| AnyDesk                   | Remote Control   | https://anydesk.com/downloads                  |

## Customization

You can customize the development stack according to your project requirements. Feel free to fork this repository, make
changes, and submit a pull request for improvements.

Your contributions are welcome!
