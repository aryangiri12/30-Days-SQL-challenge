/*
Assume you are given a "user_transactions" table
containing customer transactions.

Write a SQL query to retrieve each user's most recent
transaction date along with the number of products
they purchased on that date.

Return:
• transaction_date
• user_id
• purchase_count

Sort the  results by transaction_date.

*/
USE 30days_sql_challange;



CREATE TABLE user_transactions (
  product_id INT,
  user_id INT,
  spend DECIMAL(10,2),
  transaction_date DATETIME
);

INSERT INTO user_transactions VALUES
(3673, 123, 68.90, '2022-07-08 12:00:00'),
(9623, 123, 274.10, '2022-07-08 12:00:00'),
(1467, 115, 19.90, '2022-07-08 12:00:00'),
(2511, 115, 35.50, '2022-07-08 12:00:00'),
(7192, 115, 42.00, '2022-07-10 12:00:00'),
(4821, 111, 55.75, '2022-07-09 12:00:00'),
(5934, 111, 80.25, '2022-07-09 12:00:00'),
(8012, 111, 25.00, '2022-07-11 12:00:00');

select * from user_transactions ;

with cte as (
     select user_id,transaction_date, count(product_id) as purchase_count,
	 row_number() over(partition  by user_id order by transaction_date desc) as rn
 from user_transactions
 group by user_id, transaction_date
 )
 select transaction_date,
		user_id,purchase_count
        from cte
        where rn = 1
         order by transaction_date ;
 
 
 
 
 
 
 
 
 
 

