-- Customer Overview

--Total Customers
SELECT
COUNT(*) AS total_customers
FROM customers;

--Total Customer Segments
SELECT
COUNT(DISTINCT customer_segment) AS total_segments
FROM customers;

--Customer Distribution by Segment
SELECT
customer_segment,
COUNT(*) AS total_customers
FROM customers
GROUP BY customer_segment
ORDER BY total_customers DESC;

--Customer Segment Contribution %
SELECT
customer_segment,
ROUND(100.0 * COUNT(*) /SUM(COUNT(*)) OVER(),2) AS percentage_share
FROM customers
GROUP BY customer_segment
ORDER BY percentage_share DESC;

--CUSTOMER SEGMENT ANALYSIS

--Average Order Value by Segment
SELECT
customer_segment,
ROUND(AVG(avg_order_value),2) AS avg_order_value
FROM customers
GROUP BY customer_segment
ORDER BY avg_order_value DESC;

--Average Orders by Segment
SELECT
customer_segment,
ROUND(AVG(total_orders),2) AS avg_orders
FROM customers
GROUP BY customer_segment
ORDER BY avg_orders DESC;

--Total Orders by Segment
SELECT
customer_segment,
SUM(total_orders) AS total_orders
FROM customers
GROUP BY customer_segment
ORDER BY total_orders DESC;

--Estimated Revenue by Segment
SELECT
customer_segment,
ROUND(SUM(total_orders * avg_order_value),2) AS estimated_revenue
FROM customers
GROUP BY customer_segment
ORDER BY estimated_revenue DESC;

--CUSTOMER SPENDING ANALYSIS

--Customer Lifetime Value
SELECT
customer_name,
customer_segment,
ROUND(total_orders * avg_order_value,2) AS customer_lifetime_value
FROM customers
ORDER BY customer_lifetime_value DESC
LIMIT 20;

--Top 10 Customers by Estimated Spend
SELECT
customer_name,
customer_segment,
total_orders,
avg_order_value,
ROUND(total_orders * avg_order_value,2) AS estimated_spend
FROM customers
ORDER BY estimated_spend DESC
LIMIT 10;

--Bottom 10 Customers by Estimated Spend
SELECT
customer_name,
customer_segment,
total_orders,
avg_order_value,
ROUND(total_orders * avg_order_value,2) AS estimated_spend
FROM customers
ORDER BY estimated_spend
LIMIT 10;

--Highest Average Order Value Customers
SELECT
customer_name,
avg_order_value
FROM customers
ORDER BY avg_order_value DESC
LIMIT 10;

-- Most Active Customers
SELECT
customer_name,
total_orders
FROM customers
ORDER BY total_orders DESC
LIMIT 10;

--CUSTOMER REGISTRATION ANALYSIS

--Customer Registration Trend
SELECT
TO_CHAR(registration_date,'Mon YYYY') AS month,
COUNT(*) AS new_customers
FROM customers
GROUP BY month
ORDER BY MIN(registration_date);

--Registration by Year
SELECT
EXTRACT(YEAR FROM registration_date) AS year,
COUNT(*) AS customers
FROM customers
GROUP BY year
ORDER BY year;

--Highest Registration Month
SELECT
TO_CHAR(registration_date,'Mon YYYY') AS month,
COUNT(*) AS customers
FROM customers
GROUP BY month
ORDER BY customers DESC
LIMIT 5;

--ADVANCED CUSTOMER ANALYSIS

--Customer Spending Rank
SELECT
customer_name,
ROUND(total_orders * avg_order_value,2) AS estimated_spend,
RANK() OVER( ORDER BY total_orders * avg_order_value DESC) AS spending_rank
FROM customers;

--Dense Rank Customers
SELECT
customer_name,
ROUND(total_orders * avg_order_value,2) AS estimated_spend,
DENSE_RANK() OVER(ORDER BY total_orders * avg_order_value DESC) AS dense_rank
FROM customers;

--Customer Segment Average Comparison
SELECT
customer_name,customer_segment,avg_order_value,
ROUND(AVG(avg_order_value)OVER(PARTITION BY customer_segment),2) AS segment_avg
FROM customers;

--Above Segment Average Customers
WITH customer_segment_avg AS
(SELECT customer_name,customer_segment,avg_order_value,
AVG(avg_order_value)
OVER(PARTITION BY customer_segment)
AS segment_avg
FROM customers)
SELECT *
FROM customer_segment_avg
WHERE avg_order_value > segment_avg;

--Top Customer in Each Segment
WITH customer_spend AS
(SELECT customer_name, customer_segment, total_orders * avg_order_value AS spend
FROM customers)

SELECT *
FROM( SELECT *,
RANK() OVER( PARTITION BY customer_segment
ORDER BY spend DESC) AS rank_num
FROM customer_spend) t
WHERE rank_num = 1;

/*
BUSINESS INSIGHTS

1. Customer distribution is balanced across all segments.

2. New customers have the highest average order value.

3. Regular customers form the largest customer group.

4. Spending variation across segments is minimal.

5. Customer acquisition remains stable across months.

6. High-value customers generate disproportionately larger revenue.

7. Customer lifetime value highlights the most profitable customers.

8. Segment-based analysis shows opportunities for targeted retention campaigns.
*/