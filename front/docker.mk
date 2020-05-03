.PHONY: help install install-dev dependencies build clean

ENVIRONMENT := production-pseudo

export DOCKER_BUILDKIT := 1
export COMPOSE_DOCKER_CLI_BUILD := 1

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	.env \
	node_modules

install-dev: \
	development \
	install

dependencies:
	type npm > /dev/null
	type node > /dev/null
	type docker > /dev/null
	type docker-compose > /dev/null

build:
	docker-compose build

.env:
	echo "ENVIRONMENT=$(ENVIRONMENT)" > $@

node_modules:
ifeq ($(ENVIRONMENT),production-pseudo)
	npm install
else
	npm install --dev
endif

clean:
	rm -rf node_modules

.PHONY: development
development:
	$(eval ENVIRONMENT := development)