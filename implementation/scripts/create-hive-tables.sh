#!/bin/bash

if [ -z "$1" ]
  then
    echo 'Please specify the home directory of the Data Mesh project!'
    exit 1
fi

echo -e "\n--\n+> Creating Hive Tables"


cp $1/implementation/salesorder/hive/hive-salesorder.sql $1/infra/platys/data-transfer/tmp
docker exec -ti hive-metastore hive -f /data-transfer/tmp/hive-salesoder.sql

cp $1/implementation/customer/hive/hive-customer.sql $1/infra/platys/data-transfer/tmp
docker exec -ti hive-metastore hive -f /data-transfer/tmp/hive-customer.sql

cp $1/implementation/product/hive/hive-product.sql $1/infra/platys/data-transfer/tmp
docker exec -ti hive-metastore hive -f /data-transfer/tmp/hive-product.sql

rm $1/infra/platys/data-transfer/tmp/*.sql
