FROM ubuntu:14.04
MAINTAINER Fernando Mayo <fernando@tutum.co>

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt utopic main restricted universe multiverse \n\
deb mirror://mirrors.ubuntu.com/mirrors.txt utopic-updates main restricted universe multiverse \n\
deb mirror://mirrors.ubuntu.com/mirrors.txt utopic-backports main restricted universe multiverse \n\
deb mirror://mirrors.ubuntu.com/mirrors.txt utopic-security main restricted universe multiverse" > /etc/apt/sources.list.d/all-mirrors.list

RUN apt-get update && \
    apt-get install -y mongodb pwgen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN mkdir -p /data/db
VOLUME /data/db

ENV auth yes

# Add run scripts
ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
RUN chmod 755 ./*.sh

EXPOSE 27017
EXPOSE 28017

CMD ["/run.sh"]
