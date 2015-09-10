CREATE TABLE hard_mode_customers
(
  id SERIAL PRIMARY KEY NOT NULL,
  first_name VARCHAR(28) NOT NULL,
  last_name VARCHAR(28) NOT NULL,
  phone CHAR(10) NOT NULL
);
CREATE TABLE hard_mode_manufacturers
(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    website VARCHAR(50) NOT NULL
);
CREATE TABLE hard_mode_orders
(
    id SERIAL PRIMARY KEY NOT NULL,
    date DATE NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES hard_mode_customers (id)
);
CREATE TABLE hard_mode_orders_products
(
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES hard_mode_orders (id),
    FOREIGN KEY (product_id) REFERENCES hard_mode_products (id)
);
CREATE TABLE hard_mode_products
(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    manufacturer_id INT NOT NULL,
    cost NUMERIC(6, 2) NOT NULL,
    retail NUMERIC(6, 2) NOT NULL,
    FOREIGN KEY (manufacturer_id) REFERENCES hard_mode_manufacturers (id)
);
