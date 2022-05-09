-- USER SQL
CREATE USER ecomm_customer_priv IDENTIFIED BY "ecomm_customer_priv"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

ALTER USER "ecomm_customer_priv" QUOTA UNLIMITED ON "USERS";


-- ROLES
GRANT "CONNECT" TO ecomm_customer_priv;
GRANT "RESOURCE" TO ecomm_customer_priv;
ALTER USER ecomm_customer_priv DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES
---
GRANT SELECT ANY TABLE to ecomm_customer_priv;
GRANT CREATE VIEW TO ecomm_customer_priv;



create or replace view ecomm_customer_priv.v_customer (customer_id, first_name, last_name, event_timestamp, event_timestamp_epoc)
as
select "BusinessEntityID","FirstName","LastName"
,      to_timestamp(date '1970-01-01') + NUMTODSINTERVAL("EventTimestamp" / 1000, 'SECOND' )
,	   EventTimestamp
from customer.customer;

create or replace view ecomm_customer_priv.v_address (address_id, address, city, zip, event_timestamp, event_timestamp_epoc)
as 
select "AddressID",	"AddressLine1",	"City",	"PostalCode"
,      to_timestamp(date '1970-01-01') + NUMTODSINTERVAL("EventTimestamp" / 1000, 'SECOND' )
,	   EventTimestamp
from customer.address;

create or replace view ecomm_customer_priv.v_cust2addr (address_id,	customerid , event_timestamp, event_timestamp_epoc)
as 
select "BillToAddressID" ,	"businessEntityID" 
,      to_timestamp(date '1970-01-01') + NUMTODSINTERVAL("EventTimestamp" / 1000, 'SECOND' )
,	   EventTimestamp
from customer.cust2addr;


create or replace view ecomm_customer_priv.v_customer_sales
as 
select c.customerid
,      sum(nvl(amount,0)) as salesvolume
from (
    select jt.orderdate, sum (to_number(unitprice default 1 on conversion error)*nvl(quantity,0)) amount
    ,      trunc(dbms_random.value(1,19000)) customerid
    from "CUSTOMER"."CUSTOMER_ORDERS" t
    ,    json_table (message, '$'
             COLUMNS (
                  orderdate path '$.order.orderDate'
                , NESTED PATH '$.order.items[*]'
                  COLUMNS (
                          unitprice path '$.unitPrice'
                        , quantity path '$.quantity' )
                )
                ) jt 
    group by   orderdate    
    ) o
    right join v_customer c on c.customerid = o.customerid
group by c.customerid
order by 2 desc;

