# Concepts to show

  * Redis Materialized View with bootstrap from Kafka Compacted Log Topic
    * use it for `currency-rates`?
    * use it for `stock-values`? 
  * Streaming ETL with later move persistent zone
 
  * Business Event
    * used in `customer` domain for `adress-changed` event 
  * State Change Event
    * used in `customer` domain for `customer` product 
  * Materialized View with Materialize with option to Query
  * Keep Materialized Copy of a Kafka based Data Product from another domain
    * use it in `sales-order` domain to copy data from `customer` domain
    * keep Billing and Shipping Address as concatenated object (address) in a key/value store 
  * use polling-based CDC with StreamSets
    * used in `customer` domain to get changes on `person` & `address` table

  * use log-based CDC with Debezium from Oracle/PosgreSQL from legacy system
    * use it in `product` domain? 
  * CDC Events to Aggregate
    * use it in `product` domain? 
  * use logged-based CDC with Outbox Table Pattern
    * use it when submitting order in `sales-order` domain
    * on Postgresql

  * History tables
    * SCD2 
  * Version Data with lakeFS
  * Real-Time Data Marts with Pinot

  * Integrating External Systems
    * integrate [Exchange Rates API](https://exchangeratesapi.io/)