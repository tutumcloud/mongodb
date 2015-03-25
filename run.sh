#!/bin/bash

lockfile=/data/db/mongod.lock
if [ -f $lockfile ]; then
    rm $lockfile
    mongod --dbpath /data/db --repair
fi

if [ ! -f /.mongodb_password_set ]; then
    /set_mongodb_password.sh
fi

if [ "$AUTH" == "yes" ]; then
    export mongodb='/usr/bin/mongod --nojournal --auth --httpinterface --rest'
else
    export mongodb='/usr/bin/mongod --nojournal --httpinterface --rest'
fi

if [ ! -f $lockfile ]; then
    exec $mongodb
else
    export mongodb=$mongodb' --dbpath /data/db' 
    rm $lockfile
    mongod --dbpath /data/db --repair && exec $mongodb
fi

