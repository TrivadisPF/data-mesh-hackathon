package com.trivadis.ms.sample.customer.api;

import com.trivadis.ms.sample.customer.model.AddressDO;
import com.trivadis.ms.sample.customer.model.CustomerDO;

import java.util.ArrayList;

public class CustomerConverter {
	
	public static com.trivadis.ms.sample.customer.api.CustomerApi convert (CustomerDO customer) {

		com.trivadis.ms.sample.customer.api.CustomerApi value = com.trivadis.ms.sample.customer.api.CustomerApi.builder()
				.businessEntityId(customer.getBusinessEntityId())
				.personType(customer.getPersonType())
				.nameStyle(customer.getNameStyle())
				.title(customer.getTitle())
				.firstName(customer.getFirstName())
				.middleName(customer.getMiddleName())
				.lastName(customer.getLastName())
				.suffix(customer.getSuffix())
				.emailPromotion(customer.getEmailPromotion())
				.addresses(new ArrayList<>())
				.build();

		com.trivadis.ms.sample.customer.api.AddressApi valueAddress;
		if (customer.getAddresses() != null) {
			for (AddressDO address : customer.getAddresses()) {
				valueAddress = AddressApi.builder()
						.addressId(address.getAddressId())
						.addressLine1(address.getAddressLine1())
						.addressLine2(address.getAddressLine2())
						.city(address.getCity())
						.stateProvinceId(address.getStateProvinceId())
						.postalCode(address.getPostalcode())
						.build();

				value.getAddresses().add(valueAddress);
			}
		}
		
		return value;
	}
	
	public static CustomerDO convert (com.trivadis.ms.sample.customer.api.CustomerApi customer) {
		CustomerDO value = CustomerDO.builder()
				.businessEntityId(customer.getBusinessEntityId())
				.personType(customer.getPersonType())
				.nameStyle(customer.getNameStyle())
				.title(customer.getTitle())
				.firstName(customer.getFirstName())
				.middleName(customer.getMiddleName())
				.lastName(customer.getLastName())
				.suffix(customer.getSuffix())
				.emailPromotion(customer.getEmailPromotion())
				.addresses(new ArrayList<>())
				.build();

		AddressDO valueAddress;
		if (customer.getAddresses() != null) { 
			for (com.trivadis.ms.sample.customer.api.AddressApi address : customer.getAddresses()) {
				valueAddress = AddressDO.builder()
						.addressId(address.getAddressId())
						.addressLine1(address.getAddressLine1())
						.addressLine2(address.getAddressLine2())
						.city(address.getCity())
						.stateProvinceId(address.getStateProvinceId())
						.postalcode(address.getPostalCode())
						.build();

				value.getAddresses().add(valueAddress);
			}
		}
		
		return value;
	}
	
}
