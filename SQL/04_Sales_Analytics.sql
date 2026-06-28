--SECTION 1: REVENUE ANALYSIS

-- Total Revenue
SELECT
ROUND(SUM(order_total),2) AS total_revenue
FROM orders;

-- Average Order Value
SELECT
ROUND(AVG(order_total),2) AS avg_order_value
FROM orders;

-- Highest Order Value
SELECT
MAX(order_total) AS highest_order
FROM orders;

--Highest Value Orders
SELECT
order_id,
customer_id,
order_total
FROM orders
ORDER BY order_total DESC
LIMIT 10;

-- Lowest Order Value
SELECT
MIN(order_total) AS lowest_order
FROM orders;

-- Monthly Revenue Trend
SELECT
DATE_TRUNC('month', order_date) AS month,
ROUND(SUM(order_total),2) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

-- Quarterly Revenue
SELECT
EXTRACT(YEAR FROM order_date) AS year,
EXTRACT(QUARTER FROM order_date) AS quarter,
ROUND(SUM(order_total),2) AS revenue
FROM orders
GROUP BY year,quarter
ORDER BY year,quarter;

--Top Brands by Revenue
SELECT
p.brand,
ROUND(SUM(oi.quantity * oi.unit_price),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.brand
ORDER BY revenue DESC
LIMIT 10;

-- PRODUCT PERFORMANCE

--Top 10 Products by Revenue
SELECT
p.product_name,
ROUND(SUM(oi.quantity * oi.unit_price),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 10;

--Bottom 10 Products by Revenue
SELECT
p.product_name,
ROUND(SUM(oi.quantity * oi.unit_price),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue
LIMIT 10;

--Top 10 Products by Quantity Sold
SELECT
p.product_name,
SUM(oi.quantity) AS quantity_sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY quantity_sold DESC
LIMIT 10;

--Bottom 10 Products by Quantity Sold
SELECT
p.product_name,
SUM(oi.quantity) AS quantity_sold
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_name
ORDER BY quantity_sold
LIMIT 10;

-- Product Revenue Ranking
SELECT
p.product_name,
ROUND(SUM(oi.quantity*oi.unit_price),2) AS revenue,
RANK() OVER(
ORDER BY SUM(oi.quantity*oi.unit_price) DESC
) AS revenue_rank
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_name;

-- CATEGORY ANALYSIS

--Revenue by Category
SELECT
p.category,
ROUND(SUM(oi.quantity * oi.unit_price),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

--Category Contribution %
SELECT
p.category,
ROUND(100.0 * SUM(oi.quantity * oi.unit_price)/SUM(SUM(oi.quantity * oi.unit_price)) OVER(),2) AS revenue_share
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue_share DESC;
-- Query 12 Revenue by Category

-- Top Product Within Each Category
WITH product_revenue AS
(SELECT p.category,p.product_name,
SUM(oi.quantity*oi.unit_price) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.category,p.product_name)

SELECT *
FROM(SELECT *,RANK() OVER(PARTITION BY category
ORDER BY revenue DESC
) AS category_rank
FROM product_revenue
) t
WHERE category_rank=1;

-- Average Product Price by Category
SELECT
category,
ROUND(AVG(price),2) AS avg_price
FROM products
GROUP BY category
ORDER BY avg_price DESC;

--CUSTOMER PURCHASE ANALYSIS

-- Revenue by Customer Segment
SELECT
c.customer_segment,
ROUND(SUM(o.order_total),2) AS revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY revenue DESC;

--Orders by Customer Segment
SELECT
c.customer_segment,
COUNT(o.order_id) AS orders
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY orders DESC;

-- Average Order Value by Segment
SELECT
c.customer_segment,
ROUND(AVG(o.order_total),2) AS avg_order_value
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
GROUP BY c.customer_segment
ORDER BY avg_order_value DESC;

-- Top Customers by Revenue
SELECT
c.customer_name,
ROUND(SUM(o.order_total),2) AS revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY revenue DESC
LIMIT 10;

-- Customer Lifetime Value
SELECT
customer_name,
ROUND(total_orders*avg_order_value,2) AS customer_lifetime_value
FROM customers
ORDER BY customer_lifetime_value DESC
LIMIT 20;
-- SECTION 5: ORDER ANALYSIS

-- Revenue by Payment Method
SELECT
payment_method,
ROUND(SUM(order_total),2) AS revenue
FROM orders
GROUP BY payment_method
ORDER BY revenue DESC;

-- Orders by Payment Method
SELECT
payment_method,
COUNT(*) AS orders
FROM orders
GROUP BY payment_method
ORDER BY orders DESC;

-- Revenue Per Store
SELECT
store_id,
ROUND(SUM(order_total),2) AS revenue
FROM orders
GROUP BY store_id
ORDER BY revenue DESC
LIMIT 20;

-- Average Order Value Per Store
SELECT
store_id,
ROUND(AVG(order_total),2) AS avg_order_value
FROM orders
GROUP BY store_id
ORDER BY avg_order_value DESC;

-- ADVANCED SQL ANALYSIS

-- Running Revenue
SELECT
DATE_TRUNC('month',order_date) AS month,
SUM(order_total) AS revenue,
SUM(SUM(order_total))
OVER(ORDER BY DATE_TRUNC('month',order_date)) AS running_revenue
FROM orders
GROUP BY month;

-- Revenue Growth %
WITH monthly_revenue AS
(SELECT
DATE_TRUNC('month',order_date) AS month,
SUM(order_total) AS revenue
FROM orders
GROUP BY month)

SELECT
month,revenue,LAG(revenue)
OVER(ORDER BY month) AS previous_month,
ROUND(100.0*(revenue-LAG(revenue) OVER(ORDER BY month))/LAG(revenue) OVER(ORDER BY month),2
) AS growth_percentage
FROM monthly_revenue;

-- Dense Rank Products
SELECT
p.product_name,
ROUND(SUM(oi.quantity*oi.unit_price),2) AS revenue,
DENSE_RANK()
OVER(
ORDER BY SUM(oi.quantity*oi.unit_price) DESC
) AS rank_num
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_name;

-- Revenue Contribution %
SELECT
p.product_name,
ROUND(SUM(oi.quantity*oi.unit_price),2) AS revenue,
ROUND(100.0*SUM(oi.quantity*oi.unit_price)/SUM(SUM(oi.quantity*oi.unit_price)) OVER(),2
) AS revenue_share
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

--Top Brand Within Each Category
WITH brand_revenue AS
(SELECT p.category, p.brand,
SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category,p.brand)

SELECT *
FROM(SELECT *,RANK() OVER(PARTITION BY category
ORDER BY revenue DESC) AS rank_num
FROM brand_revenue) x
WHERE rank_num = 1;

--Product Revenue vs Quantity Analysis
SELECT
p.product_name,
SUM(oi.quantity) AS quantity_sold,
ROUND(SUM(oi.quantity * oi.unit_price),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

/*  BUSINESS INSIGHTS

1. Dairy & Breakfast generates highest category revenue.

2. Pet Treats and Vitamins are top-performing products.

3. Revenue distribution across payment methods is balanced.

4. Regular customers generate highest revenue.

5. No category contributes more than 13% revenue,
indicating diversified business performance.

6. Average order value is ₹2201.86.

7. Revenue is distributed across multiple brands,
reducing brand dependency risk.
*/
