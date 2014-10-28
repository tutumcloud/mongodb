#!/bin/bash
if [ ! -f /.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi

if [ "$auth" == "yes" ]; then
    mongodb = '/usr/bin/mongod --nojournal --auth --rest'
else
    mongodb = '/usr/bin/mongod --nojournal --rest'

if [ ! -f /data/db/mongod.lock ]; then
    eval $mongodb
else
    rm /data/db/mongod.lock
    mongod --dbpath /data/db --repair && eval $mongodb --dbpath /data/db
fi

