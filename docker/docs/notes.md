# Notes
- Keep in mind that on each system reboot, you'll have to run the following commands to bring up the development environment:
    1. `cd` to this repository root directory

    2. Execute `make run` with the optional `VERBOSE=true` and `NO_DOCKER_SYNC=true` flags.

- If you want to connect to one of the DBMS container you started from your **host** computer, as `host` value remember 
to set your _HOME IP_ (`127.0.0.1`) and as port the one defined by either the `MYSQL_PORT` or `POSTGRESQL_PORT` defined 
in the `.env` file.

- If you want to connect your project to a DBMS remember to use the standard ports for each system (i.e. `3306` for 
**MySQL** and `5432` for **PostgreSQL**) and for the connection `host` use the name of the service (`mysql` or 
`postgresql`).

- If for some reason the synchronization made by `Docker Sync` does not perform correctly and seems unresponsive, simply
 kill every running container and reboot the Docker Desktop application (if on MacOS) or the Docker service (on Linux).

- The `Makefile` present in the root folder of the project defines some interesting tasks to be executed:

1. Run `make build` or simply `make` to build the environment

2. Run `make stop` to shutdown the environment

3. Run `make containers-list` to have an overview of all running containers

4. Run `make restart` to reboot the environment

5. Run `make fresh` to drop `Docker Sync` volume and re-synchronize it

6. Run `make tty` to spawn a bash session from the `workspace` container

7. Run `make webserver-tty` to spawn a bash session from the webserver of choice (`apache` or `nginx`) container

- Note that adding or editing cron jobs, Supervisor programs, SSH keys or SSL certificates requires a full rebuild of 
the environment (by running `make`).

- If you decided to opt out from using the `Docker Sync` tool, you may want to add to your `.bashrc` (or `.zshrc`) file
the `NO_DOCKER_SYNC=true` variable, in order to remove the need of typing it every time you want to start/stop/access 
your Docker containers

- If you decided to always display a verbose output from the containers, you may want to add to your `.bashrc` (or
`.zshrc`) file the `VERBOSE=true` variable, in order to remove the need of typing it every time you want to start 
your Docker containers
