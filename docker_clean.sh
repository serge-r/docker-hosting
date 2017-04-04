#!/bin/bash

# Clean all running containers
# !!!!! Use carefully !!!!!

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
