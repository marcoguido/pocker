# Notes
- Keep in mind that on each system reboot, you'll have to run the following commands to bring up the development environment:
    1. `cd` to this repository root directory

    2. Execute `make run` or `make run VERBOSE=true`.

- If you want to connect to one of the DBMS container you started from your **host** computer, as `host` value remember to set your _HOME IP_ (`127.0.0.1`) and as port the one defined by either the `MYSQL_PORT` or `POSTGRESQL_PORT` defined in the `.env` file.

- If you have to connect your project to a DBMS remember to use the standard ports for each system (i.e. `3306` for **MySQL** and `5432` for **PostgreSQL**) and for the connection `host` use the name of the service (`mysql` or `postgresql`).

- If for some reason the synchronization made by `Docker Sync` does not perform correctly and seems unresponsive, simply kill every running container and reboot the Docker Desktop application (if on MacOS).

- The `Makefile` present in the root folder of the project defines some interesting tasks to be executed:

1. Run `make build` or simply `make` to build the environment

2. Run `make stop` to shutdown the environment

3. Run `make containers-list` to have an overview of all running containers

4. Run `make restart` to reboot the environment

5. Run `make fresh` to drop `Docker Sync` volume and re-synchronize it

6. Run `make tty` to spawn a bash session from the `workspace` container

7. Run `make webserver-tty` to spawn a bash session from the webserver of choice (`apache` or `nginx`) container
