use 30days_sql_challange ;

-- You are given a list of users and their opening account balance along with the trasaction done by them. 
-- Write a SQL to calculate their account balance at the end of all the transactions.
-- Please note that users can do transactions among themselves as well. 

CREATE TABLE users 
(
    user_id	INT,
    username	VARCHAR(512),
    opening_balance	INT
);

INSERT INTO users (user_id, username, opening_balance) VALUES ('100', 'Ankit', '1000');
INSERT INTO users (user_id, username, opening_balance) VALUES ('101', 'Rahul', '9000');
INSERT INTO users (user_id, username, opening_balance) VALUES ('102', 'Amit', '5000');
INSERT INTO users (user_id, username, opening_balance) VALUES ('103', 'Agam', '7500');


drop table if exists transactions ;
CREATE TABLE transactions
(
    id	INT,
    from_userid	INT,
    to_userid	INT,
    amount	INT
);

INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('1', '100', '102', '500');
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('2', '102', '101', '700');
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('3', '101', '102', '600');
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('4', '102', '100', '1500');
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('5', '102', '101', '800');
INSERT INTO transactions (id, from_userid, to_userid, amount) VALUES ('6', '102', '101', '300');


SELECT * FROM transactions ;
SELECT * FROM users u ;
-- firstly i have to find all transaction based on  from and to 
with all_trans as (
select from_userid as user_id,-1*amount as amount
from transactions 
union all
select to_userid as user_id,1*amount as amount
from transactions ), 
--  now i have to find the  total amount of transaction for each  user_id   it  may be positive or negative 
total_trans as(
select user_id, sum(amount) as trans_amount
from all_trans
group by user_id ) 
--  at the final stage now i have to find the  final balance on the basis of  transaction amount  
select  u.user_id,u.opening_balance + coalesce(t.trans_amount,0)  as final_balace
from users u
left join total_trans t
on u.user_id = t.user_id ;
