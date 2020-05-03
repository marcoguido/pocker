# Extra configuration setup
- If you plan to use `xDebug` tool to debug your PHP code, follow the guide that can be found [here](./xdebug.md)

- If you want to use one or more cronjobs, create one or more `.job` files in `docker/workspace/cron-jobs` folder. Each 
    of them will be loaded when the environment starts.

- If you have to add one or more Supervisor programs, create one or more `.conf` files in 
    `docker/workspace/supervisor-programs` folder. Each of them will be loaded when the environment starts.

- If you want to load your ssh key into the workspace container, copy the `id_rsa` and `id_rsa.pub` into the
    `docker/workspace/ssh-keys` folder: they will be loaded by the environment once it is built. If the keys for some
    reasons were not loaded, run in the terminal inside `workspace` container:
    ```bash
    eval `ssh-agent -s`
    ssh-add /root/.ssh/id_rsa
    ```

- If you want to load your ssl certificates to access your project through HTTPS, copy your `crt` file as `server.crt` 
and your `.key` file as `server.key` into the `docker/workspace/ssl-certificates` folder and they will be loaded by the 
environment.
