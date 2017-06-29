#
# INFRA-CENTOS6-PHP56-NGINX-MYSQL-CPHALCON Docker/Codeship CentOS with Web Application Components
#
FROM centos:6
MAINTAINER Louie Miranda <lmiranda@gmail.com>

RUN yum -y install epel-release
RUN yum -y install wget
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN wget https://centos6.iuscommunity.org/ius-release.rpm
RUN rpm -Uvh ius-release*.rpm
RUN yum -y update

# Installing web application components
RUN yum -y install php56u-fpm php56u php56u-opcache php56u-xml php56u-mcrypt php56u-gd php56u-devel php56u-mysql php56u-intl php56u-mbstring php56u-bcmath php56u-pecl-memcache

# Installing mysql
RUN yum -y install mysql-server mysql-client

# Installing nginx 
RUN yum -y install nginx

# Installing compiler, git 
RUN yum -y install git gcc

#
# Installing Phalcon 2.0.13
#
#RUN /usr/bin/git clone git://github.com/phalcon/cphalcon.git && \
#    cd cphalcon/build/ && \
#    ./install && \
#    cd /tmp && \
#    /bin/rm -rfv /tmp/cphalcon/ &&

RUN git clone https://github.com/phalcon/cphalcon.git &&

# RUN /bin/echo 'extension=phalcon.so' >/etc/php5/mods-available/phalcon.ini

# Installing other utilities
RUN yum -y install git software-properties-common zip unzip

# Other configs / timezone, short tags, etc
COPY settings/php.d /etc/php.d

# Adding the configuration file of the nginx
COPY settings/nginx/conf.d /etc/nginx/conf.d
ADD  settings/nginx/nginx.conf /etc/nginx/nginx.conf