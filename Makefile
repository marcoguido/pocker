########################################################################################################################
### Loading master ENV file
########################################################################################################################
include docker/.env
export $(shell sed 's/=.*//' docker/.env)

########################################################################################################################
### Defining run variables
########################################################################################################################

#################################################
### Get which is current OS
#################################################
ifeq ($(OS),Windows_NT)
PLATFORM = Windows
else
PLATFORM = $(shell uname -s)
endif

#################################################
### Whether to opt-out from Docker-Sync
#################################################
ifeq ($(PLATFORM),Darwin)
ifdef NO_DOCKER_SYNC
PLATFORM = Linux
endif
endif

#################################################
### Whether to show Docker logs on stdout
#################################################
ifndef VERBOSE
DEMONIZED_COMPOSE = -d
endif

#################################################
### OS-aware docker-compose executable
#################################################
ifeq ($(PLATFORM),Windows)
COMPOSE_EXECUTABLE = docker-compose.exe
else
COMPOSE_EXECUTABLE = docker-compose
endif

#################################################
### Compose files location, depending on the OS
#################################################
MAIN_COMPOSE_PATH = docker/compose-files
PLATFORM_COMPOSE_FILES_ROOT = docker/compose-files/$(PLATFORM)

########################################################################################################################
### Defining Docker-Compose configuration files
########################################################################################################################

#################################################
### Pick main docker-compose file
#################################################
COMPOSE_FILES = -f $(MAIN_COMPOSE_PATH)/workspace.yml
ifeq ($(PLATFORM),Darwin)
COMPOSE_FILES += -f $(PLATFORM_COMPOSE_FILES_ROOT)/workspace-override.yml
endif

#################################################
### Add extra docker-compose files
#################################################
ifeq ($(PLATFORM),Windows)
COMPOSE_FILES += -f $(PLATFORM_COMPOSE_FILES_ROOT)/minio.yml
else
COMPOSE_FILES += -f $(MAIN_COMPOSE_PATH)/Linux/minio.yml
endif

#################################################
### Target web server docker-compose file
#################################################
ifeq (,$(findstring $(WEBSERVER),nginx apache))
$(error The WEBSERVER variable in the .env file is invalid. Accepted values are only apache or nginx, found $(WEBSERVER))
else ifeq ($(PLATFORM),Darwin)
COMPOSE_FILES += -f $(PLATFORM_COMPOSE_FILES_ROOT)/$(WEBSERVER).yml
else
COMPOSE_FILES += -f $(MAIN_COMPOSE_PATH)/Linux/$(WEBSERVER).yml
endif

#################################################
### Target DBMS docker-compose file
#################################################
ifeq (,$(findstring $(DBMS),postgresql mysql))
$(error The DBMS variable in the .env file is invalid. accepted values are only postgresql and mysql, found $(DBMS))
else ifeq ($(PLATFORM),Windows)
COMPOSE_FILES += -f $(PLATFORM_COMPOSE_FILES_ROOT)/$(DBMS).yml
else
COMPOSE_FILES += -f $(MAIN_COMPOSE_PATH)/Linux/$(DBMS).yml
endif

########################################################################################################################
### Makefile tasks
########################################################################################################################

build:
	$(info Building application containers..)
	@$(COMPOSE_EXECUTABLE) $(COMPOSE_FILES) build php $(WEBSERVER) $(DBMS) minio redis

sync-run:
	@cd $(PLATFORM_COMPOSE_FILES_ROOT) && docker-sync start

sync-stop:
	@cd $(PLATFORM_COMPOSE_FILES_ROOT) && docker-sync stop

compose-run:
	@cd $(MAIN_COMPOSE_PATH)
	@$(COMPOSE_EXECUTABLE) $(COMPOSE_FILES) up $(DEMONIZED_COMPOSE) php $(WEBSERVER) $(DBMS) minio redis

compose-stop:
	@cd $(MAIN_COMPOSE_PATH) && $(COMPOSE_EXECUTABLE) -f workspace.yml down --remove-orphans

tty:
	$(info Accessing main shell..)
	@cd $(MAIN_COMPOSE_PATH)
	@$(COMPOSE_EXECUTABLE) $(COMPOSE_FILES) exec php bash

webserver-tty:
	$(info Accessing webserver shell..)
	@cd $(MAIN_COMPOSE_PATH)
	@$(COMPOSE_EXECUTABLE) $(COMPOSE_FILES) exec $(WEBSERVER) bash

containers-list:
	$(info Here's the status of the running docker containers..)
	@docker ps

run-Darwin:
	@make -s sync-run
	@make -s compose-run

run-Linux:
	@make -s compose-run

run-Windows:
	@make -s compose-run

run:
	$(info Starting application..)
	@make -s run-$(PLATFORM)

stop-Darwin:
	@make -s sync-stop
	@make -s compose-stop

stop-Linux:
	@make -s compose-stop

stop-Windows:
	@make -s compose-stop

stop:
	$(info Stopping application containers..)
	@make -s stop-$(PLATFORM)

fresh-Linux:
	$(error Task not supported on $(PLATFORM))

fresh-Windows:
	$(error Task not supported on $(PLATFORM))

fresh-Darwin:
	@make -s stop
	@cd $(PLATFORM_COMPOSE_FILES_ROOT) && docker-sync-stack clean

fresh:
	$(info Purging Docker volumes..)
	@make -s fresh-$(PLATFORM)
