#!/bin/bash
set -m

mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE"
cmd="$mongodb_cmd --httpinterface --rest --master"
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$AUTH" == "no" ]; then
    touch /data/db/.mongodb_password_set
    echo "========================================================================"
    echo "You can now connect to this MongoDB server using:"
    echo ""
    echo "    mongo --host <host> --port <port>"
    echo ""
    echo "Please remember: Having no password is a security risk and should"
    echo "only be used during development."
    echo "========================================================================"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi

$cmd &

if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_mongodb_password.sh
fi

fg
