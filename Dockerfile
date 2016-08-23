FROM ubuntu:trusty

MAINTAINER Juergen Jakobitsch <jakobitschj@semantic-web.at>

RUN apt-get update && apt-get install -y wget unzip software-properties-common vim

RUN  add-apt-repository -y ppa:webupd8team/java
RUN  apt-get update
RUN  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN  apt-get -y install oracle-java8-installer
RUN  apt-get -y install oracle-java8-set-default

RUN /bin/bash -c "source /etc/profile.d/jdk.sh"

ADD apache-flume-1.6.0-bin.tar.gz /usr/local/apache-flume/
RUN ln -s /usr/local/apache-flume/apache-flume-1.6.0-bin /usr/local/apache-flume/current
RUN rm -f /tmp/apache-flume-1.6.0-bin.tar.gz

ADD zookeeper-3.5.2-alpha.tar.gz /usr/local/apache-zookeeper/
RUN ln -s /usr/local/apache-zookeeper/zookeeper-3.5.2-alpha /usr/local/apache-zookeeper/current
RUN rm -f /tmp/zookeeper-3.5.2-alpha.tar.gz

ENV FLUME_HOME="/usr/local/apache-flume/current"
ENV ZK_HOME="/usr/local/apache-zookeeper/current"


COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

RUN ln -s /usr/local/apache-flume/apache-flume-1.6.0-bin/ /app
RUN ln -s /usr/local/apache-flume/apache-flume-1.6.0-bin/conf /config

ADD flume-bin.py /app/bin/
ADD flume-init /app/bin/
ADD flume-env.sh /config/
#EXPOSE 44444
