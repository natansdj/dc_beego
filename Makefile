ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

#############################
# Docker machine states
#############################

up:
	docker-compose up -d

startdb:
	docker-compose up -d mariadb mongodb redis

start:
	docker-compose up -d krakend app auth profile product shipping voucher discount order

start2:
	docker-compose up -d rabbit queue payment

startmentor:
	docker-compose up -d mentor mentoring

startarisan:
	docker-compose up -d arisan app_arisan

startall: startdb && start && startbo && start2 && startmentor

startbo:
	docker-compose up -d backoffice api

recreatedb:
	docker-compose -f docker-compose.local.yml up -d --force-recreate mariadb mongodb redis

recreate:
	docker-compose -f docker-compose.local.yml up -d --force-recreate krakend app auth profile product shipping voucher discount order rabbit queue payment

recreatebo:
	docker-compose -f docker-compose.local.yml up -d --force-recreate backoffice api

stop:
	docker-compose stop krakend app auth profile product shipping voucher discount order

stop2:
	docker-compose stop rabbit queue payment

stopmentor:
	docker-compose stop mentor mentoring

stopmentor:
	docker-compose stop arisan app_arisan

stopbo:
	docker-compose stop backoffice api

stopdb:
	docker-compose stop mariadb mongodb redis

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

sehn:	docker manage
#############################
# Argument fix workaround
#############################
%:
	@:
