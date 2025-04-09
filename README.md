# E-commerce-Sales-and-Returns-Dashboard
# 🛒 E-commerce Sales & Returns Analysis

This Power BI project analyzes a large e-commerce dataset to uncover insights related to sales performance, product returns, and customer behavior. The goal is to support strategic decision-making by visualizing trends, identifying top-performing segments, and exposing operational inefficiencies.

---

## 📦 Dataset Overview

- **Tables used**:  
  - `Orders`  
  - `Returns`  
  - `Products`  
  - `Customers`

---

## 🧠 Business Questions Answered

1. **Which product categories generate the most revenue?**  
2. **What is the monthly trend of sales? Are there signs of seasonality?**  
3. **Which regions have the highest number of orders and returns?**  
4. **What are the most used payment methods?**  
5. **Who are the top customers by total spend?**  
6. **Is there a correlation between payment method and return rate?**  
7. **What is the average order value and item count per customer?**

---

## 📊 Key Metrics & Measures

- `Total Revenue`  
- `Total Orders`  
- `Average Order Value`  
- `Return Rate`  
- `Revenue by Category / Region / Month`  
- `Returned Orders by Payment Method`  
- `Top 10 Customers by Spend`

> All measures were created using **DAX** in Power BI.

---

## 📌 Insights

- **Clothing** and **Sports** categories generated the highest revenue, followed closely by **Books**.
- The **highest return rates** were observed in the **West** and **South** regions.
- **Bank Transfer** had the most returns compared to other payment methods.
- The **average order value** was **628.61**, while most customers ordered around 3 items per purchase.
- There is an observed correlation between **Cash on Delivery** and **lower return rates**.

---

## 📁 Files

- `Ecommerce_Analysis.pbix` – Power BI dashboard  
- `SQL_queries.sql` – Data transformation and metrics logic  
- `data_sample.csv` – Preview of raw dataset

---

## 🛠️ Tools Used

- **Power BI** – Data modeling & dashboard  
- **SQL** – Data transformation  
- **DAX** – Custom measures & KPIs  
- **Excel** – Initial data cleaning

---

## 📌 Next Steps

- Add a time comparison (YoY, MoM growth)
- Build a predictive model for return risk
- Deploy an interactive web dashboard



