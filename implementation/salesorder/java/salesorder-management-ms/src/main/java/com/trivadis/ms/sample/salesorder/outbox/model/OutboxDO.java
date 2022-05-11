package com.trivadis.ms.sample.salesorder.outbox.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.Instant;
import java.util.UUID;

/**
 * Entity that maps the Eventing OUTBOX table.
 *
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "outbox")
public class OutboxDO {

    @Id
    @Column(name = "id")
    private UUID id;

    @Column(name = "aggregate_id")
    private Long aggregateId;

    @Column(name = "event_type")
    private String eventType;

    @Column(name = "payload", length = 4000)
    private String payload;

    @Column(name = "createdAt")
    private Instant createdAt;
}
