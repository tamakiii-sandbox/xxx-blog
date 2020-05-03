.PHONY: help install install-dev dependencies build clean

ENVIRONMENT := production-pseudo
WEBPACK_PORT := 8080

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
	echo "WEBPACK_PORT=$(WEBPACK_PORT)" >> $@

node_modules:
ifeq ($(ENVIRONMENT),production-pseudo)
	npm install
else
	npm install --dev
endif

clean:
	rm -rf .env

.PHONY: development
development:
	$(eval ENVIRONMENT := development)