-- ============================================
-- DATABASE CREATION
-- ============================================
CREATE DATABASE IF NOT EXISTS bookstore;
USE bookstore;

-- ============================================
-- TABLE: country
-- ============================================
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    country_code VARCHAR(3) NOT NULL
);

-- Insert realistic country data
INSERT INTO country (country_name, country_code) VALUES 
('United States', 'US'),
('Canada', 'CA'),
('United Kingdom', 'UK'),
('Australia', 'AU'),
('Germany', 'DE'),
('France', 'FR'),
('Japan', 'JP');

-- Select from country
SELECT * FROM country;

-- ============================================
-- TABLE: address_status
-- ============================================
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL,
    description VARCHAR(255)
);

-- Insert more comprehensive address statuses
INSERT INTO address_status (status_name, description) VALUES 
('Primary', 'Customer''s main address for deliveries'),
('Secondary', 'Alternate address for deliveries'),
('Billing', 'Address used for invoicing'),
('Historical', 'No longer in active use'),
('Invalid', 'Address is incorrect or undeliverable');

-- Select with WHERE
SELECT * FROM address_status WHERE status_name = 'Primary';

-- ============================================
-- TABLE: address
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

-- Insert realistic address data
INSERT INTO address (street_address, city, state, postal_code, country_id, status_id)
VALUES 
('1250 Broadway', 'New York', 'NY', '10001', 1, 1),
('350 Victoria St', 'Toronto', 'ON', 'M5B 2K3', 2, 1),
('1 Chome-1-2 Oshiage', 'Sumida City', 'Tokyo', '131-0045', 7, 1),
('96 Euston Rd', 'London', NULL, 'NW1 2DB', 3, 1),
('151 Bloor St W', 'Toronto', 'ON', 'M5S 1S4', 2, 2),
('221B Baker St', 'London', NULL, 'NW1 6XE', 3, 3),
('1600 Amphitheatre Parkway', 'Mountain View', 'CA', '94043', 1, 1);

-- Select with ORDER BY
SELECT * FROM address ORDER BY city ASC;

-- ============================================
-- TABLE: customer
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

-- Insert realistic customer data
INSERT INTO customer (first_name, last_name, email, phone_number, date_of_birth, last_login, is_active)
VALUES 
('Emily', 'Johnson', 'emily.johnson@example.com', '+12125551234', '1985-04-12', '2023-11-15 09:23:45', TRUE),
('Michael', 'Chen', 'michael.chen@example.com', '+14165559876', '1992-08-25', '2023-11-14 14:12:33', TRUE),
('Sophia', 'Martinez', 'sophia.martinez@example.com', '+442071234567', '1978-11-03', '2023-11-10 18:45:21', TRUE),
('James', 'Wilson', 'james.wilson@example.com', '+61398765432', '1990-02-19', '2023-11-12 11:05:17', FALSE),
('Olivia', 'Tanaka', 'olivia.tanaka@example.com', '+81301234567', '1988-07-30', '2023-11-15 16:30:45', TRUE),
('William', 'Brown', 'william.brown@example.com', '+14165551234', '1975-12-08', '2023-11-11 10:15:22', TRUE);

-- Select with LIMIT
SELECT * FROM customer LIMIT 3;

-- ============================================
-- TABLE: customer_address
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

-- Insert realistic customer-address relationships
INSERT INTO customer_address (customer_id, address_id, is_default)
VALUES 
(1, 1, TRUE),
(2, 2, TRUE),
(3, 4, TRUE),
(4, 3, TRUE),
(5, 3, TRUE),
(6, 7, TRUE),
(1, 5, FALSE),
(2, 6, FALSE),
(3, 6, FALSE);

-- Select with JOIN
SELECT c.first_name, c.last_name, a.street_address, a.city, a.postal_code, co.country_name
FROM customer_address ca
JOIN customer c ON ca.customer_id = c.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN country co ON a.country_id = co.country_id;

