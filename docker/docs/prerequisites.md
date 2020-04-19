# Prerequisites
To use this configuration, three things are necessary before using this boilerplate.

1. The first thing you have to do is to  install the Docker runtime in your system.

    - If running MacOS as your OS you can simply install [Docker desktop](https://www.docker.com/products/docker-desktop) program.

    - If running Linux install the [Docker engine](https://docs.docker.com/install/linux/docker-ce) first, followed by the [Docker compose](https://docs.docker.com/compose/install/) utility and finally follow the [post install instructions](https://docs.docker.com/install/linux/linux-postinstall/)
        ```bash
        # Example procedure to install the runtime on a standard Ubuntu (16.04+) installation
    
        sudo apt remove docker docker-engine docker.io containerd runc
        sudo apt update
        sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  
        sudo apt-key fingerprint 0EBFCD88
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt update
        sudo apt install docker-ce docker-ce-cli containerd.io
        
        # docker compose installation
        sudo apt intsall docker-compose
    
        # Post install steps
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker 
        sudo systemctl enable docker  
    
        # Restarting the machine, in order to have the Docker engine successfully up an running
        sudo reboot now
        ```
        
        If running *Linux*, take also note of Docker IP address by running in a terminal window the following snippet: 
        ```bash
        ifconfig docker0 | grep inet
        ```
        The result will be something like this:
        ```bash
        user@example$ ifconfig docker0 | grep inet
            inet 172.17.0.1     netmask 255.255.255     broadcast 172.17.255.255
        ```
        You must take note of the first shown IP address (the one following the `inet` keyword)

2. The second thing to do is to make sure [Ruby](https://www.ruby-lang.org/) is installed in your system, in order to meet the next prerequisite.

3. As third step, we have to install the [`Docker Sync`](http://docker-sync.io/) utility.

    If you ever tried to develop something with Docker on a non-Linux OS, you surely incurred in degradated performances, expecially on MacOS. This is due to the virtualization layer which is in the middle between the Docker runtime and the operating system. To outcome this bottleneck, the `Docker Sync` utility comes to the rescue by taking care of synchronizing our sources with a virtual disk (in both directions) which will be created to run our project: this results in a noticeable performance boost.
