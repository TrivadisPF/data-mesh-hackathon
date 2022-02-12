-- USER SQL
CREATE USER customer_data_dp IDENTIFIED BY "customer_data_dp"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

ALTER USER customer_data_dp QUOTA UNLIMITED ON "USERS";


-- ROLES
GRANT "CONNECT" TO customer_data_dp ;
GRANT "RESOURCE" TO customer_data_dp ;
ALTER USER customer_data_dp DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES
---
GRANT SELECt ANY TABLE to customer_data_dp;
GRANT CREATE VIEW TO customer_data_dp;



create or replace view customer_data_dp.v_customerstate as
SELECT distinct 
        greatest(customertimestamp, AddressTimestamp) as "CHG"
,       json_object('eventId' value sys_guid(), 'idempotenceId' value sys_guid(), 'created' value created) as "identity"   
,       json_object('customerId' value i.customerid 
            ,       'firstName' value i.firstname 
            ,       'lastName' value i.lastname 
            ,       'lastChangeTimeStamp' value to_char(i.customertimestamp, 'yyyy-mm-dd"T"hh24:mi:ss.ff') 
            ,       'address' value 
                        json_object('addressId' value i.AddressID
                    ,       'address' value i.Address 
                    ,       'city' value i.city
                    ,       'zipCode' value i.zip 
                    ,       'lastChangeTimeStamp' value to_char(i.AddressTimestamp, 'yyyy-mm-dd"T"hh24:mi:ss.ff') 
                        )  
        ) as "customer"
FROM (
        SELECT  rank () over (partition by c.customerid order by ca.eventtimestamp desc ) rn
        ,       c.customerid
        ,       c.firstname
        ,       c.lastname
        ,       c.eventtimestamp customertimestamp
        ,       a.AddressID
        ,       a.Address
        ,       a.zip
        ,       a.city
        ,       a.eventtimestamp AddressTimestamp
        ,       cast (systimestamp AT TIME ZONE 'Europe/Berlin' as timestamp with time zone) as created
        FROM    customer_int.customer c
                JOIN customer_int.cust2addr ca ON ca.customerid = c.customerid
                JOIN customer_int.address a ON a.addressid = ca.addressid
        ) i
WHERE rn = 1
;        




create or replace view customer_data_dp.v_customeradresschanged as
SELECT  
        AddressChangeTimestamp as "CHG"
,       json_object('eventId' value sys_guid(), 'idempotenceId' value sys_guid(), 'created' value created) as "identity"   
,       i.customerid as "customerId"
,       json_object('addressId' value i.AddressID
                    ,       'address' value i.Address 
                    ,       'city' value i.city
                    ,       'zipCode' value i.zip 
                    ,       'lastChangeTimeStamp' value to_char(i.AddressTimestamp, 'yyyy-mm-dd"T"hh24:mi:ss.ff') 
                        )  as "address"
FROM (
        SELECT  rank () over (partition by c.customerid order by ca.eventtimestamp desc ) rn
        ,       c.customerid
        ,       c.firstname
        ,       c.lastname
        ,       c.eventtimestamp customertimestamp
        ,       a.AddressID
        ,       a.Address
        ,       a.zip
        ,       a.city
        ,       a.eventtimestamp AddressTimestamp
        ,       ca.eventtimestamp AddressChangeTimestamp
        ,       cast (systimestamp AT TIME ZONE 'Europe/Berlin' as timestamp with time zone) as created
        FROM    customer_int.customer c
                JOIN customer_int.cust2addr ca ON ca.customerid = c.customerid
                JOIN customer_int.address a ON a.addressid = ca.addressid
        ) i
order by i.AddressChangeTimestamp desc
;      

