WEB_SERVER = nginx
PHP_VERSION = 8.0

IMAGE_NAME = own_$(WEB_SERVER)
ROOT_DIR   := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BUILD_ID ?= $(shell /bin/date "+%Y%m%d-%H%M%S")
ARGS = $(filter-out $@,$(MAKECMDGOALS))
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

.SILENT: ;               # no need for @
.EXPORT_ALL_VARIABLES: ; # send all vars to shell

E ?= ternarniy operator
#VERSION ?= $(shell cat $(ROOT_DIR)/VERSION | head -n 1)
ifeq ($(VERSION),)
VERSION := 0.0.1
endif

default: help

test: SOME_ARG:=some_arg
test: SOME_ARG1:=some_arg1
test:
	echo $(E)
	echo $(ARGS)
	echo $(SOME_ARG)
ifneq ($(SOME_ARG1),)
	echo "with foo"
else
	echo "without SOME_ARG1: need global"
endif

check:
ifeq ($(IMAGE_NAME),)
	$(error Missed IMAGE_NAME argument.)
endif

build: check
	 echo "build...--no-cache"
	 docker build \
  	--build-arg USER_ID=$(USER_ID) \
  	--build-arg GROUP_ID=$(GROUP_ID) \
  	--build-arg WEB_SERVER=$(WEB_SERVER) \
  	--build-arg PHP_VERSION=$(PHP_VERSION) \
 	--force-rm  \
 	-t $(IMAGE_NAME) ./docker/

down:
	echo "delete all containers..."
	docker container rm $$(docker ps -aq) -f
#	@docker container rm $(shell docker ps -aq) -f

up:
	echo "up..."
	docker run -tid \
	--name $(IMAGE_NAME) \
	-v ${PWD}:/var/www/html/ \
	-e WEB_SERVER=$(WEB_SERVER) \
	-p 80:80 \
	$(IMAGE_NAME)

bash:
	docker exec -ti $(IMAGE_NAME) bash

logs:
	docker logs $(shell docker ps -aql)

.PHONY: help
help:
	@echo ''
	@echo 'Usage: make [target] [ENV_VARIABLE=ENV_VALUE ...]'
	@echo ''
	@echo 'Available targets:'
	@echo ''
	@echo '  help          Show this help and exit'
	@echo '  all           Build && up && bash'
	@echo '  build         Build or rebuild services'
	@echo '  up            Starts and attaches to containers for a service'
	@echo '  bash          Go to the application container (if any)'
	@echo '  down          Delete all containers'
	@echo '  logs          Show all logs from containers'
	@echo ''

%:
	@: