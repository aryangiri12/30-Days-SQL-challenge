-- You are given a products table where a new row is inserted every time the price of a product changes. 
-- Additionally, there is a transaction table containing details such as order_date and product_ID for each order. 
-- Write an SQL query to calculate the total sales value for each product,
-- considering the cost of the product at the time of the order date.

 use 30days_sql_challange ;
 

CREATE TABLE products_ns 
(
    product_id	INT,
    price_date	DATE,
    price	INT
);

INSERT INTO products_ns (product_id, price_date, price) VALUES ('100', '2024-01-01', '150');
INSERT INTO products_ns (product_id, price_date, price) VALUES ('100', '2024-01-21', '170');
INSERT INTO products_ns (product_id, price_date, price) VALUES ('100', '2024-02-01', '190');
INSERT INTO products_ns (product_id, price_date, price) VALUES ('101', '2024-01-01', '1000');
INSERT INTO products_ns (product_id, price_date, price) VALUES ('101', '2024-01-27', '1200');
INSERT INTO products_ns (product_id, price_date, price) VALUES ('101', '2024-02-05', '1250');

CREATE TABLE orders_ns 
(
    order_id	INT,
    order_date	DATE,
    product_id	INT
);

INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('1', '2024-01-05', '100');
INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('2', '2024-01-21', '100');
INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('3', '2024-02-20', '100');
INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('4', '2024-01-07', '101');
INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('5', '2024-02-04', '101');
INSERT INTO orders_ns (order_id, order_date, product_id) VALUES ('6', '2024-02-05', '101');

select * from products_ns ;
select * from orders_ns ;

WITH cte AS
(
    SELECT
        o.order_id,
        o.product_id,
        o.order_date,
        p.price,
        ROW_NUMBER() OVER
        (
            PARTITION BY o.order_id
            ORDER BY p.price_date DESC
        ) AS rn
    FROM orders_ns o
    JOIN products_ns p
        ON o.product_id = p.product_id
       AND p.price_date <= o.order_date
)

SELECT
    product_id,
    SUM(price) AS total_sales
FROM cte
WHERE rn = 1
GROUP BY product_id;
         
         


