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

CREATE OR REPLACE VIEW phone_number_type_v
AS
SELECT *
FROM ecomm_customer.phone_number_type_t;

CREATE OR REPLACE VIEW state_province_v
AS
SELECT *
FROM ecomm_customer.state_province_t;


GRANT SELECT ON person_v TO ecomm_customer_pub_v1;
GRANT SELECT ON person_address_v TO ecomm_customer_pub_v1;
GRANT SELECT ON address_v TO ecomm_customer_pub_v1;
GRANT SELECT ON person_phone_v TO ecomm_customer_pub_v1;
GRANT SELECT ON email_address_v TO ecomm_customer_pub_v1;
GRANT SELECT ON phone_number_type_v TO ecomm_customer_pub_v1;
GRANT SELECT ON state_province_v TO ecomm_customer_pub_v1;



