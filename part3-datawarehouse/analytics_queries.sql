-- Question-Task 3.3

-- Query 1: Monthly Sales Drill-Down Analysis
-- Business Scenario: "The CEO wants to see sales performance broken down by time periods. Start with yearly total, then quarterly, then monthly sales for 2024."
-- Requirements:
 -- Show: year, quarter, month, total_sales, total_quantity
-- Group by year, quarter, month
-- Order chronologically
-- This demonstrates drill-down (Year → Quarter → Month)

SELECT 
    YEAR(order_date)     AS      year,
    CONCAT('Q', QUARTER(order_date)) AS quarter,
    MONTHNAME(order_date)   AS   month_name,
    ROUND(SUM(subtotal))    AS   total_sales,
    SUM(quantity)      AS        total_items
FROM order_items oi
JOIN orders o USING(order_id)
WHERE order_date >= '2024-01-01' AND order_date  <  '2025-01-01' AND status = 'Completed'
GROUP BY year, quarter, MONTH(order_date)
ORDER BY year, quarter, MONTH(order_date);

-- Query 2: Product Performance Analysis - Top 10 by Revenue
-- Business Scenario: "The product manager needs to identify top-performing products. Show the top 10 products by revenue, along with their category, total units sold, and revenue contribution percentage."

-- Requirements:

-- Join fact_sales with dim_product
-- Calculate: total revenue, total quantity per product
-- Calculate: percentage of total revenue (each product's revenue / overall revenue × 100)
-- Order by revenue descending
-- Limit to top 10

SELECT
    p.product_name,
    p.category,
    SUM(f.quantity) AS units_sold,
    SUM(f.sales_amount) AS revenue,
    ROUND((SUM(f.sales_amount) /SUM(SUM(f.sales_amount)) OVER ()) * 100, 2) AS revenue_percentage
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY
    p.product_name,
    p.category
ORDER BY revenue DESC
LIMIT 10;

-- Query 3: Customer Segmentation Analysis
-- Business Scenario: "Marketing wants to target high-value customers. Segment customers into 'High Value' (>₹50,000 spent), 'Medium Value' (₹20,000-₹50,000), and 'Low Value' (<₹20,000). Show count of customers and total revenue in each segment."

-- Requirements:

-- Calculate total spending per customer
-- Use CASE statement to create segments
-- Group by segment
-- Show: segment, customer_count, total_revenue, avg_revenue_per_customer

SELECT 
    CASE 
        WHEN SUM(sales_amount) > 50000 THEN 'High Value'
        WHEN SUM(sales_amount) BETWEEN 20000 AND 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    
    COUNT(customer_id) AS customer_count,
    SUM(sales_amount) AS total_revenue,
    ROUND(AVG(sales_amount), 2) AS avg_revenue_per_customer

FROM fact_sales
GROUP BY customer_id
HAVING SUM(sales_amount) IS NOT NULL   
ORDER BY total_revenue DESC;