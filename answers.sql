-- ============================================
-- DATABASE CREATION
-- ============================================
CREATE DATABASE IF NOT EXISTS bookstore;
USE bookstore;

-- ============================================
-- TABLE: country
-- Stores countries where addresses are located
-- ============================================
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    country_code VARCHAR(3) NOT NULL,
    UNIQUE (country_name),
    UNIQUE (country_code)
);

-- Insert African countries
INSERT INTO country (country_name, country_code) VALUES 
('Nigeria', 'NG'),
('South Africa', 'ZA'),
('Kenya', 'KE'),
('Ghana', 'GH'),
('Egypt', 'EG'),
('Ethiopia', 'ET'),
('Morocco', 'MA'),
('Senegal', 'SN'),
('Tanzania', 'TZ'),
('Uganda', 'UG');

-- ============================================
-- TABLE: address_status
-- Stores possible statuses for addresses
-- ============================================
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    UNIQUE (status_name)
);

-- Insert address statuses
INSERT INTO address_status (status_name, description) VALUES 
('Primary', 'Customer''s main address for deliveries'),
('Secondary', 'Alternate address for deliveries'),
('Billing', 'Address used for invoicing'),
('Historical', 'No longer in active use'),
('Invalid', 'Address is incorrect or undeliverable');

-- ============================================
-- TABLE: address
-- Stores address details
-- ============================================
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20) NOT NULL,
    country_id INT NOT NULL,
    status_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Insert African addresses
INSERT INTO address (street_address, city, state, postal_code, country_id, status_id) VALUES 
('25 Adeola Odeku Street', 'Lagos', 'Lagos', '101241', 1, 1),
('44 Stanley Avenue', 'Johannesburg', 'Gauteng', '2092', 2, 1),
('Mama Ngina Street', 'Nairobi', NULL, '00100', 3, 1),
('24 Oxford Street', 'Accra', 'Greater Accra', 'GA1', 4, 1),
('15 Nile Street', 'Cairo', 'Cairo Governorate', '11511', 5, 1),
('22 Bole Road', 'Addis Ababa', NULL, '1000', 6, 2),
('Avenue Mohammed V', 'Casablanca', NULL, '20000', 7, 1),
('Rue de la République', 'Dakar', NULL, '12500', 8, 1),
('Ohio Street', 'Dar es Salaam', NULL, '14110', 9, 3),
('7 Acacia Avenue', 'Kampala', NULL, '256', 10, 1);

-- ============================================
-- TABLE: customer
-- Stores customer information
-- ============================================
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    date_of_birth DATE,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Insert African customers
INSERT INTO customer (first_name, last_name, email, phone_number, date_of_birth, last_login, is_active) VALUES 
('Adebayo', 'Ogunlesi', 'adebayo.ogunlesi@example.com', '+2348012345678', '1985-04-12', '2025-04-10 09:23:45', TRUE),
('Naledi', 'Moloi', 'naledi.moloi@example.com', '+27111234567', '1992-08-25', '2025-04-09 14:12:33', TRUE),
('Wanjiru', 'Kamau', 'wanjiru.kamau@example.com', '+254712345678', '1978-11-03', '2025-04-08 18:45:21', TRUE),
('Kwame', 'Asante', 'kwame.asante@example.com', '+233241234567', '1990-02-19', '2025-04-07 11:05:17', TRUE),
('Amina', 'Diallo', 'amina.diallo@example.com', '+221771234567', '1988-07-30', '2025-04-06 16:30:45', TRUE),
('Thando', 'Mbeki', 'thando.mbeki@example.com', '+27721234567', '1975-12-08', '2025-04-05 10:15:22', TRUE);

-- ============================================
-- TABLE: customer_address
-- Manages customer-address relationships
-- ============================================
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    is_default BOOLEAN DEFAULT FALSE,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Insert customer-address relationships
INSERT INTO customer_address (customer_id, address_id, is_default) VALUES 
(1, 1, TRUE),
(2, 2, TRUE),
(3, 3, TRUE),
(4, 4, TRUE),
(5, 8, TRUE),
(6, 2, TRUE),
(1, 9, FALSE),
(2, 6, FALSE),
(3, 10, FALSE);

