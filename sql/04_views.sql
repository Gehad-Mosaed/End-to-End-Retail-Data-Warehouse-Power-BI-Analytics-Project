USE RetailDW;

-- Customer Sales View
CREATE OR REPLACE VIEW vw_customer_sales AS
SELECT

    dc.customer_id,

    CONCAT(dc.first_name,' ',dc.last_name)
    AS customer_name,

    dc.gender,
    dc.yearly_income,
    dc.member_card,

    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS total_sales,

    COUNT(*) AS total_orders,

    SUM(fs.quantity) AS units_purchased

FROM factsales fs
JOIN dimcustomer dc
    ON fs.customer_id = dc.customer_id
JOIN dimproduct dp
    ON fs.product_id = dp.product_id

GROUP BY
    dc.customer_id,
    customer_name,
    dc.gender,
    dc.yearly_income,
    dc.member_card;	
SELECT * FROM vw_customer_sales LIMIT 5;




-- Sales Detail View
CREATE OR REPLACE VIEW vw_sales_detail AS
SELECT
    fs.sales_id,
    fs.transaction_date,
    fs.stock_date,

    dc.customer_id,
    CONCAT(dc.first_name,' ',dc.last_name) AS customer_name,
    dc.gender,
    dc.yearly_income,
    dc.member_card,

    dp.product_id,
    dp.product_name,
    dp.product_brand,
    dp.product_retail_price,
    dp.product_cost,

    ds.store_id,
    ds.store_name,
    ds.store_type,

    dr.sales_region,
    dr.sales_district,

    fs.quantity,

    fs.quantity * dp.product_retail_price AS sales_amount,

    fs.quantity *
    (dp.product_retail_price - dp.product_cost)
    AS profit

FROM factsales fs
JOIN dimcustomer dc
    ON fs.customer_id = dc.customer_id
JOIN dimproduct dp
    ON fs.product_id = dp.product_id
JOIN dimstore ds
    ON fs.store_id = ds.store_id
JOIN dimregion dr
    ON ds.region_id = dr.region_id;
    
    
SELECT * FROM vw_sales_detail LIMIT 5;


-- Returns Detail View
CREATE OR REPLACE VIEW vw_returns_detail AS
SELECT
    fr.return_id,
    fr.return_date,

    dp.product_id,
    dp.product_name,
    dp.product_brand,

    ds.store_id,
    ds.store_name,

    dr.sales_region,

    fr.quantity AS returned_quantity

FROM factreturns fr
JOIN dimproduct dp
    ON fr.product_id = dp.product_id
JOIN dimstore ds
    ON fr.store_id = ds.store_id
JOIN dimregion dr
    ON ds.region_id = dr.region_id;
    
SELECT * FROM vw_returns_detail LIMIT 5;


-- Monthly Sales View
CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT

    YEAR(fs.transaction_date) AS sales_year,
    MONTH(fs.transaction_date) AS sales_month,

    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS revenue,

    SUM(fs.quantity) AS units_sold,

    COUNT(*) AS orders_count

FROM factsales fs
JOIN dimproduct dp
    ON fs.product_id = dp.product_id

GROUP BY
    YEAR(fs.transaction_date),
    MONTH(fs.transaction_date);
    
SELECT * FROM vw_monthly_sales;


-- Product Performance View
CREATE OR REPLACE VIEW vw_product_performance AS
SELECT

    dp.product_id,
    dp.product_name,
    dp.product_brand,

    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS revenue,

    SUM(fs.quantity) AS units_sold,

    ROUND(
        SUM(
            fs.quantity *
            (dp.product_retail_price - dp.product_cost)
        ),
        2
    ) AS profit

FROM factsales fs
JOIN dimproduct dp
    ON fs.product_id = dp.product_id

GROUP BY
    dp.product_id,
    dp.product_name,
    dp.product_brand;
    
    
SELECT *
FROM vw_product_performance
ORDER BY revenue DESC
LIMIT 10;
