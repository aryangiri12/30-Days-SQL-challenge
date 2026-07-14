-- Income tax returns are supposed to file every year before due date announce by govt every year . 
-- Goverment wants to find out people who have filed late returns or people who have completely skipped filing returns. 
-- Write an SQL to list all the users along with the year for which they have done late filing or missed filing the returns.
-- Create a comment column as well specifying if its a 'late return' or  'missed'.


CREATE TABLE income_tax_dates 
(
    financial_year	VARCHAR(512),
    file_start_date	DATE,
    file_due_date	DATE
);

INSERT INTO income_tax_dates (financial_year, file_start_date, file_due_date) VALUES ('FY20', '2020-05-01', '2020-08-31');
INSERT INTO income_tax_dates (financial_year, file_start_date, file_due_date) VALUES ('FY21', '2021-06-01', '2021-09-30');
INSERT INTO income_tax_dates (financial_year, file_start_date, file_due_date) VALUES ('FY22', '2022-05-05', '2022-08-29');
INSERT INTO income_tax_dates (financial_year, file_start_date, file_due_date) VALUES ('FY23', '2023-05-05', '2023-08-31');

CREATE TABLE users_it 
(
    user_id	INT,
    financial_year	VARCHAR(512),
    return_file_date	DATE
);

INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('1', 'FY20', '2020-05-10');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('1', 'FY21', '2021-10-10');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('1', 'FY23', '2023-08-20');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('2', 'FY20', '2020-05-15');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('2', 'FY21', '2021-09-10');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('2', 'FY22', '2022-08-20');
INSERT INTO users_it (user_id, financial_year, return_file_date) VALUES ('2', 'FY23', '2023-10-10');

 use 30days_sql_challange ;
 
 SELECT * FROM  income_tax_dates ;
SELECT * FROM users_it ;

with users as (
     select Distinct user_id
	 From users_it
     )
select 
    u.user_id,
    d.financial_year,
    case 
       when r.return_file_date is null then 'Missed'
       when r.return_file_date > d.file_due_date then 'Late Return'
       else  'On Time '
       end as comments
From users u
cross join Income_tax_dates d
left join users_it r
    on u.user_id = r.user_id
    and d.financial_year = r.financial_year
where r.return_file_date is null
   or r.return_file_date >d.file_due_date ;
