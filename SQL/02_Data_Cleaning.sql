--DUPLICATE CHECKS

SELECT
customer_id,
COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT
product_id,
COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT
order_id,
COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
product_id,
date,
COUNT(*)
FROM inventory
GROUP BY product_id,date
HAVING COUNT(*) > 1;

--NULL VALUE CHECKS

SELECT *
FROM customers
WHERE customer_id IS NULL;

SELECT *
FROM customers
WHERE customer_name IS NULL;

SELECT *
FROM customers
WHERE email IS NULL;

SELECT *
FROM orders
WHERE customer_id IS NULL;

SELECT *
FROM products
WHERE product_name IS NULL;

--RANGE VALIDATION

-- Check negative values

SELECT *
FROM products
WHERE price < 0;

SELECT *
FROM orders
WHERE order_total < 0;

SELECT *
FROM delivery_performance
WHERE delivery_time_minutes < 0;

SELECT *
FROM marketing_performance
WHERE spend < 0;

SELECT *
FROM inventory
WHERE damaged_stock < 0;

--REFERENTIAL INTEGRITY

--Orders without Customers
SELECT *
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

--Order Items without Orders
SELECT *
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

--Order Items without Products
SELECT *
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

--Feedback without Customers
SELECT *
FROM customer_feedback cf
LEFT JOIN customers c
ON cf.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

--Date Validation

--Orders Delivered Before Order Date
SELECT *
FROM orders
WHERE actual_delivery_time < order_date;

--Promised Time Earlier Than Order Time
SELECT *
FROM orders
WHERE promised_delivery_time < order_date;

--Future Feedback Dates
SELECT *
FROM customer_feedback
WHERE feedback_date > CURRENT_DATE;

--Business Rule Validation

--Invalid Customer Segments
SELECT DISTINCT customer_segment
FROM customers
WHERE customer_segment NOT IN
('Premium','Regular','New','Inactive');

--Invalid Delivery Status
SELECT DISTINCT delivery_status
FROM delivery_performance
WHERE delivery_status NOT IN
('Delivered','Delayed','Cancelled');

--Delivery Status Mismatch Between Orders and Delivery Performance
SELECT
o.order_id,
o.delivery_status AS orders_status,
dp.delivery_status AS delivery_performance_status
FROM orders o
JOIN delivery_performance dp
ON o.order_id = dp.order_id
WHERE o.delivery_status <> dp.delivery_status;

--Invalid Sentiment Values
SELECT DISTINCT sentiment
FROM customer_feedback
WHERE sentiment NOT IN
('Positive','Neutral','Negative');

-- Invalid Quantity
SELECT *
FROM order_items
WHERE quantity <= 0;

--Invalid Unit Price
SELECT *
FROM order_items
WHERE unit_price <= 0;

--Invalid Ratings
SELECT *
FROM customer_feedback
WHERE rating NOT BETWEEN 1 AND 5;

--DATA QUALITY SUMMARY (live check, not a static note)
--Re-run this anytime the dataset changes; each rule reports its own PASS/FAIL.

SELECT 'Duplicate customer_id' AS check_name,
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS result,
COUNT(*) AS failing_rows
FROM (SELECT customer_id FROM customers GROUP BY customer_id HAVING COUNT(*) > 1) x

UNION ALL
SELECT 'Duplicate product_id',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM (SELECT product_id FROM products GROUP BY product_id HAVING COUNT(*) > 1) x

UNION ALL
SELECT 'Duplicate order_id',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM (SELECT order_id FROM orders GROUP BY order_id HAVING COUNT(*) > 1) x

UNION ALL
SELECT 'Duplicate inventory (product_id, date)',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM (SELECT product_id,date FROM inventory GROUP BY product_id,date HAVING COUNT(*) > 1) x

UNION ALL
SELECT 'Null customer_name',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM customers WHERE customer_name IS NULL

UNION ALL
SELECT 'Null email',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM customers WHERE email IS NULL

UNION ALL
SELECT 'Null product_name',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM products WHERE product_name IS NULL

UNION ALL
SELECT 'Negative product price',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM products WHERE price < 0

UNION ALL
SELECT 'Negative order_total',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM orders WHERE order_total < 0

UNION ALL
SELECT 'Negative marketing spend',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM marketing_performance WHERE spend < 0

UNION ALL
SELECT 'Orders without matching customer',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM orders o LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL

UNION ALL
SELECT 'Order items without matching order',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM order_items oi LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL

UNION ALL
SELECT 'Order items without matching product',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM order_items oi LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL

UNION ALL
SELECT 'Feedback without matching customer',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM customer_feedback cf LEFT JOIN customers c ON cf.customer_id = c.customer_id
WHERE c.customer_id IS NULL

UNION ALL
SELECT 'Delivery before order placed',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM orders WHERE actual_delivery_time < order_date

UNION ALL
SELECT 'Promised time earlier than order time',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM orders WHERE promised_delivery_time < order_date

UNION ALL
SELECT 'Future feedback dates',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM customer_feedback WHERE feedback_date > CURRENT_DATE

UNION ALL
SELECT 'Invalid customer_segment',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM customers WHERE customer_segment NOT IN ('Premium','Regular','New','Inactive')

UNION ALL
SELECT 'Invalid delivery_status',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM delivery_performance WHERE delivery_status NOT IN ('Delivered','Delayed','Cancelled')

UNION ALL
SELECT 'delivery_status mismatch (orders vs delivery_performance)',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM orders o JOIN delivery_performance dp ON o.order_id = dp.order_id
WHERE o.delivery_status <> dp.delivery_status

UNION ALL
SELECT 'Invalid sentiment',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM customer_feedback WHERE sentiment NOT IN ('Positive','Neutral','Negative')

UNION ALL
SELECT 'Invalid quantity (<= 0)',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM order_items WHERE quantity <= 0

UNION ALL
SELECT 'Invalid unit_price (<= 0)',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM order_items WHERE unit_price <= 0

UNION ALL
SELECT 'Invalid rating (not 1-5)',
CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
COUNT(*)
FROM customer_feedback WHERE rating NOT BETWEEN 1 AND 5

ORDER BY result DESC, check_name;