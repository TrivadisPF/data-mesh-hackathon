package com.trivadis.ms.sample.salesorder.model;

import lombok.*;

import javax.persistence.*;

@Data
@Builder
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "SalesOrderDetail")
public class SalesOrderDetailDO {

    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO, generator="seq")
//    @GenericGenerator(name = "seq", strategy="increment")
    @Column(name = "salesorderid")
    private Long id;
    @Column(name = "orderqty")
    private Integer quantity;
    @Column(name = "productid")
    private Long productId;
    @Column(name = "specialofferid")
    private Long specialOfferId;
    @Column(name = "unitPrice")
    private Double unitPrice;
    @Column(name = "unitpricediscount")
    private Integer unitPriceDiscount;

    @ManyToOne(fetch = FetchType.LAZY)
    private SalesOrderDO salesOrder;
}
