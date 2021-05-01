CREATE DATABASE IF NOT EXISTS Webshop;
USE Webshop;
CREATE TABLE IF NOT EXISTS Customers (
User_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Username VARCHAR(50) NOT NULL UNIQUE,
Password VARCHAR(50) NOT NULL UNIQUE,
Email VARCHAR(70)
);

CREATE TABLE IF NOT EXISTS Categories (
Category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Products (
Product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Category_id INT UNSIGNED,
Name VARCHAR(70) NOT NULL,
Price INT NOT NULL,
Image VARCHAR(70),
Description TEXT,
Specification TEXT,
FOREIGN KEY (Category_id) REFERENCES Categories (Category_id)
);
INSERT INTO Categories (Name) VALUES ("CPU");
INSERT INTO Categories (Name) VALUES ("GPU");
INSERT INTO Categories (Name) VALUES ("Headset");

INSERT INTO Categories (Name) VALUES ("Mouse");
INSERT INTO Categories (Name) VALUES ("Keyboard");
INSERT INTO Categories (Name) VALUES ("LED Lights");

INSERT INTO Categories (Name) VALUES ("PC");
INSERT INTO Categories (Name) VALUES ("Screen");

CREATE TABLE IF NOT EXISTS Carts (
Cart_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
User_id INT UNSIGNED NOT NULL,
Product_id INT UNSIGNED NOT NULL,
Amount INT UNSIGNED NOT NULL,
Ordered BOOLEAN NOT NULL,
FOREIGN KEY (User_id) REFERENCES Customers (User_id),
FOREIGN KEY (Product_id) REFERENCES Products (Product_id)
);

use Webshop;
SELECT * FROM Carts;

/*CREATE USER  IF NOT EXISTS "general"@"localhost" IDENTIFIED WITH mysql_native_password BY "general";
GRANT ALL privileges ON Webshop . * TO "general"@"localhost";*/
