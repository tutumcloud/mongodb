#!/bin/bash

lockfile=/data/db/mongod.lock
if [ -f $lockfile ]; then
    rm $lockfile
    mongod --dbpath /data/db --repair
fi

if [ ! -f /.mongodb_password_set ]; then
    /set_mongodb_password.sh
fi

cmd='/usr/bin/mongod --nojournal --httpinterface --rest'
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ ! -f $lockfile ]; then
    exec $cmd
else
    cmd="$cmd --dbpath /data/db"
    rm $lockfile
    mongod --dbpath /data/db --repair && exec $cmd
fi

