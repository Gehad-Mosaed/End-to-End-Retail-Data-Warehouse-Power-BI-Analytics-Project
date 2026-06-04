CREATE DATABASE RetailDW;
USE RetailDW;

CREATE TABLE DimDate (
    date_id DATE PRIMARY KEY
);

CREATE TABLE DimCustomer (
    customer_id INT PRIMARY KEY,
    customer_acct_num BIGINT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    customer_address VARCHAR(255),
    customer_city VARCHAR(100),
    customer_state_province VARCHAR(100),
    customer_postal_code VARCHAR(20),
    customer_country VARCHAR(50),
    birthdate DATE,
    marital_status CHAR(1),
    yearly_income VARCHAR(30),
    gender CHAR(1),
    total_children INT,
    num_children_at_home INT,
    education VARCHAR(100),
    acct_open_date DATE,
    member_card VARCHAR(30),
    occupation VARCHAR(100),
    homeowner CHAR(1)
);


CREATE TABLE DimProduct (
    product_id INT PRIMARY KEY,
    product_brand VARCHAR(100),
    product_name VARCHAR(255),
    product_sku BIGINT,
    product_retail_price DECIMAL(10,2),
    product_cost DECIMAL(10,2),
    product_weight DECIMAL(10,2),
    recyclable BOOLEAN,
    low_fat BOOLEAN
);


CREATE TABLE DimRegion (
    region_id INT PRIMARY KEY,
    sales_district VARCHAR(100),
    sales_region VARCHAR(100)
);


CREATE TABLE DimStore (
    store_id INT PRIMARY KEY,
    region_id INT,
    store_type VARCHAR(100),
    store_name VARCHAR(100),
    store_street_address VARCHAR(255),
    store_city VARCHAR(100),
    store_state VARCHAR(100),
    store_country VARCHAR(50),
    store_phone VARCHAR(30),
    first_opened_date DATE,
    last_remodel_date DATE,
    total_sqft INT,
    grocery_sqft INT,
    
    FOREIGN KEY (region_id)
        REFERENCES DimRegion(region_id)
);


CREATE TABLE FactSales (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_date DATE,
    stock_date DATE,
    product_id INT,
    customer_id INT,
    store_id INT,
    quantity INT,

    FOREIGN KEY (product_id)
        REFERENCES DimProduct(product_id),

    FOREIGN KEY (customer_id)
        REFERENCES DimCustomer(customer_id),

    FOREIGN KEY (store_id)
        REFERENCES DimStore(store_id)
);

CREATE TABLE FactReturns (
    return_id INT AUTO_INCREMENT PRIMARY KEY,
    return_date DATE,
    product_id INT,
    store_id INT,
    quantity INT,

    FOREIGN KEY (product_id)
        REFERENCES DimProduct(product_id),

    FOREIGN KEY (store_id)
        REFERENCES DimStore(store_id)
);

