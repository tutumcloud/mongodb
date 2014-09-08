#!/bin/bash
if [ ! -f /.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi
if [ ! -f /data/db/mongod.lock ]; then
exec /usr/bin/mongod --nojournal --auth --rest
else
rm /data/db/mongod.lock
mongod --dbpath /data/db --repair && exec /usr/bin/mongod --nojournal --auth --rest --dbpath /data/db
fi

