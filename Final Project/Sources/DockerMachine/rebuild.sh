#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

docker-compose build && ./reset.sh