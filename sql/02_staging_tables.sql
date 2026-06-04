USE RetailDW;

CREATE TABLE stg_calendar (
    transaction_date VARCHAR(20)
);


CREATE TABLE stg_customers (
    customer_id VARCHAR(50),
    customer_acct_num VARCHAR(50),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    customer_address VARCHAR(255),
    customer_city VARCHAR(100),
    customer_state_province VARCHAR(100),
    customer_postal_code VARCHAR(50),
    customer_country VARCHAR(100),
    birthdate VARCHAR(50),
    marital_status VARCHAR(20),
    yearly_income VARCHAR(50),
    gender VARCHAR(20),
    total_children VARCHAR(20),
    num_children_at_home VARCHAR(20),
    education VARCHAR(100),
    acct_open_date VARCHAR(50),
    member_card VARCHAR(50),
    occupation VARCHAR(100),
    homeowner VARCHAR(20)
);


CREATE TABLE stg_products (
    product_id VARCHAR(50),
    product_brand VARCHAR(100),
    product_name VARCHAR(255),
    product_sku VARCHAR(50),
    product_retail_price VARCHAR(50),
    product_cost VARCHAR(50),
    product_weight VARCHAR(50),
    recyclable VARCHAR(20),
    low_fat VARCHAR(20)
);


CREATE TABLE stg_region (
    region_id VARCHAR(50),
    sales_district VARCHAR(100),
    sales_region VARCHAR(100)
);

CREATE TABLE stg_stores (
    store_id VARCHAR(50),
    region_id VARCHAR(50),
    store_type VARCHAR(100),
    store_name VARCHAR(100),
    store_street_address VARCHAR(255),
    store_city VARCHAR(100),
    store_state VARCHAR(100),
    store_country VARCHAR(100),
    store_phone VARCHAR(50),
    first_opened_date VARCHAR(50),
    last_remodel_date VARCHAR(50),
    total_sqft VARCHAR(50),
    grocery_sqft VARCHAR(50)
);

CREATE TABLE stg_returns (
    return_date VARCHAR(50),
    product_id VARCHAR(50),
    store_id VARCHAR(50),
    quantity VARCHAR(50)
);

CREATE TABLE stg_sales (
    transaction_date VARCHAR(50),
    stock_date VARCHAR(50),
    product_id VARCHAR(50),
    customer_id VARCHAR(50),
    store_id VARCHAR(50),
    quantity VARCHAR(50)
);

