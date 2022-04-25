package com.trivadis.ms.sample.customer.model;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class EmailAddressDO {

    private Long id;
    private String emailAddress;
}
