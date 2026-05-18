-- =========================
-- DROP OLD TABLES
-- =========================
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orderDetails;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS shop;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS users;

-- =========================
-- USERS TABLE
-- =========================
CREATE TABLE users (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user'
);

-- =========================
-- CATEGORY TABLE
-- =========================
CREATE TABLE category (
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- =========================
-- SHOP TABLE
-- =========================
CREATE TABLE shop (
    shopId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    address VARCHAR(255),
    status VARCHAR(50) DEFAULT 'active'
);

-- =========================
-- PRODUCT TABLE
-- =========================
CREATE TABLE product (
    productId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    categoryId INT,
    shopId INT,

    FOREIGN KEY (categoryId)
    REFERENCES category(categoryId)
    ON DELETE SET NULL,

    FOREIGN KEY (shopId)
    REFERENCES shop(shopId)
    ON DELETE SET NULL
);

-- =========================
-- LOCATION TABLE
-- =========================
CREATE TABLE location (
    locationId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    detail VARCHAR(255),
    phone VARCHAR(20),

    FOREIGN KEY (userId)
    REFERENCES users(userId)
    ON DELETE CASCADE
);

-- =========================
-- REVIEW TABLE
-- =========================
CREATE TABLE review (
    reviewId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    shopId INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,

    FOREIGN KEY (userId)
    REFERENCES users(userId)
    ON DELETE CASCADE,

    FOREIGN KEY (shopId)
    REFERENCES shop(shopId)
    ON DELETE CASCADE
);

-- =========================
-- CART TABLE
-- =========================
CREATE TABLE cart (
    cartId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL,

    UNIQUE KEY unique_user_product (userId, productId),

    FOREIGN KEY (userId)
    REFERENCES users(userId)
    ON DELETE CASCADE,

    FOREIGN KEY (productId)
    REFERENCES product(productId)
    ON DELETE CASCADE
);

-- =========================
-- ORDERS TABLE
-- =========================
CREATE TABLE orders (
    orderId INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    totalAmount DOUBLE NOT NULL,
    status VARCHAR(50) NOT NULL,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (userId)
    REFERENCES users(userId)
    ON DELETE CASCADE
);

-- =========================
-- ORDER DETAILS TABLE
-- =========================
CREATE TABLE orderDetails (
    orderId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL,

    PRIMARY KEY (orderId, productId),

    FOREIGN KEY (orderId)
    REFERENCES orders(orderId)
    ON DELETE CASCADE,

    FOREIGN KEY (productId)
    REFERENCES product(productId)
    ON DELETE CASCADE
);

-- =========================
-- PAYMENTS TABLE
-- =========================
CREATE TABLE payments (
    paymentId INT AUTO_INCREMENT PRIMARY KEY,
    orderId INT NOT NULL,
    paymentMethod VARCHAR(50) NOT NULL,
    amount DOUBLE NOT NULL,
    status VARCHAR(50) NOT NULL,
    paymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (orderId)
    REFERENCES orders(orderId)
    ON DELETE CASCADE
);

-- =========================
-- SAMPLE DATA
-- =========================
INSERT INTO users (username, password, role)
VALUES
('admin', 'admin', 'admin'),
('user1', '123456', 'user');

INSERT INTO category (name, description)
VALUES
('Danh mục mặc định', 'Danh mục cơ bản');

INSERT INTO shop (name, description, address, status)
VALUES
('Shop Test', 'Shop bán hàng thử nghiệm', 'Hà Nội', 'active');

INSERT INTO product (name, price, stock, categoryId, shopId)
VALUES
('Sản phẩm Test 1', 150000.0, 100, 1, 1),
('Sản phẩm Test 2', 300000.0, 50, 1, 1);