-- ============================================
-- TABLE: author
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

-- Insert realistic author data
INSERT INTO author (first_name, last_name, date_of_birth, date_of_death, nationality, biography)
VALUES 
('George', 'Orwell', '1903-06-25', '1950-01-21', 'British', 'Eric Arthur Blair, better known by his pen name George Orwell, was an English novelist, essayist, journalist, and critic.'),
('Jane', 'Austen', '1775-12-16', '1817-07-18', 'British', 'Jane Austen was an English novelist known primarily for her six major novels.'),
('Haruki', 'Murakami', '1949-01-12', NULL, 'Japanese', 'Haruki Murakami is a Japanese writer. His novels, essays, and short stories have been bestsellers in Japan and internationally.'),
('Toni', 'Morrison', '1931-02-18', '2019-08-05', 'American', 'Toni Morrison was an American novelist, essayist, book editor, and college professor.'),
('Gabriel', 'García Márquez', '1927-03-06', '2014-04-17', 'Colombian', 'Gabriel García Márquez was a Colombian novelist, short-story writer, screenwriter, and journalist.'),
('Margaret', 'Atwood', '1939-11-18', NULL, 'Canadian', 'Margaret Atwood is a Canadian poet, novelist, literary critic, essayist, and environmental activist.');

-- Select with WHERE
SELECT * FROM author WHERE date_of_death IS NULL;

-- ============================================
-- TABLE: book_language
-- ============================================
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL,
    language_code VARCHAR(5) NOT NULL
);

-- Insert comprehensive language data
INSERT INTO book_language (language_name, language_code)
VALUES 
('English', 'en'),
('French', 'fr'),
('Spanish', 'es'),
('German', 'de'),
('Japanese', 'ja'),
('Chinese', 'zh'),
('Russian', 'ru'),
('Arabic', 'ar');

-- Select all
SELECT * FROM book_language;

-- ============================================
-- TABLE: publisher
-- ============================================
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    website VARCHAR(255),
    founding_year INT
);

-- Insert realistic publisher data
INSERT INTO publisher (name, address, phone, email, website, founding_year)
VALUES 
('Penguin Random House', '1745 Broadway, New York, NY 10019', '+12127824500', 'contact@penguinrandomhouse.com', 'https://www.penguinrandomhouse.com', 2013),
('HarperCollins', '195 Broadway, New York, NY 10007', '+12102072000', 'contact@harpercollins.com', 'https://www.harpercollins.com', 1989),
('Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020', '+12126987000', 'info@simonandschuster.com', 'https://www.simonandschuster.com', 1924),
('Hachette Livre', '43 Quai de Grenelle, 75015 Paris, France', '+33143928000', 'contact@hachette-livre.fr', 'https://www.hachette.com', 1826),
('Macmillan Publishers', '120 Broadway, New York, NY 10271', '+12122461200', 'press@macmillan.com', 'https://us.macmillan.com', 1843),
('Kodansha', '2-12-21 Otowa, Bunkyo, Tokyo 112-8001, Japan', '+81353957000', 'international@kodansha.co.jp', 'https://www.kodansha.co.jp', 1909);

-- Select using pattern
SELECT * FROM publisher WHERE name LIKE '%Random%' OR name LIKE '%Penguin%';

-- ============================================
-- TABLE: book
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
    CHECK (publication_year > 0 AND publication_year <= YEAR(CURRENT_DATE)),
    CHECK (price > 0),
    CHECK (stock_quantity >= 0)
);

