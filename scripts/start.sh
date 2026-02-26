#!/bin/bash
set -e

echo "ApplicationStart: Starting containers..."
cd /home/ubuntu/app

sudo docker compose --env-file .env pull

sudo docker compose --env-file .env up -d

echo "Waiting for services to be healthy..."
sleep 30

sudo docker compose ps
