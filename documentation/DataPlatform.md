# Data Platform

A data platform with the follwoing components is avilable:



## List of Topics

Sub-Domain  | Topic Name | Retention | Avro Schema |
------------- | -------------| -------------| -------------
Shop  | `public.ecommerce.shop.shop-visited.state.v1` |  compacted-log | `ShopVisitedState.avsc`
Shop  | `public.ecommerce.shop.shop-user.state.v1` |  compacted-log | `ShopUserState.avsc`
Shop  | `public.ecommerce.shop.search-performed.event.v1` |  time | `ShopSearchPerformedEvent.avsc`
Shop  | `public.ecommerce.shop.user-logged-in.event.v1` |  time | `ShopUserLoggedInEvent.avsc`
Shop  | `public.ecommerce.shop.page-navigated.event.v1` |  time | `ShopPageNavigatedEvent.avsc`
Shop  | `public.ecommerce.shop.cart-action-occurred.event.v1` |  time | `ShopCartActionOccurredEvent.avsc`
Shop  | `public.ecommerce.shop.product-order-issued.event.v1` |  time | `ShopProductOrderIssuedEvent.avsc`
Order Processing  | `public.ecommerce.orderproc.order-confirmed.event.v1` |  time | `OrderConfirmedEvent.avsc`
Order Cancelled  | `public.ecommerce.orderproc.order-cancelled.event.v1` |  time | `OrderCancelledEvent.avsc`
Order Processing  | `public.ecommerce.orderproc.order-completed.event.v1` |  time | `OrderCompletedEvent.avsc`
