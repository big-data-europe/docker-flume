FROM ubuntu:trusty

MAINTAINER Juergen Jakobitsch <jakobitschj@semantic-web.at>

RUN apt-get install -y wget unzip software-properties-common vim

RUN  add-apt-repository -y ppa:webupd8team/java
RUN  apt-get update
RUN  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN  apt-get -y install oracle-java8-installer
RUN  apt-get -y install oracle-java8-set-default

RUN /bin/bash -c "source /etc/profile.d/jdk.sh"

RUN cd /tmp/ && wget http://www.eu.apache.org/dist/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz

RUN mkdir -p /usr/local/apache-flume/

RUN tar -zxvf /tmp/apache-flume-1.6.0-bin.tar.gz -C /usr/local/apache-flume/

RUN ln -s /usr/local/apache-flume/apache-flume-1.6.0-bin /usr/local/apache-flume/current

RUN cd /tmp/ && wget http://www.eu.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz

RUN mkdir -p /usr/local/apache-zookeeper/

RUN tar -zxvf /tmp/zookeeper-3.4.6.tar.gz -C /usr/local/apache-zookeeper/

RUN ln -s /usr/local/apache-zookeeper/zookeeper-3.4.6 /usr/local/apache-zookeeper/current

ENV FLUME_HOME="/usr/local/apache-flume/current"
ENV ZK_HOME="/usr/local/apache-zookeeper/current"

ADD flume-env.sh /usr/local/apache-flume/current/conf/

RUN /bin/bash -c "source /usr/local/apache-flume/current/conf/flume-env.sh"
