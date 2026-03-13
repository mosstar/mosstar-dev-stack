FROM postgres:16.3-bullseye

# Set the environment variables
ENV POSTGRES_DB=mosstar
ENV POSTGRES_USER=mosstar
ENV POSTGRES_PASSWORD=mosstar123

ENV LANG=tr_TR.utf8
ENV TZ=Europe/Istanbul
ENV PGTZ=Europe/Istanbul

# Add pgvector source
ADD https://github.com/pgvector/pgvector.git#v0.8.2 /tmp/pgvector

# Install required packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      postgresql-16-postgis-3 \
      postgresql-16-postgis-3-scripts \
      build-essential \
      postgresql-server-dev-16 \
      clang-13 \
      llvm-13 \
    && cd /tmp/pgvector \
    && make clean \
    && make OPTFLAGS="" \
    && make install \
    && mkdir -p /usr/share/doc/pgvector \
    && cp LICENSE README.md /usr/share/doc/pgvector \
    && apt-get remove -y build-essential postgresql-server-dev-16 clang-13 llvm-13 \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/pgvector

# Turkish locale support
RUN localedef -i tr_TR -c -f UTF-8 -A /usr/share/locale/locale.alias tr_TR.UTF-8

# Scripts and extensions
RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./enable_extensions.sh /docker-entrypoint-initdb.d/10_extensions.sh
COPY ./create_keycloak_db.sh /docker-entrypoint-initdb.d/15_keycloak.sh
COPY ./create_n8n_db.sh /docker-entrypoint-initdb.d/20_n8n.sh

EXPOSE 5432
