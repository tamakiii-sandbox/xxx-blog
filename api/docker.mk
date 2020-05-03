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
	echo "ENVIRONMENT=$(ENVIRONMENT)" >> $@
	echo "TZ=Asia/Tokyo" >> $@
	echo "LANG=ja_JP.UTF-8" >> $@
	echo "LANGUAGE=ja_JP:ja" >> $@
	echo "LC_ALL=ja_JP.UTF-8" >> $@
	echo "###> symfony/framework-bundle ###" >> $@
	echo "APP_ENV=dev" >> $@
	echo "APP_SECRET=bde2186c0696b2f282982662f4253ebd" >> $@
	echo "DATABASE_URL=mysql://username:password@mysql:3306/xxx_blog" >> $@
	echo "#TRUSTED_PROXIES=127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16" >> $@
	echo "#TRUSTED_HOSTS='^(localhost|example\.com)$'" >> $@
	echo "###> symfony/framework-bundle ###" >> $@

clean:
	rm -rf .env

.PHONY: development
development:
	$(eval ENVIRONMENT := development)