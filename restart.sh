#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

docker-compose down && docker-compose up