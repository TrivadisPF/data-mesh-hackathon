package com.trivadis.ms.sample.customer.repository;

import com.trivadis.ms.sample.customer.model.CustomerDO;


/*
 * Repository Layer is responsible for retrival of data
 */
public interface CustomerRepository {

    public CustomerDO findById(Long id);

    public void save (CustomerDO customer);

}
