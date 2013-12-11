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

	ID=$(sudo docker run -d -p 27017 tutum/mongodb)


It will store the new container ID (like `d35bf1374e88`) in $ID. Get the allocated external port:

	sudo docker port $ID 27017


It will print the allocated port (like 4751). Test your deployment:

	mongo --port 4751 --host 127.0.0.1

Done!
