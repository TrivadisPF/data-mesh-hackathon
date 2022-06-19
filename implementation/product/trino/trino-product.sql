USE pub_ecomm_product;

CREATE OR REPLACE VIEW product_aggr_v
AS
SELECT	product.id 			AS id
, 		name 				AS name
,       productNumber		AS product_number
,       makeFlag			AS make_flag
,		finishedGoodsFlag 	AS finished_goods_flag
,		color				AS color
,		safetyStockLevel	AS safety_stock_level
,		reorderPoint		AS reorder_point
,		standardCost		AS standard_cost
,		listPrice			AS list_price
,		size				AS size
,		weight				AS weight
,		daysToManufacture	AS days_to_manufacture
,		productLine			AS product_line
,		class				AS class
,		style				AS style
FROM product_state_t;




