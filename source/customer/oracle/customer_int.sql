-- USER SQL
CREATE USER customer_int IDENTIFIED BY "customer_int"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

ALTER USER "CUSTOMER_INT" QUOTA UNLIMITED ON "USERS";


-- ROLES
GRANT "CONNECT" TO customer_int ;
GRANT "RESOURCE" TO customer_int ;
ALTER USER customer_int DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES
---
GRANT SELECt ANY TABLE to CUSTOMER_INT;
GRANT CREATE VIEW TO customer_int;



create or replace view customer_int.v_customer (customerid, firstname, lastname, eventtimestamp)
as
select "BusinessEntityID","FirstName","LastName"
,      to_timestamp(date '1970-01-01') + NUMTODSINTERVAL("EventTimestamp" / 1000, 'SECOND' )
from customer_pub.customer;

create or replace view customer_int.v_address (AddressID, Address, City,	zip, eventtimestamp)
as 
select "AddressID",	"AddressLine1",	"City",	"PostalCode"
,      to_timestamp(date '1970-01-01') + NUMTODSINTERVAL("EventTimestamp" / 1000, 'SECOND' )
from customer_pub.address;

create or replace view customer_int.v_cust2addr (AddressID,	customerid , eventtimestamp)
as 
select "BillToAddressID" ,	"businessEntityID" 
,      to_timestamp(date '1970-01-01') + NUMTODSINTERVAL("EventTimestamp" / 1000, 'SECOND' )
from customer_pub.cust2addr;


create or replace view customer_int.v_customer_sales
as 
select c.customerid
,      sum(nvl(amount,0)) as salesvolume
from (
    select jt.orderdate, sum (to_number(unitprice default 1 on conversion error)*nvl(quantity,0)) amount
    ,      trunc(dbms_random.value(1,19000)) customerid
    from "CUSTOMER_PUB"."CUSTOMER_ORDERS" t
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

