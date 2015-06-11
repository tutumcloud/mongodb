#!/bin/bash

if [ -f /data/db/.mongodb_password_set ]; then
	echo "MongoDB password already set!"
else
    /set_mongodb_password.sh
fi

mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE"
cmd="$mongodb_cmd --httpinterface --rest --master"
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi

lockfile=/data/db/mongod.lock
if [ -f $lockfile ]; then
    rm $lockfile
fi

exec $cmd