-- Insert realistic book data with more details
INSERT INTO book (title, publication_year, isbn, language_id, publisher_id, price, stock_quantity, pages, edition, description)
VALUES 
('1984', 1949, '978-0-452-28423-4', 1, 1, 12.99, 150, 328, 1, 'A dystopian social science fiction novel and cautionary tale.'),
('Pride and Prejudice', 1813, '978-1-5011-7801-3', 1, 2, 9.99, 200, 279, 3, 'A romantic novel of manners set in early 19th century England.'),
('Norwegian Wood', 1987, '978-0-09-944882-5', 5, 6, 15.50, 75, 296, 2, 'A nostalgic story of loss and burgeoning sexuality.'),
('Beloved', 1987, '978-1-5011-7802-0', 1, 2, 14.95, 120, 324, 1, 'A novel about the legacy of slavery.'),
('One Hundred Years of Solitude', 1967, '978-0-06-088328-7', 3, 2, 16.99, 90, 417, 2, 'A landmark magical realism novel.'),
('The Handmaid''s Tale', 1985, '978-0-385-49081-3', 1, 1, 13.75, 180, 311, 1, 'A dystopian novel set in a totalitarian society.'),
('Kafka on the Shore', 2002, '978-1-4000-7926-0', 5, 6, 17.25, 65, 505, 1, 'A metaphysical mind-bender of a novel.'),
('To Kill a Mockingbird', 1960, '978-0-06-112008-4', 1, 2, 11.50, 220, 281, 1, 'A novel about racial injustice in the American South.');

-- Select all
SELECT * FROM book;

-- ============================================
-- TABLE: book_author
-- ============================================
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Insert realistic book-author relationships
INSERT INTO book_author (book_id, author_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 3),
(8, NULL); -- This would normally have an author, but showing it can be NULL if needed

-- Select with JOIN
SELECT b.title, CONCAT(a.first_name, ' ', a.last_name) AS author_name, b.price
FROM book_author ba
JOIN book b ON ba.book_id = b.book_id
JOIN author a ON ba.author_id = a.author_id
ORDER BY b.title;

-- ============================================
-- TABLE: shipping_method
-- ============================================
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    cost DECIMAL(10, 2) NOT NULL,
    delivery_time_days INT,
    is_active BOOLEAN DEFAULT TRUE
);

-- Insert realistic shipping methods
INSERT INTO shipping_method (method_name, description, cost, delivery_time_days, is_active)
VALUES 
('Standard', 'Regular shipping with tracking', 4.99, 5, TRUE),
('Express', 'Faster shipping with priority handling', 9.99, 2, TRUE),
('International', 'Overseas shipping', 14.99, 10, TRUE),
('Free Shipping', 'Free standard shipping on orders over $50', 0.00, 7, TRUE),
('Next Day', 'Guaranteed next business day delivery', 19.99, 1, TRUE),
('Local Pickup', 'Customer picks up from store', 0.00, NULL, TRUE);

-- Select with ORDER BY
SELECT * FROM shipping_method ORDER BY cost ASC;

-- ============================================
-- TABLE: order_status
-- ============================================
CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);

-- Insert comprehensive order statuses
INSERT INTO order_status (status_name, description, is_active)
VALUES 
('Pending', 'Order received but not processed', TRUE),
('Processing', 'Order is being prepared for shipment', TRUE),
('Shipped', 'Order has been shipped to customer', TRUE),
('Delivered', 'Order has been delivered to customer', TRUE),
('Cancelled', 'Order was cancelled', TRUE),
('Returned', 'Order was returned by customer', TRUE),
('Refunded', 'Order was refunded', TRUE),
('On Hold', 'Order is on hold pending further action', TRUE);

-- Select all
SELECT * FROM order_status;

-- ============================================
-- TABLE: cust_order
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
    FOREIGN KEY (billing_address_id) REFERENCES address(address_id)
);

-- Insert realistic order data
INSERT INTO cust_order (customer_id, shipping_method_id, order_status_id, shipping_address_id, billing_address_id, total_amount, tax_amount, shipping_cost, notes)
VALUES 
(1, 1, 3, 1, 1, 37.97, 3.04, 4.99, 'Gift wrapping requested'),
(2, 2, 4, 2, 2, 62.48, 5.00, 9.99, 'Deliver to front desk'),
(3, 3, 2, 4, 6, 45.25, 3.62, 14.99, 'International shipping - customs form required'),
(4, 4, 1, 3, 3, 89.97, 7.20, 0.00, NULL),
(5, 1, 3, 3, 3, 32.50, 2.60, 4.99, 'Customer will call to confirm delivery time'),
(6, 5, 5, 7, 7, 55.75, 4.46, 19.99, 'Order cancelled by customer');

