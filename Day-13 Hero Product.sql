-- NamasteKart an ecommerce company wants to find out its top most selling product by quanity in each category. 
-- In case of a tie when quantities sold are same for more than 1 product 
-- than we need to give preference to the product with higher sales value.
use 30days_sql_challange ;



CREATE TABLE orders_nkart 
(
    order_id	INT,
    product_id	VARCHAR(512),
    category	VARCHAR(512),
    unit_price	INT,
    quantity	INT
);

INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('100', 'Chair-1221', 'Furniture', '1500', '1');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('101', 'Table-3421', 'Furniture', '2000', '3');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('102', 'Chair-1221', 'Furniture', '1500', '2');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('103', 'Table-9762', 'Furniture', '7000', '2');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('104', 'Shoes-1221', 'Footwear', '1700', '1');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('105', 'floaters-3421', 'Footwear', '2000', '1');
INSERT INTO orders_nkart (order_id, product_id, category, unit_price, quantity) VALUES ('106', 'floaters-3421', 'Footwear', '2000', '1');

SELECT * FROM orders_nkart;

with total_count as (
select product_id,category,sum(quantity) as total_quant, sum(unit_price*Quantity) as  total_sell
from orders_nkart
group by  product_id,category
),
total_sell as (select *,
dense_rank() over(partition by category order by total_quant desc, total_sell desc ) as drn
from total_count
)
select category, product_id
from total_sell
where drn = 1
group by category,product_id ;

