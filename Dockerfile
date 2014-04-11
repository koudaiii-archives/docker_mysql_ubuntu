# Nginx Dockerfile
#
# VERSION       1

FROM ubuntu:12.04
MAINTAINER koudaiiii "cs006061@gmail.com"

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

#Dev tools for all Docker
RUN apt-get -y install git vim

#Install ssh
RUN apt-get -y install openssh-server
RUN mkdir /var/run/sshd
RUN chmod 711 /var/run/sshd


#Setup sshd
RUN  sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

#install user
RUN apt-get -y install passwd sudo

# useradd user,name to koudaiii
RUN useradd --create-home -s /bin/bash koudaiii ;\
    adduser koudaiii sudo ;\
    echo "koudaiii:password" | chpasswd;

# Set .ssh
RUN mkdir -p /home/koudaiii/.ssh;chown koudaiii /home/koudaiii/.ssh; chmod 700 /home/koudaiii/.ssh
ADD ./authorized_keys /home/koudaiii/.ssh/authorized_keys
RUN chown koudaiii /home/koudaiii/.ssh/authorized_keys;chmod 600 /home/koudaiii/.ssh/authorized_keys

# setup sudoers
RUN echo "koudaiii ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/koudaiii
RUN chmod 440 /etc/sudoers.d/koudaiii

# setup timezone
RUN mv /etc/localtime /etc/localtime.org
RUN ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# setup Supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports.
EXPOSE 22
ADD supervisor/supervisord.conf /etc/supervisord.conf


#################################################################################
# Install Nginx.
RUN apt-get install -y nginx
RUN nginx -v

# Setup Nginx
RUN mkdir -p /var/www
ADD ./index.html /var/www/index.html
ADD ./default /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
RUN rm /etc/nginx/nginx.conf
ADD ./nginx.conf /etc/nginx/nginx.conf

# Attach volumes.
VOLUME /var/log/nginx

# Expose ports.
EXPOSE 80


#######################################  Mysql  ########################################

RUN apt-get install -y mysql-server mysql mysql-devel mysql-client

ADD my.cnf /etc/mysql/conf.d/my.cnf
RUN chmod 664 /etc/mysql/conf.d/my.cnf

#Mysql run
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

#Mount Volume host 
VOLUME ["/var/lib/mysql"]

CMD ["/usr/local/bin/run"]

# expose for mysqld
EXPOSE 3306

#############

# Supervisor
CMD ["/usr/bin/supervisord"]
