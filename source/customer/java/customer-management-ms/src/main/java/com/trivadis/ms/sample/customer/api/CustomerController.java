package com.trivadis.ms.sample.customer.api;

import com.google.common.base.Preconditions;
import com.trivadis.ms.sample.customer.model.CustomerDO;
import com.trivadis.ms.sample.customer.repository.CustomerRepository;
import com.trivadis.ms.sample.customer.service.CustomerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;

@RestController()
public class CustomerController {

    private static final Logger LOGGER = LoggerFactory.getLogger(CustomerController.class);

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CustomerService customerService;
    
    private void createCustomer(com.trivadis.ms.sample.customer.api.CustomerApi customerApi) throws ParseException {
        CustomerDO customerDO = com.trivadis.ms.sample.customer.api.CustomerConverter.convert(customerApi);
        customerService.createCustomer(customerDO);
        LOGGER.info("Customer created: " + customerDO);
    }
    
    private void modifyCustomer(com.trivadis.ms.sample.customer.api.CustomerApi customerApi) throws ParseException {
        CustomerDO customerDO = com.trivadis.ms.sample.customer.api.CustomerConverter.convert(customerApi);
        customerService.modifyCustomer(customerDO);
        LOGGER.info("Customer created: " + customerDO);
    }

    @RequestMapping(value= "/api/customers",
            method = RequestMethod.POST,
            consumes = "application/json") 
    @Transactional
    public void postCustomer(@RequestBody com.trivadis.ms.sample.customer.api.CustomerApi customerApi) throws ParseException {
        Preconditions.checkNotNull(customerApi);
        
        createCustomer(customerApi);
    }
    
    @RequestMapping(value= "/api/customer",
            method = RequestMethod.PUT,
            consumes = "application/json") 
    @Transactional
    public void putCustomer(@RequestBody com.trivadis.ms.sample.customer.api.CustomerApi customerApi) throws ParseException {
        Preconditions.checkNotNull(customerApi);
        Preconditions.checkNotNull(customerApi.getBusinessEntityId());
        
        modifyCustomer(customerApi);
    }

    @RequestMapping(
            method = RequestMethod.GET,
            value= "/api/customer/{id}"
    )
    //@CrossOrigin(origins = "http://localhost:4200")
    public com.trivadis.ms.sample.customer.api.CustomerApi getCustomer(@PathVariable(value="id") Long id)  {
        com.trivadis.ms.sample.customer.api.CustomerApi customer = com.trivadis.ms.sample.customer.api.CustomerApi.builder().build();
        CustomerDO customerDO = null;

        if (id != null) {
            customerDO = customerRepository.findById(id);
        }
        
        if(customerDO != null) {
            customer = com.trivadis.ms.sample.customer.api.CustomerConverter.convert(customerDO);
        }
        return customer;
    }

    
}