CREATE DATABASE IF NOT EXISTS Webshop;
USE Webshop;
CREATE TABLE IF NOT EXISTS Customers (
Id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Username VARCHAR(50) NOT NULL UNIQUE,
Password VARCHAR(50) NOT NULL UNIQUE,
Email VARCHAR(70)
);

/*CREATE USER  IF NOT EXISTS "general"@"localhost" IDENTIFIED WITH mysql_native_password BY "general";
GRANT ALL privileges ON Webshop . * TO "general"@"localhost";*/
