FROM ubuntu:latest
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install MongoDB server from official repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get update
RUN apt-get install -y mongodb-10gen pwgen
RUN mkdir -p /data/db

# Add run scripts
ADD https://raw.github.com/tutumcloud/tutum-docker-mongodb/master/run.sh /run.sh
ADD https://raw.github.com/tutumcloud/tutum-docker-mongodb/master/set_mongodb_password.sh /set_mongodb_password.sh
RUN chmod 755 ./*.sh

EXPOSE 27017
CMD ["/run.sh"]
