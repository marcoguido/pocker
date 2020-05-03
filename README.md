---

<p align="center">
    <img src="/.github/images/pocker-logo.jpg?raw=true" alt="Pocker Logo"/>
</p>

---

# Pocker

### PHP :heart: Docker: say hi to Pocker!
Pocker will help you build your next PHP application without the worrying about setting up your development environment,
or help you in dockerizing an existent one.

Pocker is a full fledged dockerized PHP environment with a ton of configurability. Just update a `.env` file to be ready
to build something great.

Not convinced yet? C'mon, don't be shy and give it a try! :muscle:

## Content :books:
The Pocker package contains a fully working PHP environment and it's up to you choosing the right PHP version: each release
starting from 7.0 can be installed. Ah, did I mention that enabling **xDebug** support is as simple as writing `true` in
the configuration file?

Are you running on MacOS and you worry about Docker performances on your system?
**We do, too.**  
.. This is why we added support for the [Docker-Sync](http://docker-sync.io/) utility. Slow performances are now only 
bad memories. :sunglasses:

Hey, do you want to stick with the default Docker runtime and not to use or install _Docker-Sync_? We got you covered here,
as well.

Together with the PHP runtime, you can choose a webserver (between _nginx_ and _Apache_), and your favorite
DBMS (options are _MySQL_ and _PostgreSQL_). Each of these pieces of software can be used at your favorite version, according
to your needs.

In addition to these components, a [Redis](https://redis.io/) and [Minio](https://min.io) containers are available,
together with the support of custom SSL certificates for your website testing, custom cron jobs and _Supervisor_ to 
automate task and operations, custom SSH keys to communicate to remote servers or pull dependencies from private 
repositories and much more..

## Setup :gear:
First of all, grab a copy of this repository either forking it or downloading the sources.

If you want to build a new project from scratch, simply follow [the installation and support guide](docker/Readme.md)
available in **docker** subfolder, otherwise if you aim to dockerize an existing project, copy its source files in the
`src` folder as first step.

## Quick start :surfer:
A common quick start example would consist in:
1. Renaming the `.env.example` file inside **docker** folder to `.env`
2. Running in a terminal `make` or `make build`
3. After the build finishes, run `make run` in the same terminal
4. :boom: you are ready to go!

## Usage :rocket:
This is a templating repository, it's intent is to be a good base for a project. In this way, we created and added
some folders which now are empty, but that you may want to fill with your project data.

For example:
- The `docs` folder in the current directory should house the documentation of your project, if a single
`README` file is not sufficient
- The `src` folder will contain all the source files
- The _docker_ directory houses (you don't say) Docker configuration files

`LICENSE` and `README` files are intended to be replaced by yours: here's why we chose to put the setup guide inside
the `docker` directory, in order for it to be left untouched and be consulted whenever needed.

This approach creates a strong separation of concerns, which is good in order to keep everything as clean as possible.  

For more information and a detailed guide of how the underlining Docker configuration works, check out the installation
and support guide [here](docker/Readme.md)

## Disclaimer :warning_sign:
At the moment, the repository has been tested on MacOS, Linux and Windows: everything should be working fine.  
For Windows users: be aware this configuration has been tested only in a context where Docker for Windows is 
installable (i.e. OS installs where Virtualization can be enabled, such as Windows 10 Pro, Education, etc.).    
