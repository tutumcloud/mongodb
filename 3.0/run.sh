#!/bin/bash

lockfile=/data/db/mongod.lock
mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE"
if [ -f $lockfile ]; then
    rm $lockfile
    echo "Reparing database"
    $mongodb_cmd --repair
fi

if [ ! -f $db_path/.mongodb_password_set ]; then
	echo "MongoDB password already set!"
    /set_mongodb_password.sh
fi

cmd="$mongodb_cmd --httpinterface --rest"
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ ! -f $lockfile ]; then
    exec $cmd
else
    rm $lockfile
    echo "Reparing database"
    $mongodb_cmd --repair && exec $cmd
fi

