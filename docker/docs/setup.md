# Configuration setup
In order to successfully run and access your project, you have to follow some simple configuration steps.

1. Whether in the `src` folder you are dropping a single site or a bunch, append each one of their domain names to your 
system *hosts* file (which can be found at `/etc/host` if your computer is running Linux or MacOS, at 
`C:\Windows\System32\drivers\etc\hosts` if running Windows), binding them to your _home IP address_ (`127.0.0.1` should 
be fine), as shown below.

    In the following example configuration, `example.test` will be the domain name which will be used to access the project.
    ```bash
    127.0.0.1	example.test
    ```   
   Add also a bonus entry in your `hosts` file in order to map the `Minio` storage, if you intend to use it:
   ```bash
    127.0.0.1  minio
   ```

2. Inside the `docker` folder there is a `.env.example` file defining the main aspects of the environment you will run 
your project(s) in. Rename that file to `.env` and update every variable according to your needs. The various options 
will now be listed below.

    ```dotenv
    #################
    # PROJECT Stuff #
    #################
   
    # The name of your project: docker containers will have that as prefix
    COMPOSE_PROJECT_NAME=docker_boilerplate 
   
    # The webserver you will use to expose the site. The value can either be nginx or apache 
    WEBSERVER=nginx
    
    # The database management system of choice. You can choose from mysql or postgresql
    DBMS=mysql
   
    # DBMS root user's credentials
    DBMS_USER=root
    DBMS_ROOT_PASSWORD=mysecret
    
    #######################
    # Webserver Container #
    #######################
   
    # Default port which you will use to access the frontend of your project
    HTTP_SERVER_PORT=80
    # ... And the one to access the project through HTTPS (if you want to use SSL)
    HTTPS_SERVER_PORT=443
    
    #####################
    # Development tools #
    #####################
   
    # Whether you want to install NVM, NodeJS and NPM 
    ENABLE_NODEJS_SUPPORT=true

    # Which is your NodeJS version of choice 
    PREFERRED_NODE_VERSION=stable
   
    # Whether to install Laravel Framework installer through composer 
    ENABLE_LARAVEL_INSTALLER=false
    
    #################
    # PHP Container #
    #################
    # The PHP version. Every 7.x version is fully supported. 
    PHP_VERSION=7.4
    
    # Whether to install MySQL support 
    ENABLE_MYSQL_SUPPORT=true

    # Whether to install PostgreSQL support 
    ENABLE_POSTGRESQL_SUPPORT=false

    # Whether to install xDebug support, to easily debug PHP scripts 
    ENABLE_XDEBUG_SUPPORT=true

    # Whether to install Mcrypt extension (which was dropped in 7.1+ PHP releases) 
    ENABLE_MCRYPT_SUPPORT=false
   
    # Whether to install Imagic PHP extension (required to perform image manipulations) 
    ENABLE_IMAGIC_SUPPORT=false

    # Whether to install Redis support 
    ENABLE_PHPREDIS_SUPPORT=true

    # Whether to install Intl support (in order to perform locale-aware operations natively) 
    ENABLE_INTL_SUPPORT=true
    
    # XDebug configuration
    # Valid for Docker for Mac; for Linux get workspace container IP
    XD_REMOTE_HOST=host.docker.internal
   
    # The port exposed from the containter for the xDebug service
    XD_REMOTE_PORT=9001
   
    # The key identifying a valid xDebug client, can be any string
    XD_IDEKEY=PHPSTORM
    
    ###################
    # NGINX Container #
    ###################
    NGINX_VERSION=latest
    
    ####################
    # APACHE Container #
    ####################
    APACHE_VERSION=latest
   
    # Whether to enable SSL support in Apache
    ENABLE_SSL=true
    
    ###################
    # MySQL CONTAINER #
    ###################
    MYSQL_VERSION=5.7

    # Which will be the port exposed to the host for the MySQL container
    MYSQL_PORT=33060
    
    ########################
    # PostgreSQL Container #
    ########################
    POSTGRESQL_VERSION=latest
   
    # Which will be the port exposed to the host for the PostgreSQL container
    POSTGRESQL_PORT=54320
    
    #################
    # Minio storage #
    #################
    # MinIO credentials, they can be any string of choice
    MINIO_ACCESS_KEY=MinioAccessKey
    MINIO_SECRET_KEY=MinioSecretKey

    # Which will be the port exposed to the host for the MinIO container
    MINIO_PORT=9002
    
    #########
    # Redis #
    #########
    # Which will be the port exposed to the host for the Redis container
    REDIS_PORT=63790
    ```

3. Depending on the web server you want to use, replicate the default _virtualhost_ file either for `nginx` or `apache`,
 respectively inside `docker/http/apache/virtualhosts` or `docker/http/nginx/virtualhosts` folder and update each copy 
 according to your needs.

4. Open a terminal window and head to the root folder of this repository. There, execute the command `make`: all the 
environment for your project will be crafted (note that this step is required after every update to the `.env` file of
 *step 2*)

5. Now that the environment is ready, we can start it. The first run could be slow, as `Docker Sync` utility has to 
synchronize you project source files into a virtual volume: don't worry, is a one-timer operation.
    
    To start the environment, run in the same terminal as before the command `make run`. If you want to see the logs of 
    your containers, you can execute `make run VERBOSE=true` instead of the previous command.  

    If you want to opt-out from using `Docker-Sync`, append to the following commands the flag `NO_DOCKER_SYNC=true` 

6. To test that everything is working fine, open your favourite browser and try entering one of the domains you earlier 
registered in the *hosts* file at *step 1* of current tasks list.

7. If everything succeeded, you should be able to access the `workspace` container console by running in a new terminal 
window (pointing to the root of this repository) `make tty`. If you decided not to go with `Docker-Sync` remember to add
the `NO_DOCKER_SYNC=true` flag to the command.
