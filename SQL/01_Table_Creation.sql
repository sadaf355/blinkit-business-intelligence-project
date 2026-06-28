CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    area VARCHAR(100),
    pincode VARCHAR(10),
    registration_date DATE,
    customer_segment VARCHAR(20),
    total_orders INT,
    avg_order_value NUMERIC(10,2)
);

CREATE TABLE products (
    product_id BIGINT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    brand VARCHAR(150),
    price NUMERIC(10,2),
    mrp NUMERIC(10,2),
    margin_percentage NUMERIC(5,2),
    shelf_life_days INT,
    min_stock_level INT,
    max_stock_level INT
);

CREATE TABLE orders (
    order_id BIGINT PRIMARY KEY,
    customer_id BIGINT,
    order_date TIMESTAMP,
    promised_delivery_time TIMESTAMP,
    actual_delivery_time TIMESTAMP,
    delivery_status VARCHAR(50),
    order_total NUMERIC(10,2),
    payment_method VARCHAR(50),
    delivery_partner_id BIGINT,
    store_id BIGINT,

    CONSTRAINT fk_customer
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_id BIGINT,
    product_id BIGINT,
    quantity INT,
    unit_price NUMERIC(10,2),

    CONSTRAINT fk_order
    FOREIGN KEY(order_id)
    REFERENCES orders(order_id),

    CONSTRAINT fk_product
    FOREIGN KEY(product_id)
    REFERENCES products(product_id)
);

CREATE TABLE delivery_performance (
    order_id BIGINT,
    delivery_partner_id BIGINT,
    promised_time TIMESTAMP,
    actual_time TIMESTAMP,
    delivery_time_minutes INT,
    distance_km NUMERIC(6,2),
    delivery_status VARCHAR(50),
    reasons_if_delayed VARCHAR(100),

    CONSTRAINT fk_delivery_order
    FOREIGN KEY(order_id)
    REFERENCES orders(order_id)
);

CREATE TABLE customer_feedback (
    feedback_id BIGINT PRIMARY KEY,
    order_id BIGINT,
    customer_id BIGINT,
    rating INT,
    feedback_text TEXT,
    feedback_category VARCHAR(50),
    sentiment VARCHAR(20),
    feedback_date DATE,

    CONSTRAINT fk_feedback_order
    FOREIGN KEY(order_id)
    REFERENCES orders(order_id),

    CONSTRAINT fk_feedback_customer
    FOREIGN KEY(customer_id)
    REFERENCES customers(customer_id)
);

CREATE TABLE marketing_performance (
    campaign_id BIGINT PRIMARY KEY,
    campaign_name VARCHAR(100),
    date DATE,
    target_audience VARCHAR(50),
    channel VARCHAR(50),
    impressions INT,
    clicks INT,
    conversions INT,
    spend NUMERIC(12,2),
    revenue_generated NUMERIC(12,2),
    roas NUMERIC(8,2)
);

CREATE TABLE inventory (
    product_id BIGINT,
    date DATE,
    stock_received INT,
    damaged_stock INT,

    CONSTRAINT fk_inventory_product
    FOREIGN KEY(product_id)
    REFERENCES products(product_id)
);