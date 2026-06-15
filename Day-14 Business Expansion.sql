-- You are given a table called business_operations that records the dates on which a business started operating in different cities.

-- A city can appear multiple times because multiple operations may occur in the same city over the years.

-- Write an SQL query to determine how many new cities were added each year.

-- A city should be counted only in the first year it ever appeared.


use 30days_sql_challange ;

CREATE TABLE business_operations 
(
    business_date date,
    city_id	INT
);

INSERT INTO business_operations (business_date, city_id) VALUES ('2020-01-02', '3');
INSERT INTO business_operations (business_date, city_id) VALUES ('2020-07-01', '7');
INSERT INTO business_operations (business_date, city_id) VALUES ('2021-01-01', '3');
INSERT INTO business_operations (business_date, city_id) VALUES ('2021-02-03', '19');
INSERT INTO business_operations (business_date, city_id) VALUES ('2022-12-01', '3');
INSERT INTO business_operations (business_date, city_id) VALUES ('2022-12-15', '3');
INSERT INTO business_operations (business_date, city_id) VALUES ('2022-02-28', '12');

SELECT * FROM business_operations ;


with  first_city as (
select  city_id,
extract(year from  min(business_date) ) as added_year
from  business_operations 
group by city_id
)
 select 
		added_year,
        count(city_id) as no_of_city_added
        from first_city
        group by added_year
        order by added_year ;
