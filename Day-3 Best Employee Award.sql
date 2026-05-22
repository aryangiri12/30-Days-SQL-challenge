use 30days_sql_challange ; 

--  Write an SQL to find best employee for each month along with number of projects completed by him/her in that month .



DROP TABLE IF EXISTS  ncs_tb ;
CREATE TABLE ncs_tb 
(
    project_id	INT,
    employee_name	VARCHAR(512),
    project_completion_date 	DATE
);

INSERT INTO ncs_tb (project_id, employee_name, project_completion_date ) VALUES ('101', 'Shilpa', '2023-01-03 ');
INSERT INTO ncs_tb (project_id, employee_name, project_completion_date ) VALUES ('102', 'Shilpa', '2023-01-15 ');
INSERT INTO ncs_tb (project_id, employee_name, project_completion_date ) VALUES ('103', 'Shilpa', '2023-01-22 ');
INSERT INTO ncs_tb (project_id, employee_name, project_completion_date ) VALUES ('104', 'Rahul', '2023-01-05');

SELECT * FROM ncs_tb;

WITH project_counts AS
(
    SELECT  
	employee_name,
	date_format(project_completion_date,'%Y-%m') AS months,
	COUNT(*) AS project_count
FROM ncs_tb
GROUP BY employee_name,
             date_format(project_completion_date,'%Y-%m')
),

ranking_emp AS
(
    SELECT *,
           DENSE_RANK() OVER(
               PARTITION BY months 
               ORDER BY project_count DESC
           ) AS rn
    FROM project_counts
)

SELECT months,
       employee_name,
       project_count
FROM ranking_emp
WHERE rn = 1;
	
