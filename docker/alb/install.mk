.PHONY: help install dependencies clean

DAYS := 3650

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependencies \
	/usr/local/nginx/conf \
	/usr/local/nginx/conf/server.key \
	/usr/local/nginx/conf/server.crt

dependencies:
	type openssl > /dev/null

/usr/local/nginx/conf/server.key:
	openssl genrsa 2048 > $@

/usr/local/nginx/conf/server.csr: /usr/local/nginx/conf/server.key
	openssl req -new -nodes -subj '/C=JA/O=Example Inc./CN=localhost' -key $^ > $@

/usr/local/nginx/conf/san.txt:
	echo "subjectAltName = DNS:*.localhost, IP:127.0.0.1" > $@

/usr/local/nginx/conf/server.crt: /usr/local/nginx/conf/server.key /usr/local/nginx/conf/server.csr /usr/local/nginx/conf/san.txt
	openssl x509 -req -sha256 -days 3650 -signkey $(word 1,$^) -in $(word 2,$^) -extfile $(word 3,$^) > $@

/usr/local/nginx/conf:
	mkdir -p $@

clean:
	rm -rf /usr/local/nginx/conf