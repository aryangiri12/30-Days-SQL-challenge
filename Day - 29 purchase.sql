Find customers who purchased in every month of 2024, 2025 and 2026.


SELECT
    customer_id

FROM orders

WHERE order_date >= '2024-01-01'
  AND order_date < '2027-01-01'

GROUP BY customer_id

HAVING COUNT(
           DISTINCT YEAR(order_date),
                    MONTH(order_date)
       ) = 36;
