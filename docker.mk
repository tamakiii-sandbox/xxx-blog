.PHONY: help install install-dev dependencies clean

ENVIRONMENT := production-pseudo

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

.env:
	echo "ENVIRONMENT=$(ENVIRONMENT)" > $@
	echo "ALB_PORT=$(ALB_PORT)" >> $@

clean:
	rm -rf .env

.PHONY: development
development:
	$(eval ENVIRONMENT := development)