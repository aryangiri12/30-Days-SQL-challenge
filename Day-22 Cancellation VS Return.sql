-- You are given orders data of an ecommerce website with order date, delivery date and cancel date information.
-- If the order is cancelled after it is delivered then it will be considered as a return order else cancelled order. 

-- Write an SQL to calculate cancellation rate and return rate for each month (as per order date). 
-- Round the rates to 2 decimal places.

-- cancellation rate = (no of orders cancelled / total orders placed but not returned ) * 100 

-- return rate = (no of orders returned/ total orders placed but not cancelled) * 100 

-- Sort the output by increasing order of yearmonth('YYYYMM')

use 30days_sql_challange ;

drop table if exists order_ns2 ;
CREATE TABLE order_ns2 
(
    order_id	INT,
    customer_id	INT,
    order_date	VARCHAR(512),
    delivery_date VARCHAR(512),	
    cancel_date	VARCHAR(512)
);

INSERT INTO order_ns2 (order_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('1', '101', '2023-01-05', '2023-01-10', 'null');
INSERT INTO order_ns2 (order_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('2', '102', '2023-01-10', '2023-01-15', '2023-01-16');
INSERT INTO order_ns2 (order_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('3', '103', '2023-01-15', 'null', '2023-01-20');
INSERT INTO order_ns2 (order_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('4', '104', '2023-01-07', '2023-01-10', 'null');
INSERT INTO order_ns2 (order_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('5', '105', '2023-01-13', '2023-01-17', '2023-01-19');
INSERT INTO order_ns2 (order_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('6', '106', '2023-02-15', '2023-02-20', 'null');
INSERT INTO order_ns2 (order_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('7', '107', '2023-02-05', '2023-02-05', '2023-02-08');
INSERT INTO order_ns2 (order_id, customer_id, order_date, delivery_date, cancel_date) VALUES ('8', '108', '2023-02-10', 'null', '2023-02-15');

SELECT * FROM order_ns2  ;

select date_format(order_date,'%Y%m') as month_year,
       round(
             count(case
				 when cancel_date != 'null'
                  and delivery_date = 'null'  then 1 end)*100/ 
                 (count(*) - count(case
                                       when cancel_date != 'null'
                                       and  delivery_date != 'null'
                                        then 1 end)
                                        ),2) as cancelation_rate,
	   round(
             count(case
						when cancel_date != 'null'
						and  delivery_date != 'null'  then 1 end)*100/
                        (count(*)- count(case
											 when  cancel_date != 'null'
                                              and delivery_date = 'null' 
                                              then 1 end)
                                              ),2) as return_rate 
from  order_ns2
group by month_year
order by month_year ;
