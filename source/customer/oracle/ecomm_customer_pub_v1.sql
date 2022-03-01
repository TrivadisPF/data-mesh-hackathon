-- USER SQL
CREATE USER ecomm_customer_pub_v1 IDENTIFIED BY "ecomm_customer_pub_v1"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

ALTER USER ecomm_customer_pub_v1 QUOTA UNLIMITED ON "USERS";


-- ROLES
GRANT "CONNECT" TO ecomm_customer_pub_v1 ;
GRANT "RESOURCE" TO ecomm_customer_pub_v1 ;
ALTER USER ecomm_customer_pub_v1 DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES
---
GRANT SELECt ANY TABLE to ecomm_customer_pub_v1;
GRANT CREATE VIEW TO ecomm_customer_pub_v1;



create or replace view ecomm_customer_pub_v1.v_customerstate as
SELECT distinct 
        greatest(customer_timestamp, address_timestamp) as "CHG"
,       json_object('eventId' value sys_guid(), 'idempotenceId' value sys_guid(), 'created' value created) as "identity"   
,       json_object('customerId' value i.customer_id 
            ,       'firstName' value i.first_name
            ,       'lastName' value i.last_name
            ,       'lastChangeTimeStamp' value (i.customer_timestamp) 
            ,       'address' value 
                        json_object('addressId' value i.address_id
                    ,       'address' value i.address 
                    ,       'city' value i.city
                    ,       'zipCode' value i.zip 
                    ,       'lastChangeTimeStamp' value (i.address_timestamp) 
                        )  
        ) as "customer"
FROM (
        SELECT  rank () over (partition by c.customer_id order by ca.event_timestamp desc ) rn
        ,       c.customer_id
        ,       c.first_name
        ,       c.last_name
        ,       c.event_timestamp_epoc AS customer_timestamp
        ,       a.address_id
        ,       a.address
        ,       a.zip
        ,       a.city
        ,       a.event_timestamp_epoc AS address_timestamp
        ,       ROUND((cast(sys_extract_utc(systimestamp) as date) - TO_DATE('1970-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS')) * 86400 * 1000) as created
        FROM    ecomm_customer_priv.v_customer c
                JOIN ecomm_customer_priv.v_cust2addr ca ON ca.customer_id = c.customer_id
                JOIN ecomm_customer_priv.v_address a ON a.address_id = ca.address_id
        ) i
WHERE rn = 1
;        




create or replace view ecomm_customer_pub_v1.v_customeradresschanged as
SELECT  
        address_timestamp as "CHG"
,       json_object('eventId' value sys_guid(), 'idempotenceId' value sys_guid(), 'created' value created) as "identity"   
,       i.customer_id as "customerId"
,       json_object('addressId' value i.address_id
                    ,       'address' value i.address 
                    ,       'city' value i.city
                    ,       'zipCode' value i.zip 
                    ,       'lastChangeTimeStamp' value (i.address_timestamp)  
                        )  as "address"
FROM (
        SELECT  rank () over (partition by c.customer_id order by ca.event_timestamp desc ) rn
        ,       c.customer_id
        ,       c.first_name
        ,       c.last_name
        ,       c.event_timestamp customer_timestamp
        ,       a.address_id
        ,       a.address
        ,       a.zip
        ,       a.city
        ,       a.event_timestamp_epoc address_timestamp
        ,       ROUND((cast(sys_extract_utc(systimestamp) as date) - TO_DATE('1970-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS')) * 86400 * 1000) as created
        FROM    ecomm_customer_priv.v_customer c
                JOIN ecomm_customer_priv.v_cust2addr ca ON ca.customer_id = c.customer_id
                JOIN ecomm_customer_priv.v_address a ON a.address_id = ca.address_id
        ) i
order by i.address_timestamp desc
;      

