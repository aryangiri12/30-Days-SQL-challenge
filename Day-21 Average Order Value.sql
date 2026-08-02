-- Write an SQL query to determine the order date with the lowest average order value (AOV) among all dates recorded in the transaction table. 
-- Display the order date, its corresponding AOV, and the difference between the AOV for that date and the highest AOV for any day in the dataset.
-- Round the result to 2 decimal places.


use 30days_sql_challange ;

CREATE TABLE transactions_ns2 
(
    order_id	INT,
    user_id	INT,
    transaction_amount	INT,
    transaction_date	DATE
);

INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('1', '101', '50', '2024-02-24');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('2', '102', '75', '2024-02-24');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('3', '103', '100', '2024-02-25');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('4', '104', '30', '2024-02-26');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('5', '105', '200', '2024-02-27');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('6', '106', '50', '2024-02-27');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('7', '107', '150', '2024-02-27');
INSERT INTO transactions_ns2 (order_id, user_id, transaction_amount, transaction_date) VALUES ('8', '108', '80', '2024-02-29');
 
SELECT * FROM transactions_ns2 ;


with cte_aov as (
select transaction_date,
   round(avg(transaction_amount),2) as aov
   from transactions_ns2
   group by transaction_date
   ),
   max_aov as (
   select * ,
   rank() over(order by aov) as rn,
   round(max(aov)over()  - aov,2) as diff_from_highest_aov
   from cte_aov
   )
   select transaction_date ,
		aov, diff_from_highest_aov
        from max_aov
        where rn = 1 ;
