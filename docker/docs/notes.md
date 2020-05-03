# Notes
- Keep in mind that on each system reboot, you'll have to run the following commands to bring up the development environment:
    1. `cd` to the root directory of this repository

    2. Execute `make run` with the optional `VERBOSE=true` and `NO_DOCKER_SYNC=true` flags, depending on your needs.

- If you want to connect to the DBMS container from your **host** system, remember to set as `host` value `127.0.0.1` 
    (your _HOME IP_) and as `port` the value defined by either the `MYSQL_PORT` or `POSTGRESQL_PORT` in the `.env` file.  
    The same considerations applies to the `Redis` service.

- If you want to connect your project to a DBMS remember to use the standard ports for each system (i.e. `3306` for 
    **MySQL** and `5432` for **PostgreSQL**) and for the connection `host` use the name of the DBMS (`mysql` or 
    `postgresql`).  
    The same considerations applies to the `Redis` and `Minio` services.

- If for some reason the synchronization made by `Docker Sync` does not perform correctly and seems unresponsive, simply
    kill every running container and reboot the Docker Desktop application (on MacOS).

- The `Makefile` present in the root folder of the project defines some interesting tasks to be executed:

1. Run `make build` or simply `make` to build the environment

2. Run `make stop` to kill running containers of the environment

3. Run `make containers-list` to have an overview of all running containers

4. Run `make fresh` to drop _Docker-Sync_ volume and re-synchronize it (only available on MacOS)

5. Run `make tty` to spawn a bash session from the `workspace` container

6. Run `make webserver-tty` to spawn a bash session from the web server of choice (`apache` or `nginx`) container

- Note that adding or editing cron jobs, Supervisor programs, SSH keys or SSL certificates requires a full rebuild of 
    the environment (by running `make` or `make build`).

- On MacOS, if you decided to opt out from using the _Docker-Sync_ tool, you may want to add to your `.bashrc` 
    (or `.zshrc`) file the `NO_DOCKER_SYNC=true` variable, in order to remove the need of typing it every time you want 
    to start/stop/access your Docker containers.

- If you decided to always display a verbose output from the containers, you may want to add to your `.bashrc` (or
    `.zshrc`) file the `VERBOSE=true` variable, in order to remove the need of typing it every time you want to start 
    your Docker containers.
