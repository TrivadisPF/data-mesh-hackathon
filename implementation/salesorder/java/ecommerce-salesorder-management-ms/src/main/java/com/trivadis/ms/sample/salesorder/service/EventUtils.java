package com.trivadis.ms.sample.salesorder.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.trivadis.ecommerce.salesorder.priv.avro.SalesOrder;
import com.trivadis.ecommerce.salesorder.priv.avro.SalesOrderAcceptedEvent;
import com.trivadis.ms.sample.salesorder.converter.SalesOrderConverter;
import com.trivadis.ms.sample.salesorder.model.SalesOrderDO;
import com.trivadis.ms.sample.salesorder.outbox.model.OutboxEvent;
import io.confluent.kafka.schemaregistry.client.CachedSchemaRegistryClient;
import io.confluent.kafka.schemaregistry.client.SchemaRegistryClient;
import io.confluent.kafka.serializers.KafkaAvroSerializer;
import io.confluent.kafka.serializers.KafkaAvroSerializerConfig;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

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
        Map<String, Object> props = new HashMap<>();
        // send correct schemas to the registry, without "avro.java.string"
        props.put(KafkaAvroSerializerConfig.AVRO_REMOVE_JAVA_PROPS_CONFIG, true);
        props.put("schema.registry.url", schemaRegistryUrl);
        KafkaAvroSerializer ser = new KafkaAvroSerializer(schemaRegistryClient, props);

        SalesOrder salesOrder = SalesOrderConverter.convertToAvro(salesOrderDO);
        SalesOrderAcceptedEvent salesOrderAcceptedEvent = SalesOrderAcceptedEvent.newBuilder().setSalesOrder(salesOrder).build();

        return new OutboxEvent(
                salesOrderDO.getId(),
                "order-accepted",
                null,
                ser.serialize("priv.ecomm.salesorder.order-accepted.event.v1", salesOrderAcceptedEvent)
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
