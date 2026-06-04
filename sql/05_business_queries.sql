USE RetailDW;

-- KPIs

### Total Sales
SELECT
    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS Total_Sales
FROM factsales fs
JOIN dimproduct dp
    ON fs.product_id = dp.product_id;
    
    
### Total Orders
SELECT COUNT(*) AS Total_Orders
FROM factsales;

###  Average Order Value
SELECT
ROUND(
    SUM(fs.quantity * dp.product_retail_price)
    /
    COUNT(*)
,2) AS Average_Order_Value
FROM factsales fs
JOIN dimproduct dp
    ON fs.product_id = dp.product_id;
    
    
###  Total Sold Units
SELECT SUM(quantity) AS Total_Sold_Units
FROM factsales;


###  Total Returned Units
SELECT SUM(quantity) AS Total_Returned_Units
FROM factreturns;

    
###  Return Rate %
SELECT
    ROUND(
        (
            (SELECT SUM(quantity) FROM factreturns)
            /
            (SELECT SUM(quantity) FROM factsales)
        ) * 100,
        2
    ) AS Return_Rate_Percentage;
    
    
    
-- Top Analysis

###  Top Products by Revenue
SELECT
    dp.product_name,
    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS Revenue
FROM factsales fs
JOIN dimproduct dp
    ON fs.product_id = dp.product_id
GROUP BY dp.product_name
ORDER BY Revenue DESC
LIMIT 10;


### Top Stores by Revenue
SELECT
    ds.store_name,
    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS Revenue
FROM factsales fs
JOIN dimproduct dp
    ON fs.product_id = dp.product_id
JOIN dimstore ds
    ON fs.store_id = ds.store_id
GROUP BY ds.store_name
ORDER BY Revenue DESC
LIMIT 10;


###  Top Customers by Revenue
SELECT
    CONCAT(dc.first_name,' ',dc.last_name) AS Customer_Name,
    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS Revenue
FROM factsales fs
JOIN dimcustomer dc
    ON fs.customer_id = dc.customer_id
JOIN dimproduct dp
    ON fs.product_id = dp.product_id
GROUP BY dc.customer_id, Customer_Name
ORDER BY Revenue DESC
LIMIT 10;


###  Top Returned Products
SELECT
    dp.product_name,
    SUM(fr.quantity) AS Returned_Qty
FROM factreturns fr
JOIN dimproduct dp
    ON fr.product_id = dp.product_id
GROUP BY dp.product_name
ORDER BY Returned_Qty DESC
LIMIT 10;



-- Regional Analysis

###  Revenue by Sales Region
SELECT
    dr.sales_region,
    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS Revenue
FROM factsales fs
JOIN dimproduct dp
    ON fs.product_id = dp.product_id
JOIN dimstore ds
    ON fs.store_id = ds.store_id
JOIN dimregion dr
    ON ds.region_id = dr.region_id
GROUP BY dr.sales_region
ORDER BY Revenue DESC;


-- Customer Analysis

### Revenue by Gender
SELECT
    dc.gender,
    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS Revenue
FROM factsales fs
JOIN dimcustomer dc
    ON fs.customer_id = dc.customer_id
JOIN dimproduct dp
    ON fs.product_id = dp.product_id
GROUP BY dc.gender;


###  Revenue by Income Group
SELECT
    dc.yearly_income,
    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS Revenue
FROM factsales fs
JOIN dimcustomer dc
    ON fs.customer_id = dc.customer_id
JOIN dimproduct dp
    ON fs.product_id = dp.product_id
GROUP BY dc.yearly_income
ORDER BY Revenue DESC;


###  Revenue by Member Card
SELECT
    dc.member_card,
    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS Revenue
FROM factsales fs
JOIN dimcustomer dc
    ON fs.customer_id = dc.customer_id
JOIN dimproduct dp
    ON fs.product_id = dp.product_id
GROUP BY dc.member_card
ORDER BY Revenue DESC;


-- Time Analysis


###  Revenue by Month
SELECT
    YEAR(transaction_date) AS Year_,
    MONTH(transaction_date) AS Month_,
    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS Revenue
FROM factsales fs
JOIN dimproduct dp
    ON fs.product_id = dp.product_id
GROUP BY
    YEAR(transaction_date),
    MONTH(transaction_date)
ORDER BY
    Year_,
    Month_;
    
    
###  Revenue by Quarter
SELECT
    YEAR(transaction_date) AS Year_,
    QUARTER(transaction_date) AS Quarter_,
    ROUND(
        SUM(fs.quantity * dp.product_retail_price),
        2
    ) AS Revenue
FROM factsales fs
JOIN dimproduct dp
    ON fs.product_id = dp.product_id
GROUP BY
    YEAR(transaction_date),
    QUARTER(transaction_date)
ORDER BY
    Year_,
    Quarter_;