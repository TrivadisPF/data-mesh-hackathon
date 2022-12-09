Sign into Oracle Cloud: <https://myservices-cacct-b6063537a0f74b379df34849b201bd04.console.oraclecloud.com/mycloud/cloudportal/gettingStarted>

```bash
cd .ssh

ssh -i ssh-key-2022-04-24.key ubuntu@140.238.174.129
```

##

`ecomm_customer`
`XEPDB1


## Customer

```sql
UPDATE address_t SET city = UPPER(city), modified_date = CURRENT_TIMESTAMP
WHERE address_id = 15978;

UPDATE person_t SET modified_date = CURRENT_TIMESTAMP
WHERE business_entity_id = 6943;

COMMIT;
```


```bash
docker exec -ti hive-metastore hive

USE pub_ecomm_customer;
MSCK REPAIR TABLE customer_state_t SYNC PARTITIONS;
```


```bash
docker exec -ti trino-cli trino --server trino-1:8080 --catalog minio
```

```
use minio.pub_ecomm_customer;

SELECT * FROM customer_v WHERE id = 6943;
```

## Salesorder