-- ============================================
-- TABLE: author
-- Stores author information
-- ============================================
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    date_of_death DATE,
    nationality VARCHAR(100),
    biography TEXT
);

-- Insert African authors
INSERT INTO author (first_name, last_name, date_of_birth, date_of_death, nationality, biography) VALUES 
('Chinua', 'Achebe', '1930-11-16', '2013-03-21', 'Nigerian', 'Chinua Achebe was a Nigerian novelist, poet, and critic, regarded as a dominant figure in African literature.'),
('Ngũgĩ wa', 'Thiong''o', '1938-01-05', NULL, 'Kenyan', 'Ngũgĩ wa Thiong''o is a Kenyan writer and academic who writes in Gikuyu and English.'),
('Nadine', 'Gordimer', '1923-11-20', '2014-07-13', 'South African', 'Nadine Gordimer was a South African writer and activist, Nobel Prize winner in 1991.'),
('Wole', 'Soyinka', '1934-07-13', NULL, 'Nigerian', 'Wole Soyinka is a Nigerian playwright, poet, and essayist, Nobel Prize winner in 1986.'),
('Buchi', 'Emecheta', '1944-07-21', '2017-01-25', 'Nigerian', 'Buchi Emecheta was a Nigerian novelist focusing on women''s experiences.'),
('Tsitsi', 'Dangarembga', '1959-02-04', NULL, 'Zimbabwean', 'Tsitsi Dangarembga is a Zimbabwean novelist and filmmaker, known for Nervous Conditions.'),
('Alaa', 'Al Aswany', '1957-05-26', NULL, 'Egyptian', 'Alaa Al Aswany is an Egyptian writer, known for The Yacoubian Building.'),
('Mariama', 'Bâ', '1929-04-17', '1981-08-17', 'Senegalese', 'Mariama Bâ was a Senegalese author and feminist.'),
('Chimamanda Ngozi', 'Adichie', '1977-09-15', NULL, 'Nigerian', 'Chimamanda Ngozi Adichie is a Nigerian novelist known for Half of a Yellow Sun.');

-- ============================================
-- TABLE: book_language
-- Stores possible book languages
-- ============================================
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL,
    language_code VARCHAR(5) NOT NULL,
    UNIQUE (language_name),
    UNIQUE (language_code)
);

-- Insert languages, including African languages
INSERT INTO book_language (language_name, language_code) VALUES 
('English', 'en'),
('French', 'fr'),
('Arabic', 'ar'),
('Swahili', 'sw'),
('Yoruba', 'yo'),
('Zulu', 'zu'),
('Amharic', 'am'),
('Hausa', 'ha');

-- ============================================
-- TABLE: publisher
-- Stores publisher information
-- ============================================
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    website VARCHAR(255),
    founding_year INT,
    UNIQUE (name)
);

-- Insert African publishers
INSERT INTO publisher (name, address, phone, email, website, founding_year) VALUES 
('Cassava Republic Press', '1 Adebola Street, Lagos, Nigeria', '+23414480355', 'info@cassavarepublic.biz', 'https://cassavarepublic.biz', 2006),
('Kwela Books', 'PO Box 6525, Roggebaai, Cape Town, South Africa', '+27214261104', 'info@kwela.com', 'https://www.kwela.com', 1994),
('East African Educational Publishers', 'Marshalls Lane, Nairobi, Kenya', '+25420224077', 'info@eastafricanpublishers.com', 'https://eastafricanpublishers.com', 1965),
('Sub-Saharan Publishers', 'PO Box 358, Legon, Ghana', '+233302500396', 'sub-saharan@ighmail.com', NULL, 1992),
('African Books Collective', 'PO Box 721, Oxford OX1 9EN, UK', '+441865726686', 'orders@africanbookscollective.com', 'https://www.africanbookscollective.com', 1985),
('Kachifo Limited', '8 Norman Williams Street, Lagos, Nigeria', '+23417002345', 'hello@kachifo.com', 'https://kachifo.com', 2004);

-- ============================================
-- TABLE: book
-- Stores book information
-- ============================================
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year INT,
    isbn VARCHAR(17) UNIQUE NOT NULL,
    language_id INT,
    publisher_id INT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    pages INT,
    edition INT,
    description TEXT,
    cover_image VARCHAR(255),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    CHECK (publication_year > 0),
    CHECK (price > 0),
    CHECK (stock_quantity >= 0)
);

