USE ecomm_product;

CREATE OR REPLACE VIEW product_aggr_v
AS
SELECT	product.id 		AS id
FROM product_state_t;




