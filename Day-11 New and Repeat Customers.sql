-- NamasteKart an ecommerce company wants to build a very imporant business metrics where 
-- they want to track on daily basis how many new and repeat customers are purchasing products from their website. 
-- A new customer is defined when he purchased anything for the first time from the website 
-- and repeat customer is someone who has done atleast one purchase in the past.

use 30days_sql_challange ;



CREATE TABLE customer_orders 
(
    order_id	INT,
    customer_id	INT,
    order_date	DATE,
    order_amount	INT
);

INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('1', '100', '2022-01-01', '2000');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('2', '200', '2022-01-01', '2500');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('3', '300', '2022-01-01', '2100');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('4', '100', '2022-01-02', '2000');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('5', '400', '2022-01-02', '2200');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('6', '500', '2022-01-02', '2700');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('7', '100', '2022-01-03', '3000');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('8', '400', '2022-01-03', '1000');
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES ('9', '600', '2022-01-03', '3000');


SELECT * FROM customer_orders ;


with first_order_date as (
select customer_id,min(order_date) as first_order
from customer_orders
group by customer_id
)
select co.order_date,
sum(case when co.order_date = fod.first_order then 1 else 0 end )  as new_customers,
sum(case when co.order_date >fod.first_order then 1 else 0 end) as repeat_customers
from customer_orders co
 inner join first_order_date  fod
 on co.customer_id = fod.customer_id
 group by co.order_date ;
 
