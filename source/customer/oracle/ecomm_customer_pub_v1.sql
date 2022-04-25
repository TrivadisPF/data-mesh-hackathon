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

CREATE OR REPLACE VIEW v_customerstate as
SELECT  JSON_OBJECT ('eventId' value sys_guid(), 'idempotenceId' value sys_guid(), 'created' value created_date) as "identity"  
	, JSON_OBJECT ('customerId' VALUE per.business_entity_id
                            , 'personType' VALUE per.person_type
                            , 'nameStyle' VALUE per.name_style
                            , 'firstName' VALUE per.first_name
                            , 'lastName' VALUE per.last_name
                            , 'emailPromotion' VALUE per.email_promotion
                            , 'adresses' VALUE (
                                        SELECT
                                            JSON_ARRAYAGG(
                                                JSON_OBJECT('addressTypeId' VALUE peradr.address_type_id
                                                ,   'addressId' VALUE adr.address_id
                                                ,   'addressLine1' VALUE adr.address_line_1
                                                ,   'addressLine2' VALUE adr.address_line_2
                                                ,   'city' VALUE adr.city
                                                ,   'stateProvinceId' VALUE adr.state_province_id
                                                ,   'postalCode' VALUE adr.postal_code
                                                )
                                            )
                                        FROM person_address_t peradr
                                        LEFT JOIN address_t   adr 
                                            ON ( peradr.address_id = adr.address_id )
                                        WHERE per.business_entity_id = peradr.business_entity_id
                                    )
                            , 'phones' VALUE (
                                        SELECT
                                            JSON_ARRAYAGG(
                                                JSON_OBJECT('phoneNumber' VALUE perp.phone_number
                                                ,   'phoneNumberTypeId' VALUE perp.phone_number_type_id
                                                )
                                            )
                                        FROM person_phone_t perp
                                        WHERE per.business_entity_id = perp.business_entity_id
                                    )
                            , 'emailAddresses' VALUE (
                                        SELECT
                                            JSON_ARRAYAGG(
                                                JSON_OBJECT('emailAddressId' VALUE ema.email_address_id
                                                ,   'emailAddress' VALUE ema.email_address
                                                )
                                            )
                                        FROM email_address_t ema
                                        WHERE per.business_entity_id = ema.business_entity_id
                                    )
                    ) AS "customer"
                    , created_date  AS "last_change"
                    , ROUND((cast(sys_extract_utc(per.modified_date) as date) - TO_DATE('1970-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS')) * 86400 * 1000) AS "last_change_ms"
FROM person.person_t per;

        
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

