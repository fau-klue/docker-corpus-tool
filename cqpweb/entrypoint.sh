#!/bin/bash
# Entrypoint for Docker Container

# TODO: Check and Init Database
# CREATE DATABASE cqpweb DEFAULT charset utf8;
# CREATE user cqpweb identified BY 'secret';
# GRANT ALL ON cqpweb.* TO cqpweb;
# GRANT file ON *.* TO cqpweb;

exec "$@"
