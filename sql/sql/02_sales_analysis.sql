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
