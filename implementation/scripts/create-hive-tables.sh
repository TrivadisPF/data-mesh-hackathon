#!/bin/bash

if [ -z "$1" ]
  then
    echo 'Please specify the home directory of the Data Mesh project!'
    exit 1
fi

echo -e "\n--\n+> Creating Hive Tables"

docker cp $1/implementation/salesorder/hive/hive-salesorder.sql hive-metastore:/tmp
docker exec -ti hive-metastore hive -f /tmp/hive-salesoder.sql -v

docker cp $1/implementation/customer/hive/hive-customer.sql hive-metastore:/tmp
docker exec -ti hive-metastore hive -f /tmp/hive-customer.sql -v

docker cp $1/implementation/product/hive/hive-product.sql hive-metastore:/tmp
docker exec -ti hive-metastore hive -f /tmp/hive-product.sql -v
