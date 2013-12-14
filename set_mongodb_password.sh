#!/bin/bash

if [ -f /.mongodb_password_set ]; then
	echo "MongoDB password already set!"
	exit 0
fi

/usr/bin/mongod --smallfiles &
sleep 3

PASS=$(pwgen -s 12 1)
echo "=> Creating an admin user with a random password in MongoDB"
mongo admin --eval "db.addUser({user: 'admin', pwd: '$PASS', roles: [ 'userAdminAnyDatabase', 'dbAdminAnyDatabase' ]});"
mongo admin --eval "db.shutdownServer();"
sleep 3

echo "=> Done!"
touch /.mongodb_password_set

echo "========================================================================"
echo "You can now connect to this MongoDB server using:"
echo ""
echo "    mongo admin -u admin -p $PASS --host <host> --port <port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
