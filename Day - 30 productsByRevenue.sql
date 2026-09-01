Top 3 Products by Revenue in Each Category

This is one of the most important window-function questions.

Suppose we have:

products
product_id | product_name | category
-----------|--------------|----------
1          | iPhone       | Mobile
2          | Samsung      | Mobile
3          | OnePlus      | Mobile
4          | Dell Laptop  | Laptop
5          | HP Laptop    | Laptop
sales
sale_id | product_id | quantity | price
--------|------------|----------|------
1       | 1          | 10       | 70000
2       | 2          | 15       | 50000
3       | 3          | 20       | 30000
...

We want:

Top 3 products by revenue within each category.


with purchase_revenue as (
	select p.product_id,p.product_name,p.category,
 	       sum(s.quantity*s.price) as revenue
	from products p
	join sales s
    on p.product_id = s.product_id
    group by p.product_id,
	     p.product_name,
	     p.category
),rank_product as
(
select product_id,
        product_name,
	category,
	revenue,
     rank()over(partition by category order by revenue desc) as rn
from purchase_revenue
)

select product_id,
       product_name,
       category,
       revenue
from rank_product
where rn<=3
order by category,revenue desc






