CREATE DATABASE ecomm_product;

USE ecomm_product;

DROP TABLE IF EXISTS product_state_t;

CREATE EXTERNAL TABLE product_state_t
PARTITIONED BY (year string, month string, day string, hour string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
  OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION 's3a://ecomm.product.bucket/raw/product.state.v1/pub.ecomm.product.product.state.v1'
TBLPROPERTIES ('avro.schema.url'='s3a://ecomm.product.bucket/avro/ProductState.avsc','discover.partitions'='false');  

MSCK REPAIR TABLE product_state_t SYNC PARTITIONS;