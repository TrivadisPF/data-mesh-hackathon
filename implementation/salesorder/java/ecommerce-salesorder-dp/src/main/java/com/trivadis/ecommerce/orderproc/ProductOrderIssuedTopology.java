/*
 * Copyright 2019-2021 StreamThoughts.
 *
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements. See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.trivadis.ecommerce.orderproc;

import com.trivadis.ecommerce.customer.avro.Customer;
import com.trivadis.ecommerce.customer.avro.CustomerState;
import com.trivadis.ecommerce.ref.avro.Currency;
import com.trivadis.ecommerce.salesorder.avro.Order;
import com.trivadis.ecommerce.salesorder.avro.OrderStatus;
import com.trivadis.ecommerce.salesorder.event.avro.OrderCompletedEvent;
import com.trivadis.ecommerce.salesorder.priv.avro.*;
import io.confluent.kafka.serializers.AbstractKafkaAvroSerDeConfig;
import io.confluent.kafka.streams.serdes.avro.SpecificAvroSerde;
import io.streamthoughts.azkarra.api.annotations.Component;
import io.streamthoughts.azkarra.api.annotations.TopologyInfo;
import io.streamthoughts.azkarra.api.config.Conf;
import io.streamthoughts.azkarra.api.config.Configurable;
import io.streamthoughts.azkarra.api.events.EventStreamSupport;
import io.streamthoughts.azkarra.api.streams.TopologyProvider;
import org.apache.avro.specific.SpecificRecord;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.Topology;
import org.apache.kafka.streams.kstream.*;

import java.time.Instant;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;


@Component
@javax.inject.Named("ProductOrderIssuedTopology")
@TopologyInfo(description = "Product Orader Issued to Order Completed")
public class ProductOrderIssuedTopology extends EventStreamSupport implements TopologyProvider, Configurable {

    private static <VT extends SpecificRecord> SpecificAvroSerde<VT> createSerde(String schemaRegistryUrl) {
        SpecificAvroSerde<VT> serde = new SpecificAvroSerde<>();
        Map<String, String> serdeConfig = Collections.singletonMap(AbstractKafkaAvroSerDeConfig.SCHEMA_REGISTRY_URL_CONFIG, schemaRegistryUrl);
        serde.configure(serdeConfig, false);
        return serde;
    }

    private String schemaRegistryUrl;

    private String orderTopicSource;
    private String customerTopicSource;

    private String currencyTopicSource;

    private String gameStartTopicSource;
    private String topicSink;
    private String stateStoreName;

    public void configure(final Conf conf) {
        orderTopicSource = conf.getOptionalString("topic.source").orElse("priv.ecomm.salesorder.order-created.event.v1");
        customerTopicSource = conf.getOptionalString("customer.topic.source").orElse("pub.ecomm.customer.customer.state.v1");
        currencyTopicSource = conf.getOptionalString("currency.topic.source").orElse("pub.ecomm.ref.currency-code.state.v1");
        topicSink = conf.getOptionalString("topic.sink").orElse("pub.ecomm.orderproc.order-completed.event.v1");
        schemaRegistryUrl = conf.getOptionalString("streams.schema.registry.url").orElse("must-be-defined-in-conf");
    }

    @Override
    public String version() {
        return Version.getVersion();
    }

    private OrderStatus convert (int status) {
        OrderStatus returnValue = OrderStatus.CONFIRMED;
        return returnValue;
    }

    private Address getAddress (Customer customer, long addressId) {
        Address address = null;
        for (com.trivadis.ecommerce.customer.avro.Address adr : customer.getAddresses()) {
            if (adr.getId() == addressId) {
                Country country = Country.newBuilder()
                                .setNumericCode(adr.getCountry().getNumericCode())
                                .setIsoCode2(adr.getCountry().getIsoCode2())
                                .setIsoCode3(adr.getCountry().getIsoCode3())
                                .setShortName(adr.getCountry().getShortName())
                        .build();
                Address.newBuilder()
                        .setId(adr.getId())
                        .setSalutation(customer.getTitle())
                        .setAdditionalAddressLine1(adr.getAddressLine1())
                        .setAdditionalAddressLine2(adr.getAddressLine2())
                        .setStreet(adr.getAddressLine1())
                        .setCity(adr.getCity())
                        .setZipcode(adr.getPostalCode())
                        .setFirstName(customer.getFirstName())
                        .setLastName(customer.getLastName())
                        .setCountry(country)
                        .build();

            }
        }
        return address;
    }

    private com.trivadis.ecommerce.salesorder.priv.avro.Customer getCustomer(Customer customer) {
        return com.trivadis.ecommerce.salesorder.priv.avro.Customer.newBuilder().setId(customer.getId()).setName(customer.getFirstName() + " " + customer.getLastName()).build();
    }

    private com.trivadis.ecommerce.salesorder.priv.avro.Currency getCurrency(Currency currency) {
        return com.trivadis.ecommerce.salesorder.priv.avro.Currency.newBuilder()
                .setEntity(currency.getEntity())
                .setCurrency(currency.getCurrency())
                .setAlphabeticCode(currency.getAlphabeticCode())
                .setNumericCode(currency.getNumericCode())
                .setMinorUnit(currency.getMinorUnit())
                .setWithdrawlDate(currency.getWithdrawlDate())
                .build();
    }

    @Override
    public Topology topology() {
        final SpecificAvroSerde<SalesOrderCreatedEvent> salesOrderCreatedEventSerde = createSerde(schemaRegistryUrl);
        final SpecificAvroSerde<CustomerState> customerStateSerde = createSerde(schemaRegistryUrl);
        final SpecificAvroSerde<CustomerState> currencyStateSerde = createSerde(schemaRegistryUrl);
        final SpecificAvroSerde<OrderCompletedEvent> orderCompletedSerde = createSerde(schemaRegistryUrl);

        final StreamsBuilder builder = new StreamsBuilder();

        final KStream<String, SalesOrderCreatedEvent> source = builder.stream(orderTopicSource);
        final KTable<String, CustomerState> customerTable = builder.table(customerTopicSource);
        final GlobalKTable<String,Currency> currencyTable = builder.globalTable(currencyTopicSource);

        Joined<String, SalesOrderCreatedEvent, CustomerState> salesOrderJoinParams = Joined.with(Serdes.String(), salesOrderCreatedEventSerde, customerStateSerde);
        ValueJoiner<SalesOrderCreatedEvent, CustomerState, SalesOrderJoinedWithCustomerAndCurrency> salesOrderCustomerJoiner = (salesOrderCreatedEvent, customerState) ->  SalesOrderJoinedWithCustomerAndCurrency.newBuilder()
                .setSalesOrder(salesOrderCreatedEvent.getSalesOrder())
                .setCustomer(getCustomer(customerState.getCustomer()))
                .setDeliveryAddress(getAddress(customerState.getCustomer(), salesOrderCreatedEvent.getSalesOrder().getBillToAddressId()))
                .setShippingAddress(getAddress(customerState.getCustomer(), salesOrderCreatedEvent.getSalesOrder().getBillToAddressId())).build();

        ValueJoiner<SalesOrderJoinedWithCustomerAndCurrency, Currency, SalesOrderJoinedWithCustomerAndCurrency> salesOrderCurrencyJoiner = (orderJoined, currency) -> SalesOrderJoinedWithCustomerAndCurrency.newBuilder(orderJoined)
                .setCurrency(getCurrency(currency))
                .build();
        KStream<String, SalesOrderJoinedWithCustomerAndCurrency> salesOrderWithCustomer = source.join(customerTable,
                                                        salesOrderCustomerJoiner,
                                                        salesOrderJoinParams);
        KStream<String, SalesOrderJoinedWithCustomerAndCurrency> salesOrderWithCustomerAndRef = salesOrderWithCustomer.leftJoin(currencyTable,
                                                        (k, salesOrderValue) -> String.valueOf(salesOrderValue.getSalesOrder().getCurrencyRateId()),
                                                        salesOrderCurrencyJoiner);

        salesOrderWithCustomerAndRef.to(topicSink);

        return builder.build();
    }


}