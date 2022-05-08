package com.trivadis.ms.sample.salesorder.model;

import lombok.*;

import javax.persistence.*;
import java.time.Instant;
import java.util.List;

/**
 * Entity that maps the SalesOrderHeader table.
 */
@Data
@Builder
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "SalesOrderHeader")
public class SalesOrderDO {

    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO, generator="seq")
//    @GenericGenerator(name = "seq", strategy="increment")
    @Column(name = "salesorderid")
    private Long id;

    @Column(name = "shipMethodId")
    private Long shipMethodId;
    @Column(name = "revisonNumber")
    private Integer revisonNumber;
    @Column(name = "orderDate")
    private Instant orderDate;
    @Column(name = "dueDate")
    private Instant dueDate;
    @Column(name = "shipDate")
    private Instant shipDate;
    @Column(name = "status")
    private Integer status;
    @Column(name = "onlinechannel")
    private Boolean onlineChannel;
    @Column(name = "purchaseOrderNumber")
    private String purchaseOrderNumber;
    @Column(name = "customerid")
    private Long customerId;
    @Column(name = "salespersonid")
    private Long salesPersonId;
    @Column(name = "accountNumber")
    private String accountNumber;
    @Column(name = "territoryId")
    private Long territoryId;
    @Column(name = "billToAddressId")
    private Long billToAddressId;
    @Column(name = "shipToAddressId")
    private Long shipToAddressId;
    @Column(name = "currencyRateId")
    private Long currencyRateId;
    @Column(name = "subTotal")
    private Double subTotal;
    @Column(name = "taxAmount")
    private Double taxAmount;
    @Column(name = "freight")
    private Double freight;
    @Column(name = "totalDue")
    private Double totalDue;
    @Column(name = "comment")
    private String comment;

    @OneToMany(mappedBy = "salesOrder", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<SalesOrderDetailDO> salesOrderDetails;

    @ManyToOne(optional = false)
    private CreditCardDO creditCard;

}
