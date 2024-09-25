create database sales;

use sales;

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10, 2)
);

INSERT INTO Sales (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);

INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphones', 'Electronics', 30.00),
(104, 'Keyboard', 'Electronics', 20.00),
(105, 'Mouse', 'Electronics', 15.00);

show tables;

-- 1. Retrieve all columns from the Sales table as well as from products table.
select * from sales;
select * from products;

-- 2. Retrieve the product_name and unit_price from the Products table.
select product_name, unit_price from products;

-- 3. Retrieve the sale_id and sale_date from the Sales table.
select sale_id, sale_date from sales;

-- 4. Filter the Sales table to show only sales with a total_price greater than $100.
select * from sales where total_price > 100;

-- 5. Filter the Products table to show only products in the ‘Electronics’ category.
select * from products where category = 'Electronics';

-- 6. Retrieve the sale_id and total_price from the Sales table for sales made on January 3, 2024.
select sale_id, total_price from sales where sale_date = '2024-01-03';

-- 7. Retrieve the product_id and product_name from the Products table for products with a unit_price greater than $100.
select product_id, product_name from products where unit_price > 100;

-- 8. Calculate the total revenue generated from all sales in the Sales table.
select sum(total_price) as total_revenue from sales;

-- 9. Calculate the average unit_price of products in the Products table.
select avg(unit_price) as total_average from products;

-- 10. Calculate the total quantity_sold from the Sales table.
select sum(quantity_sold) as total_quantity_sold from sales;

-- 11. Retrieve the sale_id, product_id, and total_price from the Sales table for sales with a quantity_sold greater than 4.
select sale_id, product_id, total_price  from sales where quantity_sold > 4;

-- 12. Retrieve the product_name and unit_price from the Products table, ordering the results by unit_price in descending order.
select product_name, unit_price from products order by unit_price desc;

-- 13. Retrieve the total_price of all sales, rounding the values to two decimal places.
select round(sum(total_price),2) as total_sales from sales;

-- 14. Calculate the average total_price of sales in the Sales table.
select avg(total_price) as total_avg from sales;

-- 15. Retrieve the sale_id and sale_date from the Sales table, formatting the sale_date as ‘YYYY-MM-DD’.
select sale_id, date_format(sale_date, '%Y-%m-%d') as formatted_date from sales;

-- 16. Calculate the total revenue generated from sales of products in the ‘Electronics’ category.
SELECT SUM(Sales.total_price) AS total_revenue 
FROM Sales 
JOIN Products ON Sales.product_id = Products.product_id 
WHERE Products.category = 'Electronics';

-- 17. Retrieve the product_name and unit_price from the Products table, filtering the unit_price to show only values between $20 and $600.
select product_name, unit_price from products where unit_price between 20 and 600;

-- 18. Retrieve the product_name and category from the Products table, ordering the results by category in ascending order.
select product_name, category from products order by category asc;

-- 19. Calculate the total quantity_sold of products in the ‘Electronics’ category.
SELECT SUM(quantity_sold) AS total_quantity_sold 
FROM Sales 
JOIN Products ON Sales.product_id = Products.product_id 
WHERE Products.category = 'Electronics';

-- 20. Retrieve the product_name and total_price from the Sales table, calculating the total_price as quantity_sold multiplied by unit_price.
SELECT product_name, quantity_sold * unit_price AS total_price 
FROM Sales 
JOIN Products ON Sales.product_id = Products.product_id;

-- 1. Calculate the total revenue generated from sales for each product category.
select p.category, SUM(s.total_price) AS total_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.category;

-- 2. Find the product category with the highest average unit price.
select category from products
group by category
order by avg(unit_price) desc
limit 1;

-- 3. Identify products with total sales exceeding 30.
select p.product_name
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.total_price) > 30;

-- 4. Count the number of sales made in each month.
select DATE_FORMAT(s.sale_date, '%Y-%m') AS month, COUNT(*) AS sales_count
FROM Sales s
GROUP BY month;

-- 5. Determine the average quantity sold for products with a unit price greater than $100.
SELECT AVG(s.quantity_sold) AS average_quantity_sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
WHERE p.unit_price > 100;

-- 6. Retrieve the product name and total sales revenue for each product.
select p.product_name, sum(s.total_price) as total_revenue
from sales s 
join products p on s.product_id = p.product_id
group by p.product_name;

-- 7. List all sales along with the corresponding product names.
select s.sale_id, p.product_name
from sales s 
join products p on s.product_id = p.product_id;

-- 8. Retrieve the product name and total sales revenue for each product.

-- 9. Rank products based on total sales revenue.
SELECT p.product_name, SUM(s.total_price) AS total_revenue,
       RANK() OVER (ORDER BY SUM(s.total_price) DESC) AS revenue_rank
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- 10. Calculate the running total revenue for each product category.
SELECT p.category, p.product_name, s.sale_date, 
       SUM(s.total_price) OVER (PARTITION BY p.category ORDER BY s.sale_date) AS running_total_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id;

-- 11. Categorize sales as “High”, “Medium”, or “Low” based on total price (e.g., > $200 is High, $100-$200 is Medium, < $100 is Low).
SELECT sale_id, 
       CASE 
           WHEN total_price > 200 THEN 'High'
           WHEN total_price BETWEEN 100 AND 200 THEN 'Medium'
           ELSE 'Low'
       END AS sales_category
FROM Sales;

-- 12. Identify sales where the quantity sold is greater than the average quantity sold.
SELECT *
FROM Sales
WHERE quantity_sold > (SELECT AVG(quantity_sold) FROM Sales);

-- 13. Extract the month and year from the sale date and count the number of sales for each month
SELECT CONCAT(YEAR(sale_date), '-', LPAD(MONTH(sale_date), 2, '0')) AS month,
       COUNT(*) AS sales_count
FROM Sales
GROUP BY YEAR(sale_date), MONTH(sale_date);

-- 14. Calculate the number of days between the current date and the sale date for each sale.
SELECT sale_id, DATEDIFF(NOW(), sale_date) AS days_since_sale
FROM Sales;

-- 15. Identify sales made during weekdays versus weekends.
select sale_id,
       case 
           when DAYOFWEEK(sale_date) IN (1, 7) THEN 'Weekend'
           else 'Weekday'
       END AS day_type
FROM Sales;

