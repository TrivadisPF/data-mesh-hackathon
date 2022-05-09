CONNECT ecomm_customer_priv/abc123!@//localhost/XEPDB1


CREATE OR REPLACE VIEW person_v
AS
SELECT *
FROM ecomm_customer.person_t;

CREATE OR REPLACE VIEW person_address_v
AS
SELECT *
FROM ecomm_customer.person_address_t;

CREATE OR REPLACE VIEW address_v
AS
SELECT *
FROM ecomm_customer.address_t;

CREATE OR REPLACE VIEW person_phone_v
AS
SELECT *
FROM ecomm_customer.person_phone_t;

CREATE OR REPLACE VIEW email_address_v
AS
SELECT *
FROM ecomm_customer.email_address_t;


GRANT SELECT ON person_v TO ecomm_customer_pub_v1;
GRANT SELECT ON person_address_v TO ecomm_customer_pub_v1;
GRANT SELECT ON address_v TO ecomm_customer_pub_v1;
GRANT SELECT ON person_phone_v TO ecomm_customer_pub_v1;
GRANT SELECT ON email_address_v TO ecomm_customer_pub_v1;


CREATE OR REPLACE VIEW ecomm_customer_priv.customer_sales_v
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

