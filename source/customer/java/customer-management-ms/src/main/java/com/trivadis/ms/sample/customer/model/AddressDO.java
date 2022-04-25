package com.trivadis.ms.sample.customer.model;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AddressDO {

    private Long addressId;
    private String addressLine1;
    private String addressLine2;

    private String city;
    private Long stateProvinceId;

    private String postalcode;

}
