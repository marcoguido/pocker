# Pocker

## Docker configuration documentation
This repository contains a full development environment to be used to create/run a PHP (>= 7.0) project.

Most of the aspects of the configuration can be tuned via a `.env` file to be created in the [setup](docs/setup.md) phase.

## Contents
This configuration comprehends:

- _Docker-Sync_ support (MacOS only)

- 2 web servers (_apache_ and _nginx_)

- 2 DBMSs (_mysql_, _postgresql_)

- _redis_ for cache management

- _Minio_ as storage layer (exposes a set of APIs compatible with **Amazon S3**)

- A `workspace` container: this is an extended `php` image with everything required to build and run a project, with 
cron jobs and _Supervisor_ support

## Table of contents

| Sections                                      |
| --------------------------------------------- |
| [Usage prerequisites](docs/prerequisites.md)  |
| [Setup](docs/setup.md)                        |
| [Extras](docs/extras.md)                      |
| [Notes](docs/notes.md)                        |
