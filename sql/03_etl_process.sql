
USE RetailDW;


INSERT INTO dimregion (
    region_id,
    sales_district,
    sales_region
)
SELECT
    CAST(region_id AS UNSIGNED),
    sales_district,
    sales_region
FROM stg_region;

SELECT COUNT(*) FROM dimregion;


INSERT INTO dimproduct (
    product_id,
    product_brand,
    product_name,
    product_sku,
    product_retail_price,
    product_cost,
    product_weight,
    recyclable,
    low_fat
)
SELECT
    CAST(product_id AS UNSIGNED),
    product_brand,
    product_name,
    CAST(product_sku AS UNSIGNED),
    CAST(product_retail_price AS DECIMAL(10,2)),
    CAST(product_cost AS DECIMAL(10,2)),
    CAST(product_weight AS DECIMAL(10,2)),
    CASE WHEN recyclable='1' THEN 1 ELSE 0 END,
    CASE WHEN low_fat='1' THEN 1 ELSE 0 END
FROM stg_products;

SELECT COUNT(*) FROM dimproduct;


INSERT INTO dimcustomer (
    customer_id,
    customer_acct_num,
    first_name,
    last_name,
    customer_address,
    customer_city,
    customer_state_province,
    customer_postal_code,
    customer_country,
    birthdate,
    marital_status,
    yearly_income,
    gender,
    total_children,
    num_children_at_home,
    education,
    acct_open_date,
    member_card,
    occupation,
    homeowner
)
SELECT
    CAST(customer_id AS UNSIGNED),
    CAST(customer_acct_num AS UNSIGNED),
    first_name,
    last_name,
    customer_address,
    customer_city,
    customer_state_province,
    customer_postal_code,
    customer_country,

    STR_TO_DATE(birthdate,'%m/%d/%Y'),

    marital_status,
    yearly_income,
    gender,

    CAST(total_children AS UNSIGNED),
    CAST(num_children_at_home AS UNSIGNED),

    education,

    STR_TO_DATE(acct_open_date,'%m/%d/%Y'),

    member_card,
    occupation,
    homeowner
FROM stg_customers;

SELECT COUNT(*) FROM dimcustomer;


INSERT INTO dimstore (
    store_id,
    region_id,
    store_type,
    store_name,
    store_street_address,
    store_city,
    store_state,
    store_country,
    store_phone,
    first_opened_date,
    last_remodel_date,
    total_sqft,
    grocery_sqft
)
SELECT
    CAST(store_id AS UNSIGNED),
    CAST(region_id AS UNSIGNED),
    store_type,
    store_name,
    store_street_address,
    store_city,
    store_state,
    store_country,
    store_phone,
    STR_TO_DATE(first_opened_date,'%m/%d/%Y'),
    STR_TO_DATE(last_remodel_date,'%m/%d/%Y'),
    CAST(total_sqft AS UNSIGNED),
    CAST(grocery_sqft AS UNSIGNED)
FROM stg_stores;

SELECT COUNT(*) FROM dimstore;


INSERT INTO factsales (
    transaction_date,
    stock_date,
    product_id,
    customer_id,
    store_id,
    quantity
)
SELECT
    STR_TO_DATE(transaction_date,'%m/%d/%Y'),
    STR_TO_DATE(stock_date,'%m/%d/%Y'),
    CAST(product_id AS UNSIGNED),
    CAST(customer_id AS UNSIGNED),
    CAST(store_id AS UNSIGNED),
    CAST(quantity AS UNSIGNED)
FROM stg_sales;

SELECT COUNT(*) FROM factsales;


INSERT INTO factreturns (
    return_date,
    product_id,
    store_id,
    quantity
)
SELECT
    STR_TO_DATE(return_date,'%m/%d/%Y'),
    CAST(product_id AS UNSIGNED),
    CAST(store_id AS UNSIGNED),
    CAST(quantity AS UNSIGNED)
FROM stg_returns;

SELECT COUNT(*) FROM factreturns;


INSERT IGNORE INTO dimdate (date_id)
SELECT DISTINCT transaction_date
FROM factsales

UNION

SELECT DISTINCT stock_date
FROM factsales

UNION

SELECT DISTINCT return_date
FROM factreturns;

SELECT COUNT(*) FROM dimdate;
