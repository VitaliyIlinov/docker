IMAGE_NAME = apache_php

# Run make help by default # Run make help by default or first command
.DEFAULT_GOAL = help

E ?= ternarniy operator

all: build up bash

test:$(foo)
	#echo $(E)
ifneq ($(foo),)
	@echo "with foo"
else
	@echo "without foo"
endif

build: PHP_VERSION:=7.2
build:
	@echo "build..."
	 docker build \
 	--build-arg PHP_VERSION=$(PHP_VERSION) \
 	--force-rm  \
 	-t $(IMAGE_NAME) .
# 	--no-cache \

del:
	@echo "delete all containers..."
	@docker container rm $$(docker ps -aq) -f
#	@docker container rm $(shell docker ps -aq) -f

up:
	@echo "up..."
	@docker run -tid \
	--name $(IMAGE_NAME) \
	-v ${PWD}/app:/var/www/app/ \
	-p 80:80 \
	$(IMAGE_NAME)

bash:
	@docker exec -ti $(IMAGE_NAME) bash

logs:
	@docker logs $(shell docker ps -aql)

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
	@echo '  del           Deleter all containers'
	@echo '  logs          Show all logs from containers'
	@echo ''

%:
	@: