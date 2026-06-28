-- FEEDBACK OVERVIEW

-- Total Feedback Records
SELECT
COUNT(*) AS total_feedback
FROM customer_feedback;

-- Average Customer Rating
SELECT
ROUND(AVG(rating),2) AS avg_rating
FROM customer_feedback;

-- Highest Rating
SELECT
MAX(rating) AS highest_rating
FROM customer_feedback;

-- Lowest Rating
SELECT
MIN(rating) AS lowest_rating
FROM customer_feedback;

-- RATING ANALYSIS

-- Rating Distribution
SELECT
rating,
COUNT(*) AS total_feedback
FROM customer_feedback
GROUP BY rating
ORDER BY rating;

-- Rating Contribution %
SELECT
rating,
ROUND(100.0 * COUNT(*)/SUM(COUNT(*)) OVER(),2) AS percentage_share
FROM customer_feedback
GROUP BY rating
ORDER BY rating;

-- Average Rating by Feedback Category
SELECT
feedback_category,
ROUND(AVG(rating),2) AS avg_rating
FROM customer_feedback
GROUP BY feedback_category
ORDER BY avg_rating DESC;

-- Feedback Count by Category
SELECT
feedback_category,
COUNT(*) AS total_feedback
FROM customer_feedback
GROUP BY feedback_category
ORDER BY total_feedback DESC;

-- SENTIMENT ANALYSIS

-- Sentiment Distribution
SELECT
sentiment,
COUNT(*) AS total_feedback
FROM customer_feedback
GROUP BY sentiment
ORDER BY total_feedback DESC;

-- Sentiment Contribution %
SELECT
sentiment,
ROUND(100.0 * COUNT(*)/SUM(COUNT(*)) OVER(),2) AS percentage_share
FROM customer_feedback
GROUP BY sentiment
ORDER BY percentage_share DESC;

-- Average Rating by Sentiment
SELECT
sentiment,
ROUND(AVG(rating),2) AS avg_rating
FROM customer_feedback
GROUP BY sentiment
ORDER BY avg_rating DESC;

-- CUSTOMER ANALYSIS

-- Top Customers by Feedback Count
SELECT
customer_id,
COUNT(*) AS feedback_count
FROM customer_feedback
GROUP BY customer_id
ORDER BY feedback_count DESC
LIMIT 20;

-- Customers Giving Lowest Ratings
SELECT
customer_id,
order_id,
rating,
feedback_category
FROM customer_feedback
WHERE rating = 1;

-- Customers Giving Highest Ratings
SELECT
customer_id,
order_id,
rating,
feedback_category
FROM customer_feedback
WHERE rating = 5;

-- CATEGORY ANALYSIS

-- Most Common Feedback Categories
SELECT
feedback_category,
COUNT(*) AS total_feedback
FROM customer_feedback
GROUP BY feedback_category
ORDER BY total_feedback DESC;

-- Highest Rated Categories
SELECT
feedback_category,
ROUND(AVG(rating),2) AS avg_rating
FROM customer_feedback
GROUP BY feedback_category
ORDER BY avg_rating DESC;

-- Lowest Rated Categories
SELECT
feedback_category,
ROUND(AVG(rating),2) AS avg_rating
FROM customer_feedback
GROUP BY feedback_category
ORDER BY avg_rating
LIMIT 10;

-- TIME ANALYSIS

-- Monthly Feedback Trend
SELECT
DATE_TRUNC('month', feedback_date) AS month,
COUNT(*) AS feedback_count
FROM customer_feedback
GROUP BY month
ORDER BY month;

-- Monthly Average Rating
SELECT
DATE_TRUNC('month', feedback_date) AS month,
ROUND(AVG(rating),2) AS avg_rating
FROM customer_feedback
GROUP BY month
ORDER BY month;

-- ADVANCED SQL ANALYSIS

-- Rating Rank
SELECT
customer_id,rating,
RANK() OVER(ORDER BY rating DESC ) AS rating_rank
FROM customer_feedback;

-- Dense Rating Rank
SELECT
customer_id,rating,
DENSE_RANK() OVER(ORDER BY rating DESC) AS dense_rank
FROM customer_feedback;

-- Category Average Comparison

SELECT
feedback_category,customer_id,rating,
ROUND(AVG(rating)OVER(PARTITION BY feedback_category),2) AS category_average
FROM customer_feedback;

-- Above Category Average Feedback

WITH category_avg AS
(SELECT customer_id, feedback_category,rating,
AVG(rating) OVER( PARTITION BY feedback_category ) AS category_average
FROM customer_feedback)

SELECT *
FROM category_avg
WHERE rating > category_average;

-- Top Rated Feedback Category

WITH category_rating AS
(SELECT feedback_category,AVG(rating) AS avg_rating
FROM customer_feedback
GROUP BY feedback_category)

SELECT *
FROM
(SELECT *, RANK() OVER( ORDER BY avg_rating DESC ) AS rank_num
FROM category_rating) x
WHERE rank_num = 1;

-- Running Average Rating

SELECT
feedback_date,rating,
ROUND(AVG(rating)OVER(ORDER BY feedback_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) ,2) AS running_avg_rating
FROM customer_feedback;

/*

BUSINESS INSIGHTS

1. Evaluate overall customer satisfaction.

2. Analyze customer sentiment trends.

3. Identify highly rated and poorly rated categories.

4. Detect recurring customer experience issues.

5. Track rating performance over time.

6. Compare category ratings against averages.

7. Understand sentiment-rating relationships.

8. Identify opportunities to improve customer experience.

*/