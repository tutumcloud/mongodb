tutum-docker-mongodb
====================

Base docker image to run a MongoDB database server


Usage
-----

To create the image `tutum/mongodb`, execute the following command on the tutum-mongodb folder:

	sudo docker build -t tutum/mongodb .


Running the MongoDB server
--------------------------

Run the following command to start MongoDB:

	CONTAINER_ID=$(sudo docker run -d -p 27017 tutum/mongodb)

The first time that you run your container, a new random password will be set.
To get the password, check the logs of the container by running:

	sudo docker logs $CONTAINER_ID

You will see an output like the following:

	========================================================================
	You can now connect to this MongoDB server using:

	    mongo admin -u admin -p 5elsT6KtjrqV --host <host> --port <port>

	Please remember to change the above password as soon as possible!
	========================================================================

In this case, `5elsT6KtjrqV` is the password set. To get the allocated port to MongoDB, execute:

	sudo docker port $CONTAINER_ID 27017

It will print the allocated port (like 4751). You can then connect to MongoDB:

	 mongo -u admin -p 5elsT6KtjrqV --host 127.0.0.1 --port 4751

Done!
