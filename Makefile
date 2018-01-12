.PHONY: test

COMPOSE_PROJECT_NAME=messaging
COMPOSE_FILE?=docker-compose.yml

COMPOSE_OVERRIDE_FILE?=
ifeq ($(COMPOSE_OVERRIDE_FILE),)
COMPOSE=docker-compose -p $(COMPOSE_PROJECT_NAME) -f $(COMPOSE_FILE)
else
COMPOSE=docker-compose -p $(COMPOSE_PROJECT_NAME) -f $(COMPOSE_FILE) -f $(COMPOSE_OVERRIDE_FILE)
endif

init: build install up

build:
	$(COMPOSE) build

up:
	$(COMPOSE) pull
	$(COMPOSE) up -d messaging

shell:
	docker exec -it $(COMPOSE_PROJECT_NAME)_$(COMPOSE_PROJECT_NAME)_1 /bin/bash

logs:
	docker logs -f messaging_messaging_1

mix: CMD?=phx.server
mix:
	$(COMPOSE) run -e APPLICATION_ENV=test --rm mix mix $(CMD)

run: mix

compile:
	$(MAKE) CMD=compile mix

compile-deps:
	$(MAKE) CMD="deps.compile" mix

install:
	$(MAKE) CMD="deps.get" mix

update:
	$(MAKE) CMD="deps.update --all" mix

test:
	$(MAKE) CMD=test mix

down:
	$(COMPOSE) down

clean:
	@echo "Killing containers and removing"
	$(COMPOSE) kill
	$(COMPOSE) rm --force
	@echo "Deleting build and deps"
	rm -Rf deps/ _build/