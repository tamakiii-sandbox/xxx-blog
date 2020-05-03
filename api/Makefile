.PHONY: help install dependencies clean

ENVIRONMENT := production-pseudo

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	vendor

install-dev: \
	development \
	install

vendor:
ifeq ($(ENVIRONMENT),production-pseudo)
	composer install --no-dev
else
	composer install --dev
endif

clean:
	rm -rf vendor

.PHONY: development
development:
	$(eval ENVIRONMENT := development)