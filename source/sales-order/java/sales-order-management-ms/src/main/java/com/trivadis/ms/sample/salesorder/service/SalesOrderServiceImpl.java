package com.trivadis.ms.sample.salesorder.service;

import com.trivadis.ms.sample.salesorder.model.SalesOrderDO;
import com.trivadis.ms.sample.salesorder.outbox.EventPublisher;
import com.trivadis.ms.sample.salesorder.repository.CreditCardRepository;
import com.trivadis.ms.sample.salesorder.repository.SalesOrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
public class SalesOrderServiceImpl implements SalesOrderService {

	@Autowired
	private SalesOrderRepository salesOrderRepository;
	@Autowired
	private CreditCardRepository creditCardRepository;
	/**
	 * Handle to the Outbox Eventing framework.
	 */
	@Autowired
	private EventPublisher eventPublisher;

	@Override
	@Transactional
	public void submitNewOrder(SalesOrderDO salesOrder) {

		if (!creditCardRepository.existsById(salesOrder.getCreditCard().getId())) {
			creditCardRepository.save(salesOrder.getCreditCard());
		}

		/*
		 * Persist person
		 */
		salesOrderRepository.save(salesOrder);

		//Publish the event
		eventPublisher.fire(EventUtils.createSalesOrderSubmitEvent(salesOrder));

	}

	 
}
