CREATE DATABASE ecomm_customer;

USE ecomm_customer;

DROP TABLE IF EXISTS customer_state_t;

CREATE EXTERNAL TABLE customer_state_t
PARTITIONED BY (year string, month string, day string, hour string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
  OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION 's3a://ecomm.customer.bucket/raw/customer.state.v1/pub.ecomm.customer.customer.state.v1'
TBLPROPERTIES ('avro.schema.url'='s3a://ecomm.customer.bucket/avro/CustomerState.avsc','discover.partitions'='false');  

MSCK REPAIR TABLE customer_state_t SYNC PARTITIONS;