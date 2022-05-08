package com.trivadis.ms.sample.salesorder.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.trivadis.ms.sample.salesorder.model.SalesOrderDO;
import com.trivadis.ms.sample.salesorder.outbox.model.OutboxEvent;

/**
 * Utility class to help the service in building event payloads.
 *
 * @author Sohan
 */
public class EventUtils {
    public static OutboxEvent createSalesOrderSubmitEvent(SalesOrderDO salesOrderDO) {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = mapper.convertValue(salesOrderDO, JsonNode.class);

        return new OutboxEvent(
                salesOrderDO.getId(),
                "ORDER_SUBMITTED",
                jsonNode
        );
    }
}
