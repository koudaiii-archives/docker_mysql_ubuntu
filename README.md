## Docker-Nginx-MySQL-Ubuntu12.04

Nginx MySQL docker container recipe.


### Installation

Install [Docker](https://gist.github.com/koudaiii/10282062#file-docker_install).
   [for mac](https://gist.github.com/koudaiii/10224422)

### Usage
In Host Machine

    $ git clone https://github.com/koudaiii/docker_mysql_ubuntu.git

### SSH-Key

    $ cp ~/.ssh/id_rsa.pub authorized_keys


Change username to your own

    $ vim ~/docker_mysql_ubuntu/nginx.conf

Change app to your app

    $ vim ~/docker_mysql_ubuntu/default

Change dockerfile to your Document_ROOT

    $ vim ~/docker_mysql_ubuntu/Dockerfile

Docker run

    $ docker build -t user/mysql .

#### Attach persistent/shared directories

    $ docker run -d -p 80 -p 22 -p 3306 -v koudaiii/mysql

    $ docker ps

    $ mysql -h localhost -P XXXX -u root -p
       Enter password:
       Welcome to the MySQL monitor.  Commands end with ; or \g.

Open `http://<host>` to see the welcome page.

#### Attach Volume

    $ vim  ~/docker_mysql_ubuntu/Dockerfile
        #VOL~~ Remove the comment out

    $ docker run -d -p 80 -p 22 -p 3306 -v /var/log/nginx:/var/log/nginx -v /var/lib/mysql:/var/lib/mysql koudaiii/mysql
