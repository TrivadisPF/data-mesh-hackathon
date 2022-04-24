package com.trivadis.ms.sample.customer.service;

import com.trivadis.ms.sample.customer.model.CustomerDO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/*
 * Service Layer should be used for Transactional processes
 * 
 * Calls Repository Layers
 * 
 */
@Service
public interface CustomerService {

    public List<CustomerDO> findAll();
    public CustomerDO findById(Long id);

    public void createCustomer(CustomerDO product);
    public void modifyCustomer(CustomerDO product);
    public void removeCustomer(CustomerDO product);
}
