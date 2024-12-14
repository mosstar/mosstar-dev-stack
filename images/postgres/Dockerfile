FROM postgres:16.3-bullseye

# Set the environment variables
ENV POSTGRES_DB=mosstar
ENV POSTGRES_USER=mosstar
ENV POSTGRES_PASSWORD=mosstar123

ENV LANG=tr_TR.utf8

# Install required packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      postgresql-16-postgis-3 \
      postgresql-16-postgis-3-scripts \
    && rm -rf /var/lib/apt/lists/*

# Turkish locale support
RUN localedef -i tr_TR -c -f UTF-8 -A /usr/share/locale/locale.alias tr_TR.UTF-8

# Enable PostGIS extension and copy the scripts to the container
RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./enable_postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./create_keycloak_db.sh /docker-entrypoint-initdb.d/15_keycloak.sh

EXPOSE 5432
