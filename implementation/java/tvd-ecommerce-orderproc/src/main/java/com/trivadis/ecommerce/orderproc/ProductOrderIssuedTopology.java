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

import com.trivadis.ecommerce.orderproc.avro.*;
import com.trivadis.ecommerce.ref.avro.Country;
import com.trivadis.ecommerce.ref.avro.Currency;
import com.trivadis.ecommerce.shop.avro.ShopProductOrderIssuedEvent;
import io.confluent.kafka.serializers.AbstractKafkaAvroSerDeConfig;
import io.confluent.kafka.streams.serdes.avro.SpecificAvroSerde;
import io.streamthoughts.azkarra.api.annotations.Component;
import io.streamthoughts.azkarra.api.annotations.TopologyInfo;
import io.streamthoughts.azkarra.api.config.Conf;
import io.streamthoughts.azkarra.api.config.Configurable;
import io.streamthoughts.azkarra.api.events.EventStreamSupport;
import io.streamthoughts.azkarra.api.streams.TopologyProvider;
import org.apache.avro.specific.SpecificRecord;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.Topology;
import org.apache.kafka.streams.kstream.KStream;

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

    private String schemaRegistryUrl ;

    private String topicSource;
    private String gameStartTopicSource;
    private String topicSink;
    private String stateStoreName;

    public void configure(final Conf conf) {
        topicSource = conf.getOptionalString("topic.source").orElse("public.ecommerce.shop.product-order-issued.event.v1");
        topicSink = conf.getOptionalString("topic.sink").orElse("public.ecommerce.orderproc.order-completed.event.v1");
        schemaRegistryUrl = conf.getOptionalString("streams.schema.registry.url").orElse("must-be-defined-in-conf");
    }

    @Override
    public String version() {
        return Version.getVersion();
    }


    private static OrderCompletedEvent transform(ShopProductOrderIssuedEvent input) {
        Currency currency = Currency.newBuilder().setId(1l).setIsoCode("EUR").setShortName("Euro").build();
        Country country = Country.newBuilder().setNumericCode(756).setIsoCode2("CH").setIsoCode3("CHE").setShortName("Switzerland").build();

        OrderCustomer customer = OrderCustomer.newBuilder().setId(1l).setName("Peter Muster").build();
        OrderAddress address = OrderAddress.newBuilder().setId(1l)
                .setSalutation("Mr")
                .setFirstName("Peter")
                .setLastName("Muster")
                .setCompany(null)
                .setAdditionalAddressLine1(null)
                .setAdditionalAddressLine2(null)
                .setStreet("Somestreet 1")
                .setZipcode("9999")
                .setCity("Somewhere")
                .setCountry(country).build();

        List<OrderItem> orderItems = new ArrayList<>();
        for (com.trivadis.ecommerce.shop.avro.OrderItem item : input.getItems()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setCreatedAt(Instant.now());
            orderItem.setQuantity(1);
            orderItem.setUnitPrice(item.getProduct().getPrice());
            orderItem.setProduct(OrderProduct.newBuilder().setProductId(1).setName(item.getProduct().getName()).build());
            orderItems.add(orderItem);
        }

        Order order = Order.newBuilder().setId(1l)
                            .setOrderNo("1234")
                            .setOrderDate(input.getRequestTimestamp())
                            .setOrderStatus(OrderStatus.COMPLETED)
                .setCurrency(currency)
                .setBillingAddress(address)
                .setShippingAddress(address)
                .setCustomer(customer)
                .setItems(orderItems).build();
        OrderCompletedEvent completedEvent = OrderCompletedEvent.newBuilder()
                                        .setIdentity(input.getIdentity())
                                        .setWhen(input.getRequestTimestamp())
                                        .setSessionId(input.getUniqueVisitorId())
                                        .setOrder(order).build();

        return completedEvent;
    }

    @Override
    public Topology topology() {
        final SpecificAvroSerde<ShopProductOrderIssuedEvent> shopProductOrderIssuedSerde = createSerde(schemaRegistryUrl);
        final SpecificAvroSerde<OrderCompletedEvent> orderCompletedSerde = createSerde(schemaRegistryUrl);

        final StreamsBuilder builder = new StreamsBuilder();

        final KStream<String, ShopProductOrderIssuedEvent> source = builder.stream(topicSource);
        KStream<String, OrderCompletedEvent> completedEventSource = source.mapValues(ProductOrderIssuedTopology::transform);

        completedEventSource.to(topicSink);

        return builder.build();
    }



}