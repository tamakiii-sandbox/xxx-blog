.PHONY: help install install-dev dependencies build clean

ENVIRONMENT := production-pseudo

export DOCKER_BUILDKIT := 1
export COMPOSE_DOCKER_CLI_BUILD := 1

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	.env

install-dev: \
	development \
	install

dependencies:
	type docker > /dev/null
	type docker-compose > /dev/null

build:
	docker-compose build

.env:
	echo "ENVIRONMENT=$(ENVIRONMENT)" > $@
	echo "ALB_PORT=$(ALB_PORT)" >> $@

clean:
	rm -rf .env

.PHONY: development
development:
	$(eval ENVIRONMENT := development)