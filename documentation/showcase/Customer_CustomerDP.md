# Customer Subdomain - Customer Data Product

## Canvas

![Order Processing](./../images/customer-dp.png)



## Implementation

![](../images/customer-dp-impl.png)

## Simulation

The following StreamSets Pipelines are simulating the data

 * **customer_init** - Initializes the static datasets
 * **customer_simulate-person-and-address** - simulate Person and Address inserts and updates

## Rest API

The RESTAPI is deployed on <http://dataplatform:8081>

A `POST` on `/api/customers` with a JSON document similar to the one below will add a new Person with addresses, emails and phones:

```json
{
  "businessEntityId" : 20036,
  "personType" : "IN",
  "nameStyle" : false,
  "firstName" : "Destiny",
  "lastName" : "Ward",
  "emailPromotion" : 1,
  "addresses" : [ {
    "id" : 29138,
    "addressTypeId": 1,
    "addressLine1" : "3935 Hawkins Street",
    "city" : "Langford",
    "stateProvinceId" : 7,
    "postalCode" : "V9"
  } ],
  "emailAddresses" : [ {
    "id" : 19231,
    "emailAddress" : "destiny38@adventure-works.com"
  } ],
  "phones" : [ {
    "phoneNumber" : "141-555-0193",
    "phoneNumberTypeId" : 1
  } ]
}
```


## Data Model

The internal Data Model for the Customer operational systems

![](../images/customer-dbmodel-priv.png)