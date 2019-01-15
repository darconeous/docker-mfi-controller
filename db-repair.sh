#!/bin/sh
#
# This script will repair the mongodb if it ever gets into a bad state,
# such as can happen after a power outage. It can take a very long time
# to complete and requires at least 2x the space of the original DB.
#
# Once complete, the container is restarted automatically.
#

echo '************************************************************************'
echo '* NOTE: THE REPAIR PROCESS CAN TAKE A LONG TIME, POSSIBLY 24H OR MORE! *'
echo '************************************************************************'
echo ''

if [ $# != 1 ]
then
	echo "Syntax: $0 [container-name]"
	exit 1
fi

CONTAINER=$1

docker exec -ti "${CONTAINER}" /bin/kill -s SIGSTOP 1
docker exec -ti "${CONTAINER}" /usr/bin/mongod --repair --dbpath /mFi/data/db
docker restart "${CONTAINER}"
