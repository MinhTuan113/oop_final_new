-- ============================================================
-- SQL Script: Tao bang Users cho module Dang nhap / Dang ky
-- Tich hop tu repo: https://github.com/ducgiang08/BTL-OOP
-- Chay tren database 'btl' (MySQL / HeidiSQL)
-- Convention: PK la 'id', FK tham chieu la 'userId' (giong cart, orders...)
-- ============================================================

-- Tat kiem tra khoa ngoai tam thoi de co the xoa bang
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;


-- Bang Users (Nguoi dung)
CREATE TABLE IF NOT EXISTS Users (
    userId      INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(100)                  NOT NULL UNIQUE,
    password    VARCHAR(255)                  NOT NULL,
    email       VARCHAR(150)                  NOT NULL UNIQUE,
    fullName    VARCHAR(200)                  NOT NULL,
    role        ENUM('ADMIN', 'CUSTOMER')     NOT NULL DEFAULT 'CUSTOMER'
);

-- Them tai khoan admin mac dinh (mat khau: admin123 -> hash SHA-256)
INSERT IGNORE INTO Users (username, password, email, fullName, role)
VALUES (
    'admin',
    '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
    'admin@tmdt.com',
    'Quan tri vien',
    'ADMIN'
);

-- Them tai khoan khach hang mau de test
INSERT IGNORE INTO Users (username, password, email, fullName, role)
VALUES (
    'customer1',
    '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
    'customer1@tmdt.com',
    'Nguyen Van A',
    'CUSTOMER'
);

-- ============================================================
-- GHI CHU: Cac bang da co (cart, orders, payments) dang dung
-- userId INT NOT NULL (chua co FOREIGN KEY rang buoc sang Users).
-- Neu muon them rang buoc toan ven, chay cac lenh ALTER sau:
-- ============================================================

-- ALTER TABLE cart
--     ADD CONSTRAINT fk_cart_user FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE;

-- ALTER TABLE orders
--     ADD CONSTRAINT fk_orders_user FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE;

