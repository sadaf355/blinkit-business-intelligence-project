-- DELIVERY OVERVIEW

-- Total Deliveries
SELECT
COUNT(*) AS total_deliveries
FROM delivery_performance;

-- Average Delivery Time
SELECT
ROUND(AVG(delivery_time_minutes),2) AS avg_delivery_time
FROM delivery_performance;

-- Fastest Delivery
SELECT
MIN(delivery_time_minutes) AS fastest_delivery
FROM delivery_performance;

-- Slowest Delivery
SELECT
MAX(delivery_time_minutes) AS slowest_delivery
FROM delivery_performance;

-- Average Delivery Distance
SELECT
ROUND(AVG(distance_km),2) AS avg_distance
FROM delivery_performance;

-- DELIVERY STATUS ANALYSIS

-- Deliveries by Status
SELECT
delivery_status,
COUNT(*) AS total_deliveries
FROM delivery_performance
GROUP BY delivery_status
ORDER BY total_deliveries DESC;

-- Delivery Status Contribution %
SELECT
delivery_status,
ROUND(100.0 * COUNT(*)/SUM(COUNT(*)) OVER(),2) AS percentage_share
FROM delivery_performance
GROUP BY delivery_status
ORDER BY percentage_share DESC;

-- Average Delivery Time by Status
SELECT
delivery_status,
ROUND(AVG(delivery_time_minutes),2) AS avg_delivery_time
FROM delivery_performance
GROUP BY delivery_status
ORDER BY avg_delivery_time;

-- Average Distance by Status
SELECT
delivery_status,
ROUND(AVG(distance_km),2) AS avg_distance
FROM delivery_performance
GROUP BY delivery_status
ORDER BY avg_distance DESC;

-- DELAY ANALYSIS

-- Delay Reasons Distribution
SELECT
reasons_if_delayed,
COUNT(*) AS occurrences
FROM delivery_performance
GROUP BY reasons_if_delayed
ORDER BY occurrences DESC;

-- Delay Reason Contribution %
SELECT
reasons_if_delayed,
ROUND(100.0 * COUNT(*)/SUM(COUNT(*)) OVER(),2) AS percentage_share
FROM delivery_performance
GROUP BY reasons_if_delayed
ORDER BY percentage_share DESC;

-- Top 10 Most Delayed Orders
SELECT
order_id,
delivery_partner_id,
delivery_time_minutes,
distance_km,
reasons_if_delayed
FROM delivery_performance
ORDER BY delivery_time_minutes DESC
LIMIT 10;

-- Top 10 Earliest Deliveries
SELECT
order_id,
delivery_partner_id,
delivery_time_minutes,
distance_km
FROM delivery_performance
ORDER BY delivery_time_minutes
LIMIT 10;

-- Average Delay by Reason
SELECT
reasons_if_delayed,
ROUND(AVG(delivery_time_minutes),2) AS avg_delay
FROM delivery_performance
GROUP BY reasons_if_delayed
ORDER BY avg_delay DESC;

-- DELIVERY PARTNER ANALYSIS

-- Deliveries Handled by Partner
SELECT
delivery_partner_id,
COUNT(*) AS deliveries_handled
FROM delivery_performance
GROUP BY delivery_partner_id
ORDER BY deliveries_handled DESC
LIMIT 20;

-- Average Delivery Time by Partner
SELECT
delivery_partner_id,
ROUND(AVG(delivery_time_minutes),2) AS avg_delivery_time
FROM delivery_performance
GROUP BY delivery_partner_id
ORDER BY avg_delivery_time;

-- Fastest Delivery Partners
SELECT
delivery_partner_id,
ROUND(AVG(delivery_time_minutes),2) AS avg_delivery_time
FROM delivery_performance
GROUP BY delivery_partner_id
ORDER BY avg_delivery_time
LIMIT 10;

-- Slowest Delivery Partners
SELECT
delivery_partner_id,
ROUND(AVG(delivery_time_minutes),2) AS avg_delivery_time
FROM delivery_performance
GROUP BY delivery_partner_id
ORDER BY avg_delivery_time DESC
LIMIT 10;

-- DISTANCE ANALYSIS

-- Distance vs Delivery Time
SELECT
ROUND(distance_km,0) AS distance_bucket,
ROUND(AVG(delivery_time_minutes),2) AS avg_delivery_time
FROM delivery_performance
GROUP BY distance_bucket
ORDER BY distance_bucket;

-- Longest Distance Deliveries
SELECT
order_id,
distance_km,
delivery_time_minutes
FROM delivery_performance
ORDER BY distance_km DESC
LIMIT 10;

-- Shortest Distance Deliveries
SELECT
order_id,
distance_km,
delivery_time_minutes
FROM delivery_performance
ORDER BY distance_km
LIMIT 10;

-- ADVANCED SQL ANALYSIS

-- Delivery Time Ranking
SELECT
order_id,
delivery_time_minutes,
RANK() OVER(ORDER BY delivery_time_minutes DESC) AS delivery_rank
FROM delivery_performance;

-- Dense Rank Delivery Times
SELECT
order_id,
delivery_time_minutes,
DENSE_RANK() OVER(ORDER BY delivery_time_minutes DESC) AS dense_rank
FROM delivery_performance;

-- Average Delivery Time Compared to Status Average
SELECT
order_id,
delivery_status,
delivery_time_minutes,
ROUND(AVG(delivery_time_minutes)OVER(PARTITION BY delivery_status),2) AS status_average
FROM delivery_performance;

-- Deliveries Above Status Average
WITH delivery_status_avg AS
(SELECT order_id,delivery_status,delivery_time_minutes,
AVG(delivery_time_minutes)
OVER(PARTITION BY delivery_status) AS status_avg
FROM delivery_performance)

SELECT *
FROM delivery_status_avg
WHERE delivery_time_minutes > status_avg;

-- Most Delayed Delivery in Each Status
WITH delivery_rankings AS
(SELECT order_id, delivery_status, delivery_time_minutes,
RANK() OVER(PARTITION BY delivery_status ORDER BY delivery_time_minutes DESC ) AS rank_num
FROM delivery_performance)

SELECT *
FROM delivery_rankings
WHERE rank_num = 1;

-- Running Average Delivery Time
SELECT
order_id, delivery_time_minutes,
ROUND( AVG(delivery_time_minutes)
OVER( ORDER BY order_id
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ),2) AS running_avg_delivery_time
FROM delivery_performance;

/*

BUSINESS INSIGHTS

1. Identify overall delivery efficiency using average delivery time.

2. Understand delivery status distribution.

3. Discover the major causes of delivery delays.

4. Evaluate delivery partner performance.

5. Analyze relationship between distance and delivery time.

6. Identify consistently high-performing delivery partners.

7. Detect operational bottlenecks causing delays.

8. Compare deliveries against status-level averages.

9. Rank deliveries based on delay severity.

10. Generate actionable insights for logistics optimization.

*/