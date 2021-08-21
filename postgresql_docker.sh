#######################
#
# Author: J-dar Siegfred Rodriguez
# Created: August 21, 2021
#
# Shell script for running postgresql from dockerhub
#
# POSTGRES_USER - Username for postgresql.
# POSTRGES_PASSWORD - Password for postgresql.
# POSTGRES_DB - DB name, will use POSTGRES_USER if not defined.
# PG_DATA - Used for data retention mount.
#
###################

#!/bin/bash
bash -c "docker run -d --name <CONTAINER_NAME> \
-e POSTGRES_USER=<USER> \
-e POSTGRES_PASSWORD=<PASSWORD> \
-e POSTGRES_DB=<DB_NAME> \
-e PG_DATA=/var/lib/postgresql/data/pgdata \
-v <HOST_MOUNT_POINT>:/var/lib/postgresql/data -p <HOST_PORT>:5432 postgres"
