-- Write an SQL to find the list of premium customers along with the number of orders 
-- placed by each of them.

use 30days_sql_challange ;


CREATE TABLE orders (
    order_id INT,
    order_date DATE ,
    customer_name VARCHAR(50),
    sales INT
);

-- Insert the data
INSERT INTO orders (order_id, order_date, customer_name, sales) VALUES
(1, '2023-01-01', 'Alexa', 1239),
(2, '2023-01-02', 'Alexa', 1239),
(3, '2023-01-03', 'Alexa', 1239),
(4, '2023-01-03', 'Alexa', 1239),
(5, '2023-01-01', 'Ramesh', 1239),
(6, '2023-01-02', 'Ramesh', 1239),
(7, '2023-01-03', 'Ramesh', 1239),
(8, '2023-01-03', 'Neha', 1200),
(9, '2023-01-03', 'Subhash', 100),
(10, '2023-01-03', 'Subhash', 230);

with premium_customers as (
select customer_name 
from orders 
group by customer_name
having count(distinct order_date)>= 3
)
select count(o.order_id) as no_of_order ,p.customer_name as pre_customer
from  orders o
join premium_customers p
on o.customer_name = p.customer_n
