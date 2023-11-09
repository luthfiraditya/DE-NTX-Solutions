-- Test Case 1: Channel Analysis | Craft an SQL query to ascertain the total revenue generated from each channel grouping for the top 5 countries producing the highest revenue.
SELECT 
    country, SUM(productRevenue) as total_revenue
FROM 
   ecommerce
GROUP BY 
    country
ORDER BY 
    total_revenue DESC
LIMIT 5;


-- Test Case 2: User Behavior Analysis | Derive insights into user behavior.
WITH UserAvgMetrics AS (
    SELECT 
        fullVisitorId,
        AVG(timeOnSite) AS avgTimeOnSite,
        AVG(pageviews) AS avgPageviews
    FROM 
        ecommerce
    GROUP BY 
        fullVisitorId
)
SELECT 
    UAM.fullVisitorId,
    UAM.avgTimeOnSite,
    UAM.avgPageviews
FROM 
    UserAvgMetrics UAM
JOIN (
    SELECT 
        AVG(timeOnSite) AS overallAvgTimeOnSite,
        AVG(pageviews) AS overallAvgPageviews
    FROM 
        ecommerce
) AS OverallAvg ON 1=1
WHERE 
    UAM.avgTimeOnSite > OverallAvg.overallAvgTimeOnSite
    AND UAM.avgPageviews < OverallAvg.overallAvgPageviews;
    
    
    
-- Test Case 3: Product Performance
-- 1. Computes the total revenue generated by each product (`v2ProductName`).
SELECT 
    v2ProductName,
    SUM(productRevenue) AS total_revenue
FROM 
    ecommerce
GROUP BY 
    v2ProductName
ORDER BY total_revenue DESC;


-- 2. Determines the total quantity sold for each product.
SELECT 
    v2ProductName,
    SUM(productQuantity) AS total_quantity_sold
FROM 
    ecommerce
GROUP BY 
    v2ProductName
ORDER BY total_quantity_sold DESC;



-- 3. Calculates the total refund amount for each product and Rank products based on their net revenue (total revenue minus refunds)
--  in a descending order. Flag any product with a refund amount surpassing 10% of its total revenue. .
WITH ProductRevenue AS (
    SELECT 
        v2ProductName,
        COALESCE(SUM(productRevenue), 0) AS total_revenue,
        COALESCE(SUM(productRefundAmount), 0) AS total_refund
    FROM 
       ecommerce
    GROUP BY 
        v2ProductName
)
SELECT 
    PR.v2ProductName,
    PR.total_revenue - PR.total_refund AS net_revenue,
    CASE 
        WHEN PR.total_refund > (0.1 * PR.total_revenue) THEN 'Refund > 10%'
        ELSE 'Refund <= 10%'
    END AS refund_flag
FROM 
    ProductRevenue PR
ORDER BY 
    net_revenue DESC;