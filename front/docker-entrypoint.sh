#!/usr/bin/env bash

if [ "$1" = "" ]; then
  make build-dev
else
  exec "$@"
fi