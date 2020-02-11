ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

#############################
# Docker machine states
#############################

up:
	docker-compose up -d

start:
	docker-compose up -d mariadb krakend app auth profile product shipping voucher discount

start2:
	docker-compose up -d mariadb krakend app auth profile product shipping voucher discount redis rabbit mongodb queue payment

recreate:
	docker-compose -f docker-compose.local.yml up -d --force-recreate mariadb krakend app auth profile product shipping voucher discount redis rabbit mongodb queue payment

recreatebo:
	docker-compose -f docker-compose.local.yml up -d --force-recreate mariadb redis backoffice api

startbo:
	docker-compose up -d mariadb redis backoffice api

stop:
	docker-compose stop

state:
	docker-compose ps

rebuild:
	docker-compose stop
	docker-compose pull
	docker-compose rm --force app
	docker-compose build --no-cache --pull
	docker-compose up -d --force-recreate

#############################
# General
#############################

bash: shell

shell:
	docker-compose exec --user application app /bin/bash

root:
	docker-compose exec --user root app /bin/bash

#############################
# Argument fix workaround
#############################
%:
	@:
