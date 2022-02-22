# Governance

## Supporting Tools

The tools supporting Data Governance are:

  * [Data Hub](./tech/DataHub.md) - the data catalog to be used for data governance
  * Confluent Schema Registry - holds the Avro Schemas to be used at runtime
  * [Apache Avro](./tech/ApacheAvro.md) - the Avro schema language for defining the data contracts

## Avro Schema Naming Conventions

We will use the IDL language to define the Avro schemas. For the records we use Upper Camel Case wheras for the properties we use Lower Camel Case.

* **Namespace**: `com.trivadis.<domain>.<subdomain | bounded-context>.avro`
* **Protocol**: `<object>.<Event | State>Protocol`

## Database Naming Conventions

We want to clearly separate the private from the public objects which are the data products and are part of the public interface. Because they form a contract, which has to be guaranteed over the lifecycle of the data product, this distinction is very imporant. Therefore you should use different schemas for the public and for the private objects. 

### Schema names

There should be at least one schema with the private parts, it can be shared with the operational database schema or it can be a separate one, using the follwoing naming convention

`<domain>_<subdomain | bounded-context>_priv`

For each Data Product and major version, there should be a separate schema, holding all the published objects for the given data product version, using the follwing naming comvention:

`<domain>_<subdomain | bounded-context>_<data-product-name>_priv`

For both the `<domain>` and the `<subdomain | bounded-context>` an abbreviation can optionally be used.

## Apache Kafka Naming Conventions

### Topic names

Kafka topic names should bear the name of the data. But what is the name of the data contained in the topic? 

Domain Driven Design (DDD) allows for different sub-domains, i.e. bounded context 

Readers who have already experienced the attempt to create a uniform, company-wide data model (there are many legends about it!) know the problem: not only that there can be distinctions between technical and business names. Also between different departments, one and the same data set can have a completely different name (“ubiquitous language”). Therefore, data ownership must be clarified at this point: who is the data producer or who owns the data? And in terms of domain-driven design (DDD): in which domain is the data located?

The topics should be named using the following conventions

`[public|private].<domain>.<subdomain | bounded-context>.<data>.[event|state].v<version-number>`

`public.ecommerce.shop.page-navigated.event.v1`
`public.ecommerce.orderproc.order-completed.event.v1`
`public.ecommerce.orderproc.order.state.v1`


To enforce topic naming rules, be sure to set the `auto.create.topics.enable` setting for your Apache Kafka broker to `false. This means that topics can only be created manually, which from an organizational point of view requires an application process.

### Consumer Groups

`<domain>.<subdomain | bounded-context>.<taskname>-cg`
