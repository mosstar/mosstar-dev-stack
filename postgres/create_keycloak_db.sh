#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	CREATE USER keycloak WITH PASSWORD 'keycloak';
	CREATE DATABASE keycloak;
	GRANT ALL PRIVILEGES ON DATABASE keycloak TO keycloak;

	\c keycloak;

	GRANT ALL PRIVILEGES ON SCHEMA public TO keycloak;
	GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO keycloak;
	ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO keycloak;
	ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO keycloak;
EOSQL
