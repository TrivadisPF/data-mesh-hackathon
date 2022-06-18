DROP DATABASE IF EXISTS ecomm_salesorder CASCADE;
CREATE DATABASE ecomm_salesorder;

USE ecomm_salesorder;

DROP TABLE IF EXISTS salesorder_completed_event_t;

CREATE EXTERNAL TABLE salesorder_completed_event_t
PARTITIONED BY (year string, month string, day string, hour string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
  OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION 's3a://ecomm.salesorder-bucket/raw/salesorder.state.v1/pub.ecomm.salesorder.order-completed.event.v1'
TBLPROPERTIES ('avro.schema.url'='s3a://ecomm.meta-bucket/avro/pub.ecomm.salesorder.order-completed.event.v1-value.avsc','discover.partitions'='false');  

MSCK REPAIR TABLE salesorder_completed_event_t SYNC PARTITIONS;
