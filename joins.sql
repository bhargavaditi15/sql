select * from products;
select * from sales;

-- inner join
select * from products inner join sales
on products.product_id = sales.product_id;

-- left join
SELECT *
FROM sales as s
LEFT JOIN products as p
ON s.product_id = p.product_id;

-- rigth join 
SELECT *
FROM sales as s
RIGHT JOIN products as p
ON s.product_id = p.product_id;

-- full join
select * from sales as s
left join products as p
on s.product_id = p.product_id
union
select * from sales as s
right join products as p
on s.product_id = p.product_id;

