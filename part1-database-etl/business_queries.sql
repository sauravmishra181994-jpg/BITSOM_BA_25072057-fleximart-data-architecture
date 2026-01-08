-- TASK 1.3

-- Query 1: Customer Purchase History
-- Business Question: "Generate a detailed report showing each customer's name, email, 
-- total number of orders placed, and total amount spent. Include only customers who have 
-- placed at least 2 orders and spent more than ₹5,000. Order by total amount spent in descending order."
-- Expected to return customers with 2+ orders and >5000 spent

SELECT c.first_name || ' ' || c.last_name AS customer_name, c.email,
    COUNT(s.transaction_id) AS total_orders,
    SUM(s.quantity * s.unit_price) AS total_spent
FROM df_sales s
JOIN df_customer c ON s.customer_id = c.customer_id
WHERE s.status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
HAVING COUNT(s.transaction_id) >= 2 AND SUM(s.quantity * s.unit_price) > 5000
ORDER BY total_spent DESC;

-- Query 2: Product Sales Analysis
-- Business Question: "For each product category, show the category name, number of different products sold, 
-- total quantity sold, and total revenue generated. Only include categories that have generated more than 
-- ₹10,000 in revenue. Order by total revenue descending."
-- Expected to return categories with >10000 revenue

SELECT p.category,
    COUNT(DISTINCT p.product_id) AS num_products,
    SUM(s.quantity) AS total_quantity_sold,
    SUM(s.quantity * s.unit_price) AS total_revenue
FROM df_product p
JOIN df_sales s ON p.product_id = s.product_id
WHERE s.status = 'Completed'
GROUP BY p.category
HAVING SUM(s.quantity * s.unit_price) > 10000
ORDER BY total_revenue DESC;

-- Query 3: Monthly Sales Trend
-- Business Question: "Show monthly sales trends for the year 2024. For each month, display the 
-- month name, total number of orders, total revenue, and the running total of revenue (cumulative 
-- revenue from January to that month)."
-- Expected to show monthly and cumulative revenue

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS month_start,
        COUNT(transaction_id) AS total_orders,
        SUM(quantity * unit_price) AS monthly_revenue
    FROM df_sales
    WHERE status = 'Completed' AND EXTRACT(YEAR FROM transaction_date) = 2024
    GROUP BY month_start
)
SELECT
    TO_CHAR(month_start, 'Month') AS month_name,
    total_orders,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY month_start) AS cumulative_revenue
FROM monthly_sales
ORDER BY month_start;