-- ============================================================
-- SQL SALES ANALYSIS PROJECT
-- 01 - DATA CLEANING & DATA QUALITY CHECKS
-- ============================================================

-- ============================================================
-- 1. CHECK FOR MISSING VALUES IN ORDERS
-- ============================================================
-- Purpose:
-- Check whether important fields in the orders table contain
-- missing (NULL) values before performing analysis.

SELECT
    COUNT(*) AS total_rows,
    COUNT(`Order Id`) AS order_id_present,
    COUNT(`Customer ID`) AS customer_id_present,
    COUNT(`Product ID`) AS product_id_present,
    COUNT(Qty) AS qty_present,
    COUNT(`Discount %`) AS discount_present,
    COUNT(`Order Status`) AS order_status_present
FROM orders;


-- ============================================================
-- 2. CHECK FOR DUPLICATE ORDER IDs
-- ============================================================
-- Purpose:
-- Each Order ID should represent one order record.
-- Duplicate Order IDs could cause sales and order counts
-- to be overstated.

SELECT
    `Order Id`,
    COUNT(*) AS order_count
FROM orders
GROUP BY `Order Id`
HAVING COUNT(*) > 1;


-- ============================================================
-- 3. CHECK QUANTITY AND DISCOUNT RANGES
-- ============================================================
-- Purpose:
-- Validate whether quantity and discount values fall within
-- reasonable ranges in the dataset.

SELECT
    MIN(Qty) AS min_qty,
    MAX(Qty) AS max_qty,
    MIN(`Discount %`) AS min_discount,
    MAX(`Discount %`) AS max_discount
FROM orders;


-- ============================================================
-- 4. CHECK FOR MISSING PRODUCT PRICES
-- ============================================================
-- Purpose:
-- Cost Price and Selling Price are required for calculating
-- sales, cost and profit.

SELECT
    COUNT(*) AS total_products,
    COUNT(`Cost Price`) AS cost_price_present,
    COUNT(`Selling Price`) AS selling_price_present
FROM products;


-- ============================================================
-- 5. CHECK FOR INVALID PRODUCT PRICES
-- ============================================================
-- Purpose:
-- Identify products with zero or negative cost/selling prices.

SELECT
    `Product ID`,
    `Product Name`,
    `Cost Price`,
    `Selling Price`
FROM products
WHERE `Cost Price` <= 0
   OR `Selling Price` <= 0;


-- ============================================================
-- 6. CHECK FOR SELLING PRICE BELOW COST PRICE
-- ============================================================
-- Purpose:
-- Identify products where Selling Price is lower than Cost Price.
-- Such records may represent loss-making products and should
-- be investigated before profitability analysis.

SELECT
    `Product ID`,
    `Product Name`,
    `Cost Price`,
    `Selling Price`
FROM products
WHERE `Selling Price` < `Cost Price`;
