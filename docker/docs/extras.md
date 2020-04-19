# Extra configuration setup
- If you plan to use `xDebug` tool to debug your PHP code, follow the guide that can be found [here](./xdebug.md)
- If you want to use one or more cronjobs, create one or more `.job` files in `docker/workspace/cron-jobs` folder. Each of them will be loaded when the environment starts.
- If you have to add one or more Supervisor programs, create one or more `.conf` files in `docker/workspace/supervisor-programs` folder. Each of them will be loaded when the environment starts.
- If you want to load your ssh key into the workspace container, copy them into the `docker/workspace/ssh-keys` folder and they will be loaded by the environment.
- If you want to load your ssl certificates to access your project through HTTPS, copy your `crt` file as `server.crt` and your `.key` file as `server.key` into the `docker/workspace/ssl-certificates` folder and they will be loaded by the environment.

Note that adding or editing cron jobs, Supervisor programs, SSH keys or SSL certificates requires a full rebuild of the environment (by running `make`).
