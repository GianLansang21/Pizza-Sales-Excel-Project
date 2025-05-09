select * from pizza_sales;

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;
-- Average order value
SELECT SUM(total_price)  / COUNT(DISTINCT order_id) AS Average_order_value FROM pizza_sales;
--Sum of all quantities of pizza sold
SELECT SUM(quantity) AS total_pizza_sold from pizza_sales;
--Total orders placed
SELECT COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales;
--Average pizza per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Average_pizzas_per_order FROM pizza_sales;
--Daily trend for total orders
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);
--Hourly trend for total orders
SELECT DATEPART(HOUR, order_time) AS order_hours, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);
--Percentage of sales by pizza category for nth month
SELECT pizza_category,SUM(total_price) AS total_sales, sum(total_price) * 100 / (SELECT sum(total_price) from pizza_sales WHERE MONTH(order_date) = 1) as percentage_of_total_sales
from pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;
--Percentage of sales by pizza size for nth quarter
SELECT pizza_size,CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales,CAST(sum(total_price) * 100 / (SELECT sum(total_price) from pizza_sales WHERE MONTH(order_date) = 1)AS DECIMAL(10,2)) as percentage_of_total_sales
from pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY percentage_of_total_sales DESC;
--total pizzas sold by category
SELECT pizza_category, SUM(quantity) as Total_pizzas_sold 
FROM pizza_sales
GROUP BY pizza_category;
--top 5 best seleers by total pizzas sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizzas_Sold 
from pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Pizzas_Sold DESC;
--bottom 5 worst sellers by total pizzas sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizzas_Sold 
from pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Pizzas_Sold;
