## Docker-Nginx-MySQL-Ubuntu12.04

Nginx MySQL docker container recipe.


### Installation

Install [Docker](https://gist.github.com/koudaiii/10282062#file-docker_install).
   [for mac](https://gist.github.com/koudaiii/10224422)

### Usage
In Host Machine

    $ git clone https://github.com/koudaiii/docker_mysql_ubuntu.git

Change username to your own

    $ vim ~/docker_mysql_ubuntu/nginx.conf

Change app to your app
   
    $ vim ~/docker_mysql_ubuntu/default

Change dockerfile to your Document_ROOT

    $ vim ~/docker_mysql_ubuntu/Dockerfile

Docker run

    $ docker build -t user/mysql . 

#### Attach persistent/shared directories

    $ docker run -d -p 80 -p 22 -p 3306 -v /var/log/nginx:/var/log/nginx -v /var/lib/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password koudaiii/mysql

    $ mysql -h 127.0.0.1 -u root -p
       Enter password:
       Welcome to the MySQL monitor.  Commands end with ; or \g.

Open `http://<host>` to see the welcome page.

####Option


