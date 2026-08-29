-- ============================================================
-- 02 - SALES ANALYSIS
-- ============================================================

-- 1. Calculate overall sales and profitability
-- Purpose:
-- Combine order quantities with product prices to calculate
-- gross sales, discounts, net sales, cost and profit.

SELECT
    SUM(o.Qty * p.`Selling Price`) AS gross_sales,

    SUM(
        (o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100
    ) AS discount_amount,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
    ) AS net_sales,

    SUM(o.Qty * p.`Cost Price`) AS total_cost,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
        - (o.Qty * p.`Cost Price`)
    ) AS profit

FROM orders o
JOIN products p
    ON o.`Product ID` = p.`Product ID`;
-- ============================================================
-- 2. ORDER STATUS ANALYSIS
-- ============================================================
-- Purpose:
-- Understand how orders are distributed across delivered,
-- returned and cancelled statuses.

SELECT
    `Order Status`,
    COUNT(*) AS order_count,
    SUM(Qty) AS total_quantity
FROM orders
GROUP BY `Order Status`
ORDER BY order_count DESC;
-- ============================================================
-- 3. DELIVERED ORDER SALES & PROFITABILITY
-- ============================================================
-- Purpose:
-- Analyze sales and profitability from successfully delivered
-- orders separately from cancelled and returned orders.

SELECT
    SUM(o.Qty * p.`Selling Price`) AS gross_sales,

    SUM(
        (o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100
    ) AS discount_amount,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
    ) AS net_sales,

    SUM(o.Qty * p.`Cost Price`) AS total_cost,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
        - (o.Qty * p.`Cost Price`)
    ) AS profit

FROM orders o
JOIN products p
    ON o.`Product ID` = p.`Product ID`
WHERE o.`Order Status` = 'Delivered';
-- 4. Customer sales and profitability analysis

SELECT
    c.`Customer ID`,
    c.`Customer Name`,
    COUNT(DISTINCT o.`Order Id`) AS total_orders,
    SUM(o.Qty) AS total_quantity,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
    ) AS net_sales,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
        - (o.Qty * p.`Cost Price`)
    ) AS profit

FROM orders o

JOIN customers c
    ON o.`Customer ID` = c.`Customer ID`

JOIN products p
    ON o.`Product ID` = p.`Product ID`

WHERE o.`Order Status` = 'Delivered'

GROUP BY
    c.`Customer ID`,
    c.`Customer Name`

ORDER BY net_sales DESC;
-- ============================================================
-- 5. PRODUCT SALES & PROFITABILITY ANALYSIS
-- ============================================================
-- Purpose:
-- Identify products generating the highest delivered-order
-- sales and profit.

SELECT
    p.`Product ID`,
    p.`Product Name`,
    p.Category,
    p.Brand,
    SUM(o.Qty) AS total_quantity,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
    ) AS net_sales,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
        - (o.Qty * p.`Cost Price`)
    ) AS profit

FROM orders o

JOIN products p
    ON o.`Product ID` = p.`Product ID`

WHERE o.`Order Status` = 'Delivered'

GROUP BY
    p.`Product ID`,
    p.`Product Name`,
    p.Category,
    p.Brand

ORDER BY net_sales DESC;
-- 6. Category sales and profitability analysis

SELECT
    p.Category,
    SUM(o.Qty) AS total_quantity,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
    ) AS net_sales,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
        - (o.Qty * p.`Cost Price`)
    ) AS profit,

    ROUND(
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
            - (o.Qty * p.`Cost Price`)
        )
        /
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
        ) * 100,
        2
    ) AS profit_margin_pct

FROM orders o

JOIN products p
    ON o.`Product ID` = p.`Product ID`

WHERE o.`Order Status` = 'Delivered'

GROUP BY p.Category

ORDER BY net_sales DESC;
-- ============================================================
-- 7. REGIONAL SALES & PROFITABILITY ANALYSIS
-- ============================================================
-- Purpose:
-- Compare delivered sales and profitability across regions.

SELECT
    c.Region,
    SUM(o.Qty) AS total_quantity,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
    ) AS net_sales,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
        - (o.Qty * p.`Cost Price`)
    ) AS profit,

    ROUND(
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
            - (o.Qty * p.`Cost Price`)
        )
        /
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
        ) * 100,
        2
    ) AS profit_margin_pct

FROM orders o

JOIN customers c
    ON o.`Customer ID` = c.`Customer ID`

