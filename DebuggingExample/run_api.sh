#!/bin/bash

dockerd-entrypoint.sh &

cd /app

sam local start-api --region us-west-2 --host 0.0.0.0