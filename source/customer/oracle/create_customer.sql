

-- USER SQL
CREATE USER customer IDENTIFIED BY "customer"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

ALTER USER "CUSTOMER" QUOTA UNLIMITED ON "USERS";


-- ROLES
GRANT "CONNECT" TO customer;
GRANT "RESOURCE" TO customer;
ALTER USER customer DEFAULT ROLE "CONNECT","RESOURCE";


drop table CUSTOMER;

create table CUSTOMER (
	"BusinessEntityID"    INTEGER     PRIMARY KEY,
    "FirstName"           VARCHAR(100),
    "LastName"            VARCHAR(100),
    "EventTimestamp"      NUMBER(38));
    
drop table ADDRESS;

create table ADDRESS (
    "AddressID"         INTEGER     PRIMARY KEY,
    "AddressLine1"      VARCHAR(200),
    "City"              VARCHAR(200),
    "PostalCode"        VARCHAR(50),
    "EventTimestamp"    NUMBER(38));
   
drop table CUST2ADDR;

create table CUST2ADDR (
    "BillToAddressID"   INTEGER,
    "businessEntityID"  INTEGER,
    "EventTimestamp"    NUMBER(38),
    CONSTRAINT CUST2ADDR_PK PRIMARY KEY ("BillToAddressID", "businessEntityID"));


DROP TABLE CUSTOMER_ORDERS;

CREATE TABLE CUSTOMER_ORDERS
(load_tstp timestamp default systimestamp 
, message clob
);