curl -X "POST" "$DOCKER_HOST_IP:8083/connectors" \
     -H "Content-Type: application/json" \
     --data '{
  "name": "ecomm.customer.iceberg.sink",
  "config": {
      "connector.class": "io.tabular.iceberg.connect.IcebergSinkConnector",
      "tasks.max": "2",
      "topics": "pub.ecomm.customer.customer.state.v1",
      "iceberg.tables": "default.customer",
      "iceberg.tables.cdcField":"cdcMarker",
      "iceberg.tables.upsertModeEnabled":"true",
      "iceberg.catalog.type": "hive",
	  "iceberg.catalog.uri":"thrift://hive-metastore:9083",
      "iceberg.catalog.io-impl":"org.apache.iceberg.aws.s3.S3FileIO",
      "iceberg.catalog.warehouse":"s3a://pub.ecomm.customer-bucket/warehouse",
      "iceberg.catalog.client.region":"us-east-1",
      "iceberg.catalog.s3.endpoint":"http://minio-1:9000",
      "iceberg.catalog.s3.path-style-access": "true",
      "iceberg.catalog.s3.access-key-id":"V42FCGRVMK24JJ8DHUYG",
      "iceberg.catalog.s3.secret-access-key":"bKhWxVF3kQoLY9kFmt91l+tDrEoZjqnWXzY9Eza" ,
      "key.converter": "org.apache.kafka.connect.storage.StringConverter" 
  }
}'
