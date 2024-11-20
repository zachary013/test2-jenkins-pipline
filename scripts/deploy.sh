#!/bin/bash

# Deploy script for different environments
ENVIRONMENT=$1
PORT=$2

if [ -z "$ENVIRONMENT" ] || [ -z "$PORT" ]; then
    echo "Usage: ./deploy.sh <environment> <port>"
    echo "Example: ./deploy.sh staging 5001"
    exit 1
fi

# Stop and remove existing container
docker ps -q --filter "name=flask-app-$ENVIRONMENT" | grep -q . && docker stop flask-app-$ENVIRONMENT
docker ps -aq --filter "name=flask-app-$ENVIRONMENT" | grep -q . && docker rm flask-app-$ENVIRONMENT

# Run new container
docker run -d --name flask-app-$ENVIRONMENT -p $PORT:5000 flask-app:$ENVIRONMENT

echo "Deployed flask-app:$ENVIRONMENT on port $PORT"