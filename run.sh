#!/bin/bash
if [ ! -f /.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi

if [ "$AUTH" == "yes" ]; then
    export mongodb='/usr/bin/mongod --nojournal --auth --rest'
else
    export mongodb='/usr/bin/mongod --nojournal --rest'
fi

if [ ! -f /data/db/mongod.lock ]; then
    eval $mongodb
else
    export mongodb=$mongodb' --dbpath /data/db' 
    rm /data/db/mongod.lock
    mongod --dbpath /data/db --repair && eval $mongodb
fi

