-- ----------------------------------------------
-- User ecom_customer (legacy schema)
-- ----------------------------------------------

CREATE USER ecomm_customer IDENTIFIED BY "abc123!"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

ALTER USER ecomm_customer QUOTA UNLIMITED ON "USERS";


-- ROLES
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE SYNONYM TO ecomm_customer;


-- ----------------------------------------------
-- User ecom_customer
-- ----------------------------------------------

CREATE USER ecomm_customer_priv IDENTIFIED BY "abc123!"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

ALTER USER ecomm_customer_priv QUOTA UNLIMITED ON "USERS";


-- ROLES
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE SYNONYM TO ecomm_customer_priv;


-- ----------------------------------------------
-- User ecom_customer_pub_v1
-- ----------------------------------------------

CREATE USER ecomm_customer_pub_v1 IDENTIFIED BY "abc123!"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

ALTER USER ecomm_customer_pub_v1 QUOTA UNLIMITED ON "USERS";

GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE SYNONYM TO ecomm_customer_pub_v1;

    
    