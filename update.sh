#!/bin/bash

git checkout master
git pull origin master

# restart the docker containers
docker-compose up --build -d
