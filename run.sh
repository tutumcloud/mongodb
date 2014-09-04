#!/bin/bash
if [ ! -f /.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi
exec /usr/bin/mongod --nojournal --auth --rest
