-- CAMPAIGN OVERVIEW

-- Total Campaign Records
SELECT
COUNT(*) AS total_campaign_records
FROM marketing_performance;

-- Total Marketing Spend
SELECT
ROUND(SUM(spend),2) AS total_spend
FROM marketing_performance;

-- Total Revenue Generated
SELECT
ROUND(SUM(revenue_generated),2) AS total_revenue
FROM marketing_performance;

-- Average ROAS
SELECT
ROUND(AVG(roas),2) AS avg_roas
FROM marketing_performance;

-- Highest ROAS
SELECT
MAX(roas) AS highest_roas
FROM marketing_performance;

-- Lowest ROAS
SELECT
MIN(roas) AS lowest_roas
FROM marketing_performance;

-- CAMPAIGN PERFORMANCE

-- Revenue by Campaign
SELECT
campaign_name,
ROUND(SUM(revenue_generated),2) AS revenue
FROM marketing_performance
GROUP BY campaign_name
ORDER BY revenue DESC;

-- Spend by Campaign
SELECT
campaign_name,
ROUND(SUM(spend),2) AS spend
FROM marketing_performance
GROUP BY campaign_name
ORDER BY spend DESC;

-- ROAS by Campaign
SELECT
campaign_name,
ROUND(AVG(roas),2) AS avg_roas
FROM marketing_performance
GROUP BY campaign_name
ORDER BY avg_roas DESC;

-- Top 10 Revenue Generating Campaigns
SELECT
campaign_name,
ROUND(SUM(revenue_generated),2) AS revenue
FROM marketing_performance
GROUP BY campaign_name
ORDER BY revenue DESC
LIMIT 10;

-- Lowest Performing Campaigns
SELECT
campaign_name,
ROUND(SUM(revenue_generated),2) AS revenue
FROM marketing_performance
GROUP BY campaign_name
ORDER BY revenue
LIMIT 10;

-- CHANNEL ANALYSIS

-- Revenue by Channel
SELECT
channel,
ROUND(SUM(revenue_generated),2) AS revenue
FROM marketing_performance
GROUP BY channel
ORDER BY revenue DESC;

-- Spend by Channel
SELECT
channel,
ROUND(SUM(spend),2) AS spend
FROM marketing_performance
GROUP BY channel
ORDER BY spend DESC;

-- ROAS by Channel
SELECT
channel,
ROUND(AVG(roas),2) AS avg_roas
FROM marketing_performance
GROUP BY channel
ORDER BY avg_roas DESC;

-- Channel Contribution %
SELECT
channel,
ROUND(100.0 * SUM(revenue_generated)/SUM(SUM(revenue_generated)) OVER(),2) AS revenue_share
FROM marketing_performance
GROUP BY channel
ORDER BY revenue_share DESC;

-- TARGET AUDIENCE ANALYSIS

-- Revenue by Target Audience
SELECT
target_audience,
ROUND(SUM(revenue_generated),2) AS revenue
FROM marketing_performance
GROUP BY target_audience
ORDER BY revenue DESC;

-- Spend by Target Audience
SELECT
target_audience,
ROUND(SUM(spend),2) AS spend
FROM marketing_performance
GROUP BY target_audience
ORDER BY spend DESC;

-- ROAS by Target Audience
SELECT
target_audience,
ROUND(AVG(roas),2) AS avg_roas
FROM marketing_performance
GROUP BY target_audience
ORDER BY avg_roas DESC;

-- CONVERSION ANALYSIS

-- Overall Conversion Rate
SELECT
ROUND(100.0 * SUM(conversions)/SUM(clicks),2) AS conversion_rate
FROM marketing_performance;

-- Conversion Rate by Campaign
SELECT
campaign_name,
ROUND(100.0 * SUM(conversions)/SUM(clicks),2) AS conversion_rate
FROM marketing_performance
GROUP BY campaign_name
ORDER BY conversion_rate DESC;

-- Conversion Rate by Channel
SELECT
channel,
ROUND(100.0 * SUM(conversions)/SUM(clicks),2) AS conversion_rate
FROM marketing_performance
GROUP BY channel
ORDER BY conversion_rate DESC;

-- Click Through Rate (CTR)
SELECT
ROUND(100.0 * SUM(clicks)/SUM(impressions),2) AS ctr
FROM marketing_performance;

-- CTR by Channel
SELECT
channel,
ROUND(100.0 * SUM(clicks)/SUM(impressions),2) AS ctr
FROM marketing_performance
GROUP BY channel
ORDER BY ctr DESC;

-- TIME ANALYSIS

-- Monthly Revenue Trend
SELECT
DATE_TRUNC('month', date) AS month,
ROUND(SUM(revenue_generated),2) AS revenue
FROM marketing_performance
GROUP BY month
ORDER BY month;

-- Monthly Spend Trend
SELECT
DATE_TRUNC('month', date) AS month,
ROUND(SUM(spend),2) AS spend
FROM marketing_performance
GROUP BY month
ORDER BY month;

-- Monthly ROAS Trend
SELECT
DATE_TRUNC('month', date) AS month,
ROUND(AVG(roas),2) AS avg_roas
FROM marketing_performance
GROUP BY month
ORDER BY month;

-- ADVANCED SQL ANALYSIS

-- Revenue Rank by Campaign
SELECT
campaign_name,
SUM(revenue_generated) AS revenue,
RANK() OVER(ORDER BY SUM(revenue_generated) DESC) AS revenue_rank
FROM marketing_performance
GROUP BY campaign_name;

-- Dense Rank Campaigns
SELECT
campaign_name,
SUM(revenue_generated) AS revenue,
DENSE_RANK() OVER(ORDER BY SUM(revenue_generated) DESC) AS dense_rank
FROM marketing_performance
GROUP BY campaign_name;

-- Campaign vs Channel Average Revenue
SELECT
campaign_name,channel,revenue_generated,
ROUND(AVG(revenue_generated)OVER(PARTITION BY channel),2) AS channel_average
FROM marketing_performance;

-- Campaigns Above Channel Average
WITH channel_avg AS
(SELECT campaign_name,channel,revenue_generated,
AVG(revenue_generated)OVER(PARTITION BY channel) AS channel_average
FROM marketing_performance)

SELECT *
FROM channel_avg
WHERE revenue_generated > channel_average;

-- Top Campaign in Each Channel
WITH campaign_revenue AS
(SELECT channel, campaign_name,
SUM(revenue_generated) AS revenue FROM marketing_performance
GROUP BY channel,campaign_name)

SELECT *
FROM( SELECT *,RANK() OVER(PARTITION BY channel
ORDER BY revenue DESC) AS rank_num
FROM campaign_revenue) x
WHERE rank_num = 1;

-- Running Revenue

SELECT
date,revenue_generated,
SUM(revenue_generated)
OVER(ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_revenue
FROM marketing_performance;

/*

BUSINESS INSIGHTS

1. Measure overall marketing effectiveness.

2. Identify top-performing campaigns.

3. Analyze channel-wise performance.

4. Evaluate target audience profitability.

5. Track conversion and click-through rates.

6. Understand campaign ROI through ROAS.

7. Compare campaign performance against channel averages.

8. Optimize budget allocation using data-driven insights.

9. Identify the most profitable marketing channels.

10. Improve campaign targeting strategies.

*/