-- Insert African literature books
INSERT INTO book (title, publication_year, isbn, language_id, publisher_id, price, stock_quantity, pages, edition, description) VALUES 
('Things Fall Apart', 1958, '978-0-435-90526-4', 1, 1, 14.99, 200, 209, 1, 'Chinua Achebe''s masterpiece about the clash of traditional African culture and colonial influence.'),
('Half of a Yellow Sun', 2006, '978-0-00-720028-3', 1, 1, 16.50, 150, 433, 2, 'Chimamanda Ngozi Adichie''s novel about the Nigeria-Biafra war.'),
('Nervous Conditions', 1988, '978-0-9547023-6-5', 1, 2, 12.75, 120, 204, 1, 'Tsitsi Dangarembga''s coming-of-age story set in colonial Rhodesia.'),
('The Yacoubian Building', 2002, '978-977-424-891-7', 3, 6, 15.25, 90, 254, 1, 'Alaa Al Aswany''s novel about Egyptian society.'),
('So Long a Letter', 1979, '978-0-435-90650-6', 2, 5, 11.99, 110, 96, 1, 'Mariama Bâ''s epistolary novel about women in Senegalese society.'),
('Petals of Blood', 1977, '978-0-435-90580-6', 1, 3, 13.50, 85, 360, 1, 'Ngũgĩ wa Thiong''o''s novel about post-colonial Kenya.'),
('The Joys of Motherhood', 1979, '978-0-435-90648-3', 1, 5, 12.25, 130, 224, 1, 'Buchi Emecheta''s novel about a Nigerian woman in Lagos.'),
('July''s People', 1981, '978-0-14-006140-6', 1, 2, 10.99, 95, 160, 1, 'Nadine Gordimer''s novel set during a fictional South African civil war.');

-- ============================================
-- TABLE: book_author
-- Manages book-author relationships
-- ============================================
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Insert book-author relationships
INSERT INTO book_author (book_id, author_id) VALUES 
(1, 1), -- Things Fall Apart - Chinua Achebe
(2, 9), -- Half of a Yellow Sun - Chimamanda Ngozi Adichie
(3, 6), -- Nervous Conditions - Tsitsi Dangarembga
(4, 7), -- The Yacoubian Building - Alaa Al Aswany
(5, 8), -- So Long a Letter - Mariama Bâ
(6, 2), -- Petals of Blood - Ngũgĩ wa Thiong'o
(7, 5), -- The Joys of Motherhood - Buchi Emecheta
(8, 3); -- July's People - Nadine Gordimer

-- ============================================
-- TABLE: shipping_method
-- Stores possible shipping methods
-- ============================================
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    cost DECIMAL(10, 2) NOT NULL,
    delivery_time_days INT,
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE (method_name),
    CHECK (cost >= 0)
);

-- Insert shipping methods
INSERT INTO shipping_method (method_name, description, cost, delivery_time_days, is_active) VALUES 
('Standard', 'Regular shipping with tracking', 5.99, 7, TRUE),
('Express', 'Faster shipping with priority handling', 12.99, 3, TRUE),
('Intra-Africa', 'Shipping within Africa', 9.99, 10, TRUE),
('Free Shipping', 'Free shipping on orders over $50', 0.00, 10, TRUE),
('Next Day', 'Guaranteed next day delivery (major cities)', 24.99, 1, TRUE),
('Local Pickup', 'Customer picks up from store', 0.00, NULL, TRUE);

-- ============================================
-- TABLE: order_status
-- Stores possible order statuses
-- ============================================
CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    UNIQUE (status_name)
);

-- Insert order statuses
INSERT INTO order_status (status_name, description, is_active) VALUES 
('Pending', 'Order received but not processed', TRUE),
('Processing', 'Order is being prepared for shipment', TRUE),
('Shipped', 'Order has been shipped to customer', TRUE),
('Delivered', 'Order has been delivered to customer', TRUE),
('Cancelled', 'Order was cancelled', TRUE),
('Returned', 'Order was returned by customer', TRUE),
('Refunded', 'Order was refunded', TRUE),
('On Hold', 'Order is on hold pending further action', TRUE);

