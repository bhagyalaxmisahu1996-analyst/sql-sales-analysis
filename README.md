# SQL Sales Analysis

## 📊 Project Overview

This project analyzes e-commerce sales data using MySQL to understand sales performance, customer behavior, product performance, discounts, order status, and profitability.

The project uses SQL to transform transactional data into meaningful business information that can support data-driven decision making.

## 🎯 Business Objective

The main objective of this project is to analyze sales transactions and answer important business questions related to:

- Sales performance
- Customer performance
- Product performance
- Discounts
- Order status
- Revenue and profitability
- Regional performance

## 📁 Dataset

The dataset contains transactional sales information including:

### Orders
- Order ID
- Order Date
- Customer ID
- Product ID
- Quantity
- Discount %
- Payment Mode
- Shipping Mode
- Order Status

### Customers
- Customer ID
- Customer Name
- Gender
- Age
- City
- Region
- State

### Products
- Product ID
- Product information
- Cost Price
- Selling Price

The tables were connected using relevant keys such as Customer ID and Product ID.

## 🛠️ Tools Used

- MySQL
- MySQL Workbench
- SQL

## 📚 SQL Concepts Used

The project demonstrates practical use of:

- SELECT and filtering
- Aggregate functions
- GROUP BY and HAVING
- JOINs
- CASE statements
- NULL handling
- Data cleaning
- CTEs
- Subqueries
- Window functions
- UNION and UNION ALL
- Conditional aggregation
- Date and text functions
- Business calculations

## 💰 Key Business Calculations

The analysis includes calculations such as:

- Gross Sales
- Discount Amount
- Net Sales
- Total Cost
- Profit
- Profit Margin
- Order-level and customer-level sales
- Product-level performance

## 🔍 Business Questions

The analysis is designed to answer questions such as:

1. What are the total sales and total profit?
2. Which products generate the highest sales?
3. Which customers contribute the most revenue?
4. How do discounts affect net sales and profit?
5. How are orders distributed across different order statuses?
6. Which regions perform best?
7. What is the overall profit margin?
8. How can transactional data be transformed into useful business insights?

## 📈 Key Insights

Key findings from the analysis will be added after completing the SQL analysis.

## 📂 Project Structure

```text
sql-sales-analysis/
│
├── README.md
│
├── sql/
│   ├── data_cleaning.sql
│   ├── sales_analysis.sql
│   └── advanced_analysis.sql
│
└── screenshots/
