# Loading project environment variables
include docker/.env
export $(shell sed 's/=.*//' docker/.env)

# Defining base compose file
COMPOSE_FILE_PATH := -f docker/compose-files/docker-compose.yml

# Picking the right web server for the project
ifeq (,$(findstring $(WEBSERVER),nginx apache))
$(error The WEBSERVER variable in the .env file is invalid. Accepted values are only apache or nginx, found $(WEBSERVER))
else
COMPOSE_FILE_PATH += -f docker/compose-files/docker-compose-$(WEBSERVER).yml
endif

# Picking the right DBMS for the project
ifeq (,$(findstring $(DBMS),postgresql mysql))
$(error The DBMS variable in the .env file is invalid. accepted values are only postgresql and mysql, found $(DBMS))
else
COMPOSE_FILE_PATH += -f docker/compose-files/docker-compose-$(DBMS).yml
endif

ifndef VERBOSE
VERBOSE_FLAG = -d
endif

build:
	$(info Building application containers..)
	@docker-compose $(COMPOSE_FILE_PATH) build php $(WEBSERVER) $(DBMS) minio redis

compose-run:
	$(info Starting application containers..)
	@cd docker/compose-files
	@docker-compose $(COMPOSE_FILE_PATH) up $(VERBOSE_FLAG) php $(WEBSERVER) $(DBMS) minio redis

sync-run:
	$(info Starting Docker Sync daemon..)
	@cd docker/compose-files && docker-sync start

sync-stop:
	$(info Stopping Docker Sync daemon..)
	@cd docker/compose-files && docker-sync stop

compose-stop:
	$(info Stopping compose containers..)
	@cd docker/compose-files && docker-compose down --remove-orphans

tty:
	$(info Accessing main shell..)
	@cd docker/compose-files
	@docker-compose $(COMPOSE_FILE_PATH) exec php bash

webserver-tty:
	$(info Accessing webserver shell..)
	@cd docker/compose-files
	@docker-compose $(COMPOSE_FILE_PATH) exec $(WEBSERVER) bash

containers-list:
	$(info Here's the status of the running docker containers..)
	@docker ps

run:
	$(info Starting application containers with Docker Sync..)
	@make -s sync-run
	@make -s compose-run

stop:
	$(info Stopping application containers..)
	@make -s sync-stop
	@make -s compose-stop

restart:
	$(info Restarting application environment..)
	@make -s stop
	@make -s run
	$(info Restarted.)

fresh:
	$(info Purging Docker Sync volume..)
	@make -s stop
	@cd docker/compose-files && docker-sync-stack clean
	$(info All cleaned!)
