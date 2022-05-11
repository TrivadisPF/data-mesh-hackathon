package com.trivadis.ms.sample.salesorder.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.trivadis.ecommerce.salesorder.priv.avro.SalesOrder;
import com.trivadis.ms.sample.salesorder.model.SalesOrderDO;
import com.trivadis.ms.sample.salesorder.outbox.model.OutboxEvent;
import io.confluent.kafka.schemaregistry.client.CachedSchemaRegistryClient;
import io.confluent.kafka.schemaregistry.client.SchemaRegistryClient;
import io.confluent.kafka.serializers.KafkaAvroSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Utility class to help the service in building event payloads.
 *
 * @author Sohan
 */
@Component
public class EventUtils {

    @Value("${spring.kafka.properties.schema.registry.url}")
    private String schemaRegistryUrl;

    @Value("${outbox.serialization.type}")
    private String serializationType;

    private OutboxEvent createSalesOrderSubmitEventJson(SalesOrderDO salesOrderDO) {
        ObjectMapper mapper = JsonMapper.builder()
                .findAndAddModules()
                .build();
        JsonNode jsonNode = mapper.convertValue(salesOrderDO, JsonNode.class);

        return new OutboxEvent(
                salesOrderDO.getId(),
                "order-accepted",
                jsonNode,
                null
        );
    }

    private OutboxEvent createSalesOrderSubmitEventAvro(SalesOrderDO salesOrderDO) {

        SchemaRegistryClient schemaRegistryClient = new CachedSchemaRegistryClient(schemaRegistryUrl, 10);
        KafkaAvroSerializer ser = new KafkaAvroSerializer(schemaRegistryClient);

        SalesOrder salesOrder = null;

        return new OutboxEvent(
                salesOrderDO.getId(),
                "order-accepted",
                null,
                ser.serialize("priv.ecomm.salesorder.order-accepted.event.v1", salesOrder)
        );
    }

    public OutboxEvent createSalesOrderSubmitEvent(SalesOrderDO salesOrderDO) {
        OutboxEvent outboxEvent = null;
        if (serializationType.equalsIgnoreCase("json")) {
            outboxEvent = createSalesOrderSubmitEventJson(salesOrderDO);
        } else {
            outboxEvent = createSalesOrderSubmitEventAvro(salesOrderDO);
        }
        return outboxEvent;
    }

}
