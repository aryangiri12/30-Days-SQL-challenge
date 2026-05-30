-- Sachin Tendulkar - Also known as little master. You are given runs scored by Sachin in his first 10 matches.
-- You need to write an SQL to get match number when he completed 500 runs and his batting average at the end of 10 matches.
-- Batting Average = (Total runs scored) / (no of times batsman got out)
-- Round the result to 2 decimal places.

use 30days_sql_challange ;


DROP TABLE IF EXISTS sachin ;
CREATE TABLE sachin 
(
    match_no	INT,
    runs_scored	INT,
    status	VARCHAR(512)
);

INSERT INTO sachin (match_no, runs_scored, status) VALUES ('1', '53', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('2', '59', 'not-out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('3', '113', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('4', '29', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('5', '0', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('6', '39', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('7', '73', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('8', '149', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('9', '93', 'out');
INSERT INTO sachin (match_no, runs_scored, status) VALUES ('10', '25', 'out');

SELECT * FROM sachin ;

with total_run as (
select  match_no,sum(runs_scored) over(order by runs_scored rows between unbounded preceding and current row) as cum_run
from sachin
),
match_500 as (
		select  match_no 
        from total_run
        where cum_run >=500
        ), 
bat_avg as (
select  round(1.0*sum(runs_scored)/ sum(case when status = 'out' then 1 else 0 end ),2) as  batting_avg
from sachin 
)
select  m.match_no ,b.batting_avg 
from match_500 m
cross join bat_avg b ;
