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
