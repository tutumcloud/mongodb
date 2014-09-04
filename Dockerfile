FROM ubuntu:trusty
MAINTAINER Fernando Mayo <fernando@tutum.co>

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y pwgen
RUN mkdir -p /data/db

# Add run scripts
ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
RUN chmod 755 ./*.sh

EXPOSE 27017
EXPOSE 28017

CMD ["/run.sh"]
