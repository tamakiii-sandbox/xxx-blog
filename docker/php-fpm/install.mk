.PHONY: help install dependencies help

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	/usr/local/bin/composer \
	/usr/local/bin/symfony

dependencies:
	type php > /dev/null
	type curl > /dev/null

/usr/local/bin/symfony:
	curl -sS https://get.symfony.com/cli/installer | bash
	mv /root/.symfony/bin/symfony $@

/usr/local/bin/composer:
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php
	php composer-setup.php --install-dir=$(dir $@) --filename=$(notdir $@)
	php -r "unlink('composer-setup.php');"

clean:
	rm -rf /usr/local/bin/composer
	rm -rf /usr/local/bin/symfony