-- ============================================
-- TABLE: cust_order
-- Stores customer orders
-- ============================================
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT NOT NULL,
    order_status_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    billing_address_id INT NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL,
    tax_amount DECIMAL(10, 2) NOT NULL,
    shipping_cost DECIMAL(10, 2) NOT NULL,
    notes TEXT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id),
    FOREIGN KEY (billing_address_id) REFERENCES address(address_id),
    CHECK (total_amount >= 0),
    CHECK (tax_amount >= 0),
    CHECK (shipping_cost >= 0)
);

-- Insert customer orders
INSERT INTO cust_order (customer_id, shipping_method_id, order_status_id, shipping_address_id, billing_address_id, total_amount, tax_amount, shipping_cost, notes) VALUES 
(1, 1, 3, 1, 1, 42.97, 3.44, 5.99, 'Gift wrapping requested'),
(2, 2, 4, 2, 2, 67.48, 5.40, 12.99, 'Deliver to front desk'),
(3, 3, 2, 3, 3, 50.25, 4.02, 9.99, 'Intra-Africa shipping'),
(4, 4, 1, 4, 4, 94.97, 7.60, 0.00, NULL),
(5, 1, 3, 8, 8, 37.50, 3.00, 5.99, 'Customer will call to confirm delivery'),
(6, 5, 5, 2, 2, 60.75, 4.86, 24.99, 'Urgent delivery requested');

-- ============================================
-- TABLE: order_line
-- Stores books in each order
-- ============================================
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    CHECK (quantity > 0),
    CHECK (price_per_unit > 0),
    CHECK (discount >= 0)
);

-- Insert order line items
INSERT INTO order_line (order_id, book_id, quantity, price_per_unit, discount) VALUES 
(1, 1, 1, 14.99, 0.00),
(1, 2, 2, 16.50, 1.00),
(2, 3, 1, 12.75, 0.50),
(2, 4, 1, 15.25, 0.00),
(2, 5, 1, 11.99, 0.00),
(3, 6, 2, 13.50, 1.25),
(3, 7, 1, 12.25, 0.00),
(4, 8, 3, 10.99, 0.50),
(4, 1, 2, 14.99, 1.00),
(5, 2, 1, 16.50, 0.00),
(5, 4, 1, 15.25, 0.00),
(6, 5, 1, 11.99, 0.00),
(6, 6, 1, 13.50, 0.00);

-- ============================================
-- TABLE: order_history
-- Stores order status history
-- ============================================
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(order_status_id)
);

-- Insert order history
INSERT INTO order_history (order_id, status_id, status_change_date, notes) VALUES 
(1, 1, '2025-04-01 10:15:22', 'Order placed by customer'),
(1, 2, '2025-04-01 14:30:45', 'Order processed and packed'),
(1, 3, '2025-04-02 09:05:33', 'Shipped via standard shipping'),
(2, 1, '2025-04-03 16:22:10', 'Order placed by customer'),
(2, 2, '2025-04-04 10:45:12', 'Order processed and packed'),
(2, 3, '2025-04-04 14:15:08', 'Shipped via express shipping'),
(2, 4, '2025-04-06 11:30:00', 'Delivered to customer'),
(3, 1, '2025-04-05 08:12:45', 'Order placed by customer'),
(3, 2, '2025-04-05 15:22:33', 'Order processed and packed'),
(4, 1, '2025-04-07 19:05:17', 'Order placed by customer'),
(5, 1, '2025-04-08 11:30:22', 'Order placed by customer'),
(5, 2, '2025-04-08 16:45:10', 'Order processed and packed'),
(5, 3, '2025-04-09 09:15:00', 'Shipped via standard shipping'),
(6, 1, '2025-04-10 14:30:45', 'Order placed by customer'),
(6, 2, '2025-04-10 16:45:12', 'Order processed and packed');

-- ============================================
-- TRIGGERS
-- Ensure publication year is not in the future
-- ============================================
DELIMITER //
CREATE TRIGGER check_publication_year
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    IF NEW.publication_year > YEAR(CURRENT_DATE()) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Publication year cannot be in the future';
    END IF;
