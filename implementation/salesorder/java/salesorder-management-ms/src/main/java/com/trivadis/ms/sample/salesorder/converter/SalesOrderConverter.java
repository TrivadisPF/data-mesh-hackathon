package com.trivadis.ms.sample.salesorder.converter;

import com.trivadis.ms.sample.salesorder.api.SalesOrderDetailApi;
import com.trivadis.ms.sample.salesorder.api.SalesOrderApi;
import com.trivadis.ms.sample.salesorder.api.CreditCardApi;
import com.trivadis.ms.sample.salesorder.model.SalesOrderDetailDO;
import com.trivadis.ms.sample.salesorder.model.SalesOrderDO;
import com.trivadis.ms.sample.salesorder.model.CreditCardDO;

import java.util.ArrayList;

public class SalesOrderConverter {
	
	public static SalesOrderApi convert (SalesOrderDO salesOrder) {

		SalesOrderApi value = SalesOrderApi.builder()
				.id(salesOrder.getId())
				.shipMethodId(salesOrder.getShipMethodId())
				.revisonNumber(salesOrder.getRevisonNumber())
				.onlineChannel(salesOrder.getOnlineChannel())
				.purchaseOrderNumber(salesOrder.getPurchaseOrderNumber())
				.accountNumber(salesOrder.getAccountNumber())
				.customerId(salesOrder.getCustomerId())
				.salesPersonId(salesOrder.getSalesPersonId())
				.territoryId(salesOrder.getTerritoryId())
				.billToAddressId(salesOrder.getBillToAddressId())
				.shipToAddressId(salesOrder.getShipToAddressId())
				.currencyRateId(salesOrder.getCurrencyRateId())
				.subTotal(salesOrder.getSubTotal())
				.taxAmount(salesOrder.getTaxAmount())
				.freight(salesOrder.getFreight())
				.totalDue(salesOrder.getTotalDue())
				.comment(salesOrder.getComment())
				.salesOrderDetails(new ArrayList<>())
				.creditCard(
						CreditCardApi.builder()
								.id(salesOrder.getCreditCard().getId())
								.cardType(salesOrder.getCreditCard().getCardType())
								.cardNumber(salesOrder.getCreditCard().getCardNumber())
								.expMonth(salesOrder.getCreditCard().getExpMonth())
								.expYear(salesOrder.getCreditCard().getExpYear())
								.creditCardApprovalCode(salesOrder.getCreditCard().getCreditCardApprovalCode())
								.build()
				)
				.build();

		SalesOrderDetailApi valueSalesOrderDetail;
		if (salesOrder.getSalesOrderDetails() != null) {
			for (SalesOrderDetailDO salesOrderDetail : salesOrder.getSalesOrderDetails()) {
				valueSalesOrderDetail = SalesOrderDetailApi.builder()
						.id(salesOrderDetail.getId())
						.quantity(salesOrderDetail.getQuantity())
						.productId(salesOrderDetail.getProductId())
						.specialOfferId(salesOrderDetail.getSpecialOfferId())
						.unitPrice(salesOrderDetail.getUnitPrice())
						.unitPriceDiscount(salesOrderDetail.getUnitPriceDiscount())
						.build();

				value.getSalesOrderDetails().add(valueSalesOrderDetail);
			}
		}

		return value;
	}
	
	public static SalesOrderDO convert (SalesOrderApi salesOrder) {
		SalesOrderDO value = SalesOrderDO.builder()
				.id(salesOrder.getId())
				.shipMethodId(salesOrder.getShipMethodId())
				.revisonNumber(salesOrder.getRevisonNumber())
				.onlineChannel(salesOrder.getOnlineChannel())
				.purchaseOrderNumber(salesOrder.getPurchaseOrderNumber())
				.accountNumber(salesOrder.getAccountNumber())
				.customerId(salesOrder.getCustomerId())
				.salesPersonId(salesOrder.getSalesPersonId())
				.territoryId(salesOrder.getTerritoryId())
				.billToAddressId(salesOrder.getBillToAddressId())
				.shipToAddressId(salesOrder.getShipToAddressId())
				.currencyRateId(salesOrder.getCurrencyRateId())
				.subTotal(salesOrder.getSubTotal())
				.taxAmount(salesOrder.getTaxAmount())
				.freight(salesOrder.getFreight())
				.totalDue(salesOrder.getTotalDue())
				.comment(salesOrder.getComment())
				.creditCard(CreditCardDO.builder()
						.id(salesOrder.getCreditCard().getId())
						.cardType(salesOrder.getCreditCard().getCardType())
						.cardNumber(salesOrder.getCreditCard().getCardNumber())
						.expMonth(salesOrder.getCreditCard().getExpMonth())
						.expYear(salesOrder.getCreditCard().getExpYear())
						.creditCardApprovalCode(salesOrder.getCreditCard().getCreditCardApprovalCode())
						.build())
				.salesOrderDetails(new ArrayList<>())
				.build();

		SalesOrderDetailDO valueSalesOrderDetail;
		if (salesOrder.getSalesOrderDetails() != null) {
			for (SalesOrderDetailApi salesOrderDetail : salesOrder.getSalesOrderDetails()) {
				valueSalesOrderDetail = SalesOrderDetailDO.builder()
						.id(salesOrderDetail.getId())
						.quantity(salesOrderDetail.getQuantity())
						.productId(salesOrderDetail.getProductId())
						.specialOfferId(salesOrderDetail.getSpecialOfferId())
						.unitPrice(salesOrderDetail.getUnitPrice())
						.unitPriceDiscount(salesOrderDetail.getUnitPriceDiscount())
						.build();

				value.getSalesOrderDetails().add(valueSalesOrderDetail);
			}
		}

		return value;
	}
	
}
