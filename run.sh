#!/bin/bash
if [ ! -f /.mongodb_password_set ]; then
	/set_mongodb_password.sh
fi
/usr/bin/mongod --smallfiles