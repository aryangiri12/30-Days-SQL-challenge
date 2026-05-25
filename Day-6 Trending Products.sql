-- Amazon wants to find out the Trending products for each month. 
-- Trending products are those for which any given month sales is more than the sum of previous 2 months sales for that product
-- Please note that for first 2 months of operations this metrics does not make sense.
-- So output should start from 3rd month only.  Assume that each product has atleast 1 sales each month.

-- RANGE CLAUSE
-- Unbounded preceding & Unbounded Following means (whole data in a column i.e from first row to last row)
-- Unbounded preceding & current Row means (Data from first row to current row)
-- current Row & Unbounded Following means (Data from current row to last row)
-- 5 preceding & 1 preceding means (Data between 5th row and 1st row from current row 
                                 -- referencing current row)
                                 
 use 30days_sql_challange ;
 
 CREATE TABLE orders_nsql 
(
    order_month	INT,
    product_id	VARCHAR(512),
    sales	INT
);

INSERT INTO orders_nsql (order_month, product_id, sales) VALUES ('202301', 'p1', '100');
INSERT INTO orders_nsql (order_month, product_id, sales) VALUES ('202301', 'p2', '500');
INSERT INTO orders_nsql (order_month, product_id, sales) VALUES ('202302', 'p1', '700');
INSERT INTO orders_nsql (order_month, product_id, sales) VALUES ('202302', 'p2', '300');
INSERT INTO orders_nsql (order_month, product_id, sales) VALUES ('202303', 'p1', '900');
INSERT INTO orders_nsql (order_month, product_id, sales) VALUES ('202303', 'p2', '700');
INSERT INTO orders_nsql (order_month, product_id, sales) VALUES ('202304', 'p1', '2000');
INSERT INTO orders_nsql (order_month, product_id, sales) VALUES ('202304', 'p2', '1100');

SELECT * FROM orders_nsql ;

with  trend_product as (
select *,
sum(sales)over(partition by product_id order by order_month rows between 2 preceding and 1 preceding ) as latets_2_SALES,
row_number() OVER(partition by product_id order by order_month) AS rn 
from  orders_nsql )
select product_id,order_month
from trend_product
where rn>=3 and sales> latets_2_SALES ;
