#!/bin/bash -xe

# This project is designed to be built from outside docker,
# or to be built from a repo directly (not a working folder,
# which could be a submodule)
make

./gitautotag.sh --rev || true

TAG=$(git describe --tags --always)
set -xe
docker build . -f Dockerfile -t summittech/nginx_rtmp_exporter -t summittech/nginx_rtmp_exporter:$TAG
docker push summittech/nginx_rtmp_exporter:$TAG
docker push summittech/nginx_rtmp_exporter:latest
