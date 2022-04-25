package com.trivadis.ms.sample.customer.repository;

import com.trivadis.ms.sample.customer.model.CustomerDO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class CustomerRepositoryImpl implements CustomerRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public CustomerDO findById(Long id) {
        Map<String,Object> result = jdbcTemplate.queryForMap("select * from person.person where businessentityid = ?", id);

        CustomerDO customer = CustomerDO.builder()
                .businessEntityId(((Integer) result.get("businessentityid")).longValue())
                .personType((String)result.get("personType"))
                .nameStyle((Boolean)result.get("nameStyle"))
                .title((String)result.get("title"))
                .firstName((String)result.get("firstname"))
                .middleName((String)result.get("middlename"))
                .lastName((String)result.get("lastname"))
                .suffix((String)result.get("suffix"))
                .emailPromotion((Integer)result.get("emailPromotion"))
                .addresses(new ArrayList<>())
                .build();

        List<Map<String,Object>> addresses = jdbcTemplate.queryForList(
                "select * from person.address adr JOIN person.businessentityaddress ba ON (ba.addressid = adr.addressid) where ba.businessentityid = ?", id);

        System.out.println(addresses);

        return customer;
    }

    public void save (CustomerDO customer) {
        System.out.println(customer);

    }
}