-- Select with JOIN
SELECT 
    o.order_id, 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date, 
    sm.method_name AS shipping_method, 
    os.status_name AS order_status,
    o.total_amount,
    o.shipping_cost
FROM cust_order o
JOIN customer c ON o.customer_id = c.customer_id
JOIN shipping_method sm ON o.shipping_method_id = sm.shipping_method_id
JOIN order_status os ON o.order_status_id = os.order_status_id
ORDER BY o.order_date DESC;

-- ============================================
-- TABLE: order_line
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
    CHECK (price_per_unit > 0)
);

-- Insert realistic order line items
INSERT INTO order_line (order_id, book_id, quantity, price_per_unit, discount)
VALUES 
(1, 1, 1, 12.99, 0.00),
(1, 2, 2, 9.99, 1.00),
(2, 3, 1, 15.50, 0.50),
(2, 4, 1, 14.95, 0.00),
(2, 5, 1, 16.99, 0.00),
(3, 6, 2, 13.75, 1.25),
(3, 7, 1, 17.25, 0.00),
(4, 8, 3, 11.50, 0.50),
(4, 1, 2, 12.99, 1.00),
(5, 2, 1, 9.99, 0.00),
(5, 4, 1, 14.95, 0.00),
(6, 5, 1, 16.99, 0.00),
(6, 6, 1, 13.75, 0.00),
(6, 7, 1, 17.25, 0.00),
(6, 8, 1, 11.50, 0.00);

-- Select with JOIN
SELECT 
    ol.order_line_id, 
    b.title, 
    ol.quantity, 
    ol.price_per_unit,
    (ol.quantity * ol.price_per_unit - ol.discount) AS line_total
FROM order_line ol
JOIN book b ON ol.book_id = b.book_id
ORDER BY ol.order_id, ol.order_line_id;

-- ============================================
-- TABLE: order_history
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

-- Insert realistic order history data
INSERT INTO order_history (order_id, status_id, status_change_date, notes)
VALUES 
(1, 1, '2023-11-01 10:15:22', 'Order placed by customer'),
(1, 2, '2023-11-01 14:30:45', 'Order processed and packed'),
(1, 3, '2023-11-02 09:05:33', 'Shipped via standard shipping'),
(2, 1, '2023-11-05 16:22:10', 'Order placed by customer'),
(2, 2, '2023-11-06 10:45:12', 'Order processed and packed'),
(2, 3, '2023-11-06 14:15:08', 'Shipped via express shipping'),
(2, 4, '2023-11-08 11:30:00', 'Delivered to customer'),
(3, 1, '2023-11-10 08:12:45', 'Order placed by customer'),
(3, 2, '2023-11-10 15:22:33', 'Order processed and packed'),
(4, 1, '2023-11-12 19:05:17', 'Order placed by customer'),
(5, 1, '2023-11-14 11:30:22', 'Order placed by customer'),
(5, 2, '2023-11-14 16:45:10', 'Order processed and packed'),
(5, 3, '2023-11-15 09:15:00', 'Shipped via standard shipping'),
(6, 1, '2023-11-15 14:30:45', 'Order placed by customer'),
(6, 5, '2023-11-15 16:45:12', 'Order cancelled by customer request');

-- Select with JOIN and filter
SELECT 
    oh.history_id,
    o.order_id,
    os.status_name,
    oh.status_change_date,
    oh.notes
FROM order_history oh
JOIN cust_order o ON oh.order_id = o.order_id
JOIN order_status os ON oh.status_id = os.order_status_id
WHERE o.order_id = 1
ORDER BY oh.status_change_date;
