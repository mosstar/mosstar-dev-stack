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
cp .env.example .env
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

| Service           | Address                             | User Name         | Password   | Profile    |
|-------------------|-------------------------------------|-------------------|------------|------------|
| Traefik Dashboard | http://traefik.internal             | -                 | -          | -          |
| Portainer UI      | http://portainer.internal           | -                 | -          | -          |
| postgres          | localhost:5432                      | mosstar           | mosstar123 | -          |
| mongodb           | localhost:27017                     | mosstar           | mosstar123 | -          |
| redis             | localhost:6379                      | -                 | -          | -          |
| rabbitmq          | localhost:5672                      | mosstar           | mosstar123 | -          |
| pgAdmin           | http://pgadmin.internal             | mosstar@local.dev | mosstar123 | -          |
| rabbitmq console  | http://rabbitmq.internal            | mosstar           | mosstar123 | -          |
| minio             | http://minio.internal               | mosstar           | mosstar123 | -          |
| minio console     | http://minio-console.internal       | mosstar           | mosstar123 | -          |
| keycloak          | http://keycloak.internal            | mosstar           | mosstar123 | -          |
| mailpit (smtp)    | localhost:1025                      | mosstar           | mosstar123 | -          |
| mailpit (ui)      | http://mailpit.internal             | -                 | -          | -          |
| elasticsearch     | http://elasticsearch.internal       | elastic           | mosstar123 | elastic    |
| kibana            | http://kibana.internal              | elastic           | mosstar123 | elastic    |
| apm-server        | http://apm.internal                 | -                 | mosstar123 | elastic    |
| grafana           | http://grafana.internal             | mosstar           | mosstar123 | monitoring |
| influxdb          | localhost:8181                      | -                 | -          | monitoring |
| influxdb (ui)     | http://influxdb.internal            | -                 | -          | monitoring |
| seq               | localhost:5341                      | -                 | -          | monitoring |
| seq (ui)          | http://seq.internal                 | -                 | -          | monitoring |
| geoserver         | http://geoserver.internal/geoserver | mosstar           | mosstar123 | gis        |
| n8n               | http://n8n.internal                 | -                 | -          | tools      |
| metabase          | http://metabase.internal            | -                 | -          | tools      |
| litellm (ui)      | http://llm.internal/ui              | mosstar           | mosstar123 | ai         |

### Profiles

Services without a profile always start. Services with a profile are optional and start only when their profile is
enabled. To enable profiles, set `COMPOSE_PROFILES` in your `.env` file (comma-separated) and run `./update.sh`:

```bash
COMPOSE_PROFILES=elastic,tools
```

`--recreate-env` resets `.env`, so set `COMPOSE_PROFILES` again afterwards.

- To start one optional service without changing `.env`, target it directly: `docker compose up -d kibana`. Its
  dependencies start as well.
- To start everything: `docker compose --profile "*" up -d`
- `docker compose down` only stops services of enabled profiles. To stop everything, or after removing a profile from
  `.env`, use `docker compose --profile "*" down`.

If you are upgrading from a version without profiles, add the profiles you use to `.env`, otherwise those services keep
running but are no longer updated. To remove the services you no longer need, run `docker compose --profile "*" down`
and then `./update.sh`.

### AI Models (optional)

The `ai` profile adds an OpenAI-compatible API backed by local models.
Models run on [Docker Model Runner](https://docs.docker.com/ai/model-runner/) (GPU accelerated on Apple Silicon and
NVIDIA) and are served through a [LiteLLM](https://docs.litellm.ai/) proxy.

1. Enable Docker Model Runner in Docker Desktop (Settings → AI).
2. Add `ai` to `COMPOSE_PROFILES` in your `.env` file (see [Profiles](#profiles)).
3. Run `./update.sh`. The first start downloads the model (~270 MB).

| Setting  | Value                  |
|----------|------------------------|
| Base URL | http://llm.internal/v1 |
| API key  | sk-mosstar123          |
| Models   | `chat`                 |

```bash
curl http://llm.internal/v1/chat/completions \
  -H "Authorization: Bearer sk-mosstar123" \
  -H "Content-Type: application/json" \
  -d '{"model": "chat", "messages": [{"role": "user", "content": "Hello!"}]}'
```

`chat` is served by [SmolLM2 360M](https://hub.docker.com/r/ai/smollm2), a small, mostly English model chosen to keep
resource usage low. It is good enough for integration and smoke tests, not for real output quality.
Applications should always call the `chat` alias: to use a bigger model, change the `models` section in
`docker-compose.yml` and no application code needs to change.

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
