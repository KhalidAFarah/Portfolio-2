CREATE DATABASE IF NOT EXISTS Webshop;
USE Webshop;
CREATE TABLE IF NOT EXISTS Customers (
Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Username VARCHAR(50) NOT NULL,
Password VARCHAR(50) NOT NULL,
Email VARCHAR(70)
);
 
show TABLES;