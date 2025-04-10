
# 🛒 Ecommerce Sales & Returns Analysis
# Dataset: 50,000+ orders 
# Goal: Business insight extraction using SQL
# Tool: MySQL

# ---------------------------------------------
# 📊 1. Total Orders and Total Revenue
# ---------------------------------------------
SELECT 
    COUNT(*) AS total_orders,
    SUM(TotalAmount) AS total_revenue
FROM Ecommerce_Orders;


# ---------------------------------------------
# 💰 2. Top 5 Product Categories by Revenue
# ---------------------------------------------
SELECT 
    ProductCategory,
    SUM(TotalAmount) AS revenue
FROM Ecommerce_Orders
GROUP BY ProductCategory
ORDER BY revenue DESC
LIMIT 5;


# ---------------------------------------------
# 📅 3. Monthly Sales Trend
# ---------------------------------------------
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS month,
    SUM(TotalAmount) AS monthly_revenue
FROM Ecommerce_Orders
GROUP BY month
ORDER BY month;


# ---------------------------------------------
# 🌍 4. Return Rate by Region
# ---------------------------------------------
SELECT 
    CustomerRegion,
    COUNT(*) AS total_orders,
    SUM(Returned) AS total_returns,
    ROUND(100.0 * SUM(Returned) / COUNT(*), 2) AS return_rate_percentage
FROM Ecommerce_Orders
GROUP BY CustomerRegion
ORDER BY return_rate_percentage DESC;


# ---------------------------------------------
# 💳 5. Most Popular Payment Methods
# ---------------------------------------------
SELECT 
    PaymentMethod,
    COUNT(*) AS total_transactions
FROM Ecommerce_Orders
GROUP BY PaymentMethod
ORDER BY total_transactions DESC;


# ---------------------------------------------
# 🏆 6. Top 10 Customers by Total Spending
# ---------------------------------------------
SELECT 
    CustomerID,
    SUM(TotalAmount) AS total_spent
FROM Ecommerce_Orders
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;


# ---------------------------------------------
# 🧾 7. Average Order Value per Product Category
# ---------------------------------------------
SELECT 
    ProductCategory,
    ROUND(AVG(TotalAmount), 2) AS avg_order_value
FROM Ecommerce_Orders
GROUP BY ProductCategory
ORDER BY avg_order_value DESC;


# ---------------------------------------------
# 🔁 8. Return Rate by Payment Method
# ---------------------------------------------
SELECT 
    PaymentMethod,
    COUNT(*) AS total_orders,
    SUM(Returned) AS total_returns,
    ROUND(100.0 * SUM(Returned) / COUNT(*), 2) AS return_rate
FROM Ecommerce_Orders
GROUP BY PaymentMethod
ORDER BY return_rate DESC;


# ---------------------------------------------
# ⭐ 9. Loyal Customers: High Spend & No Returns
# ---------------------------------------------
WITH customer_stats AS (
    SELECT 
        CustomerID,
        COUNT(*) AS total_orders,
        SUM(TotalAmount) AS total_spent,
        SUM(Returned) AS total_returns,
        ROUND(100.0 * SUM(Returned) / COUNT(*), 2) AS return_rate
    FROM Ecommerce_Orders
    GROUP BY CustomerID
),
overall_avg AS (
    SELECT 
        ROUND(AVG(TotalAmount), 2) AS avg_spend
    FROM Ecommerce_Orders
)
SELECT 
    cs.CustomerID,
    cs.total_orders,
    cs.total_spent,
    cs.return_rate
FROM customer_stats cs
JOIN overall_avg oa ON 1=1
WHERE cs.total_spent > oa.avg_spend
  AND cs.return_rate = 0
ORDER BY cs.total_spent DESC
LIMIT 20;


# ---------------------------------------------
# 📈 10. Seasonality: Best Month per Category
# ---------------------------------------------
WITH monthly_sales AS (
    SELECT 
        ProductCategory,
        DATE_FORMAT(OrderDate, '%Y-%m') AS month,
        SUM(TotalAmount) AS monthly_revenue
    FROM Ecommerce_Orders
    GROUP BY ProductCategory, month
),
ranked_months AS (
    SELECT *,
           RANK() OVER (PARTITION BY ProductCategory ORDER BY monthly_revenue DESC) AS rank
    FROM monthly_sales
)
SELECT 
    ProductCategory,
    month,
    monthly_revenue
FROM ranked_months
WHERE rank = 1
ORDER BY ProductCategory;


# ---------------------------------------------
# 🚩 11. Underperforming Categories (High Returns, Low Order Value)
# ---------------------------------------------
WITH category_stats AS (
    SELECT 
        ProductCategory,
        COUNT(*) AS total_orders,
        SUM(Returned) AS total_returns,
        ROUND(100.0 * SUM(Returned) / COUNT(*), 2) AS return_rate,
        ROUND(AVG(TotalAmount), 2) AS avg_order_value
    FROM Ecommerce_Orders
    GROUP BY ProductCategory
)
SELECT *
FROM category_stats
WHERE return_rate > 10
  AND avg_order_value < (SELECT AVG(TotalAmount) FROM Ecommerce_Orders)
ORDER BY return_rate DESC;