END//

CREATE TRIGGER check_publication_year_update
BEFORE UPDATE ON book
FOR EACH ROW
BEGIN
    IF NEW.publication_year > YEAR(CURRENT_DATE()) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Publication year cannot be in the future';
    END IF;
END//
DELIMITER ;

-- ============================================
-- USER MANAGEMENT
-- Create roles and users for secure access
-- ============================================
-- Create roles
CREATE ROLE IF NOT EXISTS 'admin_role', 'employee_role', 'customer_role';

-- Grant privileges to roles
GRANT ALL ON bookstore.* TO 'admin_role';
GRANT SELECT, INSERT, UPDATE ON bookstore.book TO 'employee_role';
GRANT SELECT, INSERT, UPDATE ON bookstore.cust_order TO 'employee_role';
GRANT SELECT, INSERT, UPDATE ON bookstore.order_line TO 'employee_role';
GRANT SELECT ON bookstore.author TO 'employee_role';
GRANT SELECT ON bookstore.publisher TO 'employee_role';
GRANT SELECT ON bookstore.book_language TO 'employee_role';
GRANT SELECT ON bookstore.shipping_method TO 'employee_role';
GRANT SELECT ON bookstore.order_status TO 'employee_role';
GRANT SELECT ON bookstore.customer TO 'customer_role';
GRANT SELECT, INSERT, UPDATE ON bookstore.customer_address TO 'customer_role';
GRANT SELECT, INSERT ON bookstore.cust_order TO 'customer_role';
GRANT SELECT, INSERT ON bookstore.order_line TO 'customer_role';
GRANT SELECT ON bookstore.book TO 'customer_role';
GRANT SELECT ON bookstore.author TO 'customer_role';
GRANT SELECT ON bookstore.shipping_method TO 'customer_role';

-- Create users
CREATE USER IF NOT EXISTS 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass123!';
CREATE USER IF NOT EXISTS 'employee_user'@'localhost' IDENTIFIED BY 'EmployeePass456!';
CREATE USER IF NOT EXISTS 'customer_user'@'localhost' IDENTIFIED BY 'CustomerPass789!';

-- Assign roles to users
GRANT 'admin_role' TO 'admin_user'@'localhost';
GRANT 'employee_role' TO 'employee_user'@'localhost';
GRANT 'customer_role' TO 'customer_user'@'localhost';

-- Set default roles
SET DEFAULT ROLE 'admin_role' FOR 'admin_user'@'localhost';
SET DEFAULT ROLE 'employee_role' FOR 'employee_user'@'localhost';
SET DEFAULT ROLE 'customer_role' FOR 'customer_user'@'localhost';

-- ============================================
-- TEST QUERIES
-- Verify data integrity and functionality
-- ============================================

-- Query 1: List all books with their authors
SELECT 
    b.title, 
    CONCAT(a.first_name, ' ', a.last_name) AS author_name, 
    b.price
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
ORDER BY b.title;

-- Query 2: List customer orders with details
SELECT 
    o.order_id, 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date, 
    sm.method_name AS shipping_method, 
    os.status_name AS order_status,
    o.total_amount
FROM cust_order o
JOIN customer c ON o.customer_id = c.customer_id
JOIN shipping_method sm ON o.shipping_method_id = sm.shipping_method_id
JOIN order_status os ON o.order_status_id = os.order_status_id
ORDER BY o.order_date DESC;

-- Query 3: List order lines for a specific order
SELECT 
    ol.order_line_id, 
    b.title, 
    ol.quantity, 
    ol.price_per_unit,
    (ol.quantity * ol.price_per_unit - ol.discount) AS line_total
FROM order_line ol
JOIN book b ON ol.book_id = b.book_id
WHERE ol.order_id = 1;

-- Query 4: List customers with their primary address
SELECT 
    c.first_name, 
    c.last_name, 
    a.street_address, 
    a.city, 
    co.country_name
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN country co ON a.country_id = co.country_id
WHERE ca.is_default = TRUE;

-- Query 5: List books by language
SELECT 
    b.title, 
    bl.language_name
FROM book b
JOIN book_language bl ON b.language_id = bl.language_id
ORDER BY bl.language_name, b.title;
