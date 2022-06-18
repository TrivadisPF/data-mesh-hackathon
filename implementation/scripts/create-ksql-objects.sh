#!/bin/bash

if [ -z "$1" ]
  then
    echo 'Please specify the home directory of the Data Mesh project!'
    exit 1
fi

echo -e "\n--\n+> Creating KSQL objects"

docker cp $1/implementation/customer/ksql/customer-v1.ksql ksqldb-server-1:/tmp
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088 -f /tmp/customer-v1.sql

docker cp $1/implementation/customer/ksql/prodocut-v1.ksql ksqldb-server-1:/tmp
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088 -f /tmp/product-v1.sql

docker cp $1/implementation/salesorder/ksql/salesorder-v1.ksql ksqldb-server-1:/tmp
docker exec -it ksqldb-cli ksql http://ksqldb-server-1:8088 -f /tmp/salesorder-v1.sql

