#!/usr/bin/env sh
# Entrypoint for Docker Container
set -e

# Wait for database connection
./wait-for-it.sh --timeout=0 ${DB_HOST}:${DB_PORT}

# Check if database is initialized

# Initialize Database

# CREATE DATABASE cqpweb DEFAULT charset utf8;
# CREATE user cqpweb identified BY '$DB_PASSWORD';
# GRANT ALL ON cqpweb.* TO cqpweb;
# GRANT file ON *.* TO cqpweb;

exec "$@"
