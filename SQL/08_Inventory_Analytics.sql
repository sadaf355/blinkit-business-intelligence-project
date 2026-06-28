-- INVENTORY OVERVIEW

-- Total Inventory Records
SELECT
COUNT(*) AS total_inventory_records
FROM inventory;

-- Total Stock Received
SELECT
SUM(stock_received) AS total_stock_received
FROM inventory;

-- Total Damaged Stock
SELECT
SUM(damaged_stock) AS total_damaged_stock
FROM inventory;

-- Average Stock Received
SELECT
ROUND(AVG(stock_received),2) AS avg_stock_received
FROM inventory;

-- Average Damaged Stock
SELECT
ROUND(AVG(damaged_stock),2) AS avg_damaged_stock
FROM inventory;

-- PRODUCT INVENTORY ANALYSIS

-- Stock Received by Product
SELECT
product_id,
SUM(stock_received) AS total_stock
FROM inventory
GROUP BY product_id
ORDER BY total_stock DESC;

-- Top 10 Products by Stock Received
SELECT
product_id,
SUM(stock_received) AS total_stock
FROM inventory
GROUP BY product_id
ORDER BY total_stock DESC
LIMIT 10;

-- Lowest Stock Products
SELECT
product_id,
SUM(stock_received) AS total_stock
FROM inventory
GROUP BY product_id
ORDER BY total_stock
LIMIT 10;

-- DAMAGE ANALYSIS

-- Damaged Stock by Product
SELECT
product_id,
SUM(damaged_stock) AS total_damage
FROM inventory
GROUP BY product_id
ORDER BY total_damage DESC;

-- Top 10 Products with Highest Damage
SELECT
product_id,
SUM(damaged_stock) AS total_damage
FROM inventory
GROUP BY product_id
ORDER BY total_damage DESC
LIMIT 10;

-- Damage Percentage by Product
SELECT
product_id,
ROUND(100.0 * SUM(damaged_stock)/NULLIF(SUM(stock_received),0),2) AS damage_percentage
FROM inventory
GROUP BY product_id
ORDER BY damage_percentage DESC;

-- PRODUCT MASTER ANALYSIS

-- Average Product Price by Category
SELECT
category,
ROUND(AVG(price),2) AS avg_price
FROM products
GROUP BY category
ORDER BY avg_price DESC;

-- Average Margin by Category
SELECT
category,
ROUND(AVG(margin_percentage),2) AS avg_margin
FROM products
GROUP BY category
ORDER BY avg_margin DESC;

-- Shelf Life Analysis
SELECT
category,
ROUND(AVG(shelf_life_days),2) AS avg_shelf_life
FROM products
GROUP BY category
ORDER BY avg_shelf_life DESC;

-- STOCK LEVEL ANALYSIS

-- Average Minimum Stock Level
SELECT
ROUND(AVG(min_stock_level),2) AS avg_min_stock
FROM products;

-- Average Maximum Stock Level
SELECT
ROUND(AVG(max_stock_level),2) AS avg_max_stock
FROM products;

-- Products with Highest Max Stock Level
SELECT
product_name,
max_stock_level
FROM products
ORDER BY max_stock_level DESC
LIMIT 10;

-- Products with Lowest Min Stock Level
SELECT
product_name,
min_stock_level
FROM products
ORDER BY min_stock_level
LIMIT 10;

-- TIME ANALYSIS

-- Monthly Stock Received Trend
SELECT
DATE_TRUNC('month', date) AS month,
SUM(stock_received) AS stock_received
FROM inventory
GROUP BY month
ORDER BY month;

-- Monthly Damage Trend
SELECT
DATE_TRUNC('month', date) AS month,
SUM(damaged_stock) AS damaged_stock
FROM inventory
GROUP BY month
ORDER BY month;

-- Monthly Damage Percentage
SELECT
DATE_TRUNC('month', date) AS month,
ROUND(100.0 * SUM(damaged_stock)/NULLIF(SUM(stock_received),0),2) AS damage_percentage
FROM inventory
GROUP BY month
ORDER BY month;

-- ADVANCED SQL ANALYSIS

-- Product Stock Ranking
SELECT
product_id,SUM(stock_received) AS total_stock,
RANK() OVER(ORDER BY SUM(stock_received) DESC) AS stock_rank
FROM inventory
GROUP BY product_id;

-- Dense Rank Stock Products
SELECT
product_id,SUM(stock_received) AS total_stock,
DENSE_RANK() OVER(ORDER BY SUM(stock_received) DESC) AS dense_rank
FROM inventory
GROUP BY product_id;

-- Product vs Category Average Margin
SELECT
product_name,category,margin_percentage,
ROUND(AVG(margin_percentage)OVER(PARTITION BY category),2) AS category_avg_margin
FROM products;

-- Products Above Category Margin Average
WITH margin_avg AS
(SELECT product_name,category,margin_percentage,
AVG(margin_percentage)
OVER(PARTITION BY category) AS category_avg
FROM products)

SELECT *
FROM margin_avg
WHERE margin_percentage > category_avg;

-- Highest Margin Product in Each Category
WITH product_margin AS
(SELECT category,product_name,margin_percentage FROM products)

SELECT *FROM
(SELECT *,RANK() OVER(PARTITION BY category ORDER BY margin_percentage DESC) AS rank_num
FROM product_margin) x
WHERE rank_num = 1;

-- Running Stock Received
SELECT
date,stock_received,
SUM(stock_received)
OVER(ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_stock
FROM inventory;

/*

BUSINESS INSIGHTS

1. Monitor stock inflow across products.
2. Identify products with high inventory damage.
3. Track inventory loss percentages.
4. Analyze category-wise profitability using margins.
5. Evaluate stock thresholds and replenishment needs.
6. Identify high-margin products.
7. Monitor inventory trends over time.
8. Optimize inventory planning and warehouse operations.
9. Detect categories with excessive stock damage.
10. Support supply chain decision-making.

*/
