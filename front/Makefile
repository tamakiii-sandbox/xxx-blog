.PHONY: help install dependencies build check clean

ENVIRONMENT := production-pseudo

help:
	@cat $(firstword $(MAKEFILE_LIST))

build:
	npx --no-install webpack --mode production

build-dev:
	npx --no-install webpack-dev-server --host 0.0.0.0 --disable-host-check

check:
	npx --no-install tsc -p . --noEmit

install: \
	node_modules

install-dev: \
	development \
	install

dependencies:
	type npm > /dev/null
	type node > /dev/null

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
	$(eval ENVIRONMENT := development