JOIN products p
    ON o.`Product ID` = p.`Product ID`

WHERE o.`Order Status` = 'Delivered'

GROUP BY c.Region

ORDER BY net_sales DESC;
-- ============================================================
-- 9. AVERAGE ORDER VALUE
-- ============================================================
-- Purpose:
-- Calculate the average net sales generated per delivered order.

SELECT
    COUNT(DISTINCT o.`Order Id`) AS total_delivered_orders,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
    ) AS total_net_sales,

    ROUND(
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
        )
        / COUNT(DISTINCT o.`Order Id`),
        2
    ) AS average_order_value

FROM orders o

JOIN products p
    ON o.`Product ID` = p.`Product ID`

WHERE o.`Order Status` = 'Delivered';
-- ============================================================
-- 10. TOP 10 CUSTOMER SALES CONTRIBUTION
-- ============================================================
-- Purpose:
-- Measure how much of delivered net sales comes from the
-- top 10 customers.

SELECT
    COUNT(*) AS top_10_customers,
    SUM(customer_sales) AS top_10_sales
FROM
(
    SELECT
        c.`Customer ID`,
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
        ) AS customer_sales

    FROM orders o

    JOIN customers c
        ON o.`Customer ID` = c.`Customer ID`

    JOIN products p
        ON o.`Product ID` = p.`Product ID`

    WHERE o.`Order Status` = 'Delivered'

    GROUP BY c.`Customer ID`

    ORDER BY customer_sales DESC
    LIMIT 10
) AS top_customers;
-- 11. TOP 10 PRODUCTS BY PROFIT

SELECT
    p.`Product ID`,
    p.`Product Name`,
    p.Category,
    p.Brand,
    SUM(o.Qty) AS total_quantity,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
        - (o.Qty * p.`Cost Price`)
    ) AS profit,

    ROUND(
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
            - (o.Qty * p.`Cost Price`)
        )
        /
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
        ) * 100,
        2
    ) AS profit_margin_pct

FROM orders o

JOIN products p
    ON o.`Product ID` = p.`Product ID`

WHERE o.`Order Status` = 'Delivered'

GROUP BY
    p.`Product ID`,
    p.`Product Name`,
    p.Category,
    p.Brand

ORDER BY profit DESC
LIMIT 10;
-- ============================================================
-- 12. CATEGORY PRODUCT DEPTH ANALYSIS
-- ============================================================
-- Purpose:
-- Understand whether category performance is driven by
-- multiple products or a smaller number of products.

SELECT
    p.Category,
    COUNT(DISTINCT p.`Product ID`) AS active_products,
    SUM(o.Qty) AS total_quantity,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
    ) AS net_sales,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
        - (o.Qty * p.`Cost Price`)
    ) AS profit,

    ROUND(
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
            - (o.Qty * p.`Cost Price`)
        )
        /
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
        ) * 100,
        2
    ) AS profit_margin_pct

FROM orders o

JOIN products p
    ON o.`Product ID` = p.`Product ID`

WHERE o.`Order Status` = 'Delivered'

GROUP BY p.Category

ORDER BY profit DESC;

-- ============================================================
-- 13. REGIONAL ORDER VALUE ANALYSIS
-- ============================================================
-- Purpose:
-- Compare order value and profitability across regions.

SELECT
    c.Region,

    COUNT(DISTINCT o.`Order Id`) AS delivered_orders,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
    ) AS net_sales,

    SUM(
        (o.Qty * p.`Selling Price`)
        - ((o.Qty * p.`Selling Price`)
        * o.`Discount %` / 100)
        - (o.Qty * p.`Cost Price`)
    ) AS profit,

    ROUND(
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
        )
        / COUNT(DISTINCT o.`Order Id`),
        2
    ) AS average_order_value,

    ROUND(
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
            - (o.Qty * p.`Cost Price`)
        )
        /
        SUM(
            (o.Qty * p.`Selling Price`)
            - ((o.Qty * p.`Selling Price`)
            * o.`Discount %` / 100)
        ) * 100,
        2
    ) AS profit_margin_pct

FROM orders o

JOIN customers c
    ON o.`Customer ID` = c.`Customer ID`

JOIN products p
    ON o.`Product ID` = p.`Product ID`

WHERE o.`Order Status` = 'Delivered'

GROUP BY c.Region

ORDER BY net_sales DESC;

