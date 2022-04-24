package com.trivadis.ms.sample.customer.service;

import com.trivadis.ms.sample.customer.model.CustomerDO;
import com.trivadis.ms.sample.customer.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class CustomerServiceImpl implements CustomerService {
	
	@Autowired
	private CustomerRepository customerRepository;

	public List<CustomerDO> findAll() {
		return null;
//		return customerRepository.findAll();
	}
	
	public CustomerDO findById(Long id) {
		return customerRepository.findById(id);
	}

		
	@Override
	public void createCustomer(CustomerDO customer) {
		/*
		 * Persist customer 
		 */
		//customer.setId(UUID.randomUUID());
		//customerRepository.save(customer);
		customerRepository.save(customer);
	}
	
	@Override
	public void modifyCustomer(CustomerDO customer) {
		/*
		 * Persist customer 
		 */
		// customerRepository.save(customer);

	}
	
	@Override
	public void removeCustomer(CustomerDO customer) {
		/*
		 * Persist customer 
		 */
		//customerRepository.remove(customer);

	}
	
	 
}
