Compare Two Tables — Find INSERTED, DELETED & MODIFIED Records
Problem

Suppose we have two versions of an employee table:

Old table: employees_old
employee_id | name  | department | salary
------------|-------|------------|-------
1           | Rahul | IT         | 40000
2           | Amit  | HR         | 35000
3           | Priya | Finance    | 50000
New table: employees_new
employee_id | name  | department | salary
------------|-------|------------|-------
1           | Rahul | IT         | 40000
2           | Amit  | HR         | 40000
4           | Neha  | IT         | 45000


SELECT
    COALESCE(n.employee_id, o.employee_id) AS employee_id,

    CASE
        WHEN o.employee_id IS NULL THEN 'INSERTED'
        WHEN n.employee_id IS NULL THEN 'DELETED'
        WHEN NOT (
               n.name <=> o.name
           AND n.department <=> o.department
           AND n.salary <=> o.salary
        )
        THEN 'MODIFIED'
    END AS change_type

FROM employees_old o

LEFT JOIN employees_new n
    ON o.employee_id = n.employee_id

UNION

SELECT
    COALESCE(n.employee_id, o.employee_id) AS employee_id,

    CASE
        WHEN o.employee_id IS NULL THEN 'INSERTED'
        WHEN n.employee_id IS NULL THEN 'DELETED'
        WHEN NOT (
               n.name <=> o.name
           AND n.department <=> o.department
           AND n.salary <=> o.salary
        )
        THEN 'MODIFIED'
    END AS change_type

FROM employees_old o

RIGHT JOIN employees_new n
    ON o.employee_id = n.employee_id;
