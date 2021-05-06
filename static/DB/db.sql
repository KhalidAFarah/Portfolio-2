-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: webshop
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `Cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `User_id` int unsigned NOT NULL,
  `Product_id` int unsigned NOT NULL,
  `Amount` int unsigned NOT NULL,
  `Ordered` tinyint(1) NOT NULL,
  PRIMARY KEY (`Cart_id`),
  KEY `User_id` (`User_id`),
  KEY `Product_id` (`Product_id`),
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `customers` (`User_id`),
  CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`Product_id`) REFERENCES `products` (`Product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `Category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'CPU'),(2,'GPU'),(3,'Headset'),(4,'Mouse'),(5,'Keyboard'),(6,'LED Lights'),(7,'PC'),(8,'Screen');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `User_id` int unsigned NOT NULL AUTO_INCREMENT,
  `Firstname` varchar(50) NOT NULL,
  `Lastname` varchar(50) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Email` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`User_id`),
  UNIQUE KEY `Password` (`Password`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Khalid','Kha','KD','KD2','Khal@sdd.com');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `User_id` int unsigned NOT NULL,
  `Product_id` int unsigned NOT NULL,
  `Amount` int unsigned NOT NULL,
  `Date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Order_id`),
  KEY `User_id` (`User_id`),
  KEY `Product_id` (`Product_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `customers` (`User_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Product_id`) REFERENCES `products` (`Product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `Product_id` int unsigned NOT NULL AUTO_INCREMENT,
  `Category_id` int unsigned DEFAULT NULL,
  `Name` varchar(70) NOT NULL,
  `Price` int NOT NULL,
  `Image` varchar(70) DEFAULT NULL,
  `Description` text,
  `Specification` text,
  PRIMARY KEY (`Product_id`),
  KEY `Category_id` (`Category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`Category_id`) REFERENCES `categories` (`Category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,1,'Intel Core i7-11700K Processor',4490,'intel i7.PNG','Performance from every angleWith Intels latest desktop processor architecture and the right balance of fast clock speeds and powerful cores you’ll get he high FPS and low latency to get more from demanding titles. Paired with advanced overclocking controls on unlocked processors and support for the latest platform technology, 11thGen Intel Core processors allow you to play your way.','Processor,Cores:8,Threads:16,Cache:16 MB,Clock speed:3.6 GHz,Max turbo speed:5 GHz,Bus speed:8 GT/s,Compatible socket:LGA1200 Socket,Fabrication process:14 nm,Thermal design power:125 W,Thermo specification:100 ℃;Integrated graphics,Type:Intel UHD Graphics 750,Fundamental frequency:350 MHz,Max dynamic frequency:1.3 GHz,Maximum supported RAM size:64 GB;'),(2,1,'AMD Ryzen 9 5900X Processor',6290,'amd9.PNG','Vær ustoppelig med den enestående hastigheten til verdens beste prosessorer for stasjonære maskiner. AMD Ryzen 5000 Series-prosessorer gir deg det beste innen høy ytelse, uansett om du spiller de nyeste spillene, designer den neste skyskraperen eller tygger deg gjennom vitenskapelige data. Med AMD Ryzen er du alltid i forkant.','Processor,Cores:12,Threads:24,Cache:64 MB,Cache-L2:6 MB,Cache-L3:64MB,Clock speed:3.7GHz,Max turbo speed:4.8 GHz,Compatible processor base:Socket AM4,Fabrikasjon process:7 nm,Thermal design power:105 W;'),(3,1,'AMD Ryzen 7 3700X Prosessor',3449,'amd7.PNG','Optimal ytelseHøyere hastigheter, mer minne og større båndbredde enn forrige generasjon. 3. generasjons AMD Ryzen™-prosessorer med 7 nm «Zen 2»-kjerne² setter standarden for høy ytelse: eksklusiv produksjonsteknologi, historisk gjennomstrømming på brikken og revolusjonerende ytelse for gaming totalt sett. AMDs 3rd Gen Ryzen™-prosessorer ble designet på grunnlag av denne filosofien fra begynnelsen av, for å bryte med forventningene og sette en ny standard for høytytende gaming-prosessorer. Og det er akkurat det de gjør.','Processor,Cores:8,Threads:16,Cache:32 MB,Cache L3:32MB,Cache L2:4MB,Clock speed:3.6 GHz,Max turbo speed:4.4 GHz,Compatible processor base:Socket AM4,Fabrication process:7 nm,Thermal design power:65 W;'),(4,2,'ASUS GeForce RTX 3070 Dual OC 8GB',8690,'asus3070.PNG','ASUS Geforce RTX 3070 Dual OC leverer den nyeste NVIDIA Ampere-arkitekturen kombinert med rask ytelse og nye funksjoner. RTX 3070 Dual OC er robust og blir avkjølt effektivt av to aksiale vifter. Du får muligheten til å øke grafikkinnstillingene i favorittspillene dine med 8 GB GDDR6-minne og ta del i strålesporing og VRS (skygge med variabel hastighet), alt for en så maksimal spillopplevelse som mulig. Grafikkortet kommer overklokket fra fabrikken (OC), noe som gir deg raskere hastigheter. RTX 3070 Dual OC er også tilgjengelig med ASUS GPU Tweak II-programvaren, som vil hjelpe deg med alle grafikkortinnstillingene dine.','General,Buss type:PCI Express 4.0,Graphic program:NVIDIA GeForce RTX 3070,CUDA-Core:5888,Max resolution:7680 x 4320,Max supported screens:4,Interface:3 display ports,Interface:2 HDMI,Supported API:OpenGL 4.6;Memory,Size:8 GB,Technology:GDDR6 SDRAM,Memory speed:14 Gbps,Buss width:256-bit;System requirements,Required power supply:650 W,Extra requirement:2 x 8 pin PCI Express power connector;'),(5,2,'MSI Radeon RX 6800 XT GAMING X TRIO 16G',12490,'MSI6800.PNG','MSI Radeon RX 6800 XT GAMING X TRIO er et robust og kraftig grafikkort med effektivt kjølesystem, slik at grafikkortet holder seg avkjølt under lengre spilløkter. Du kan spille i 4K med ekstremt jevn bildefrekvens ved hjelp av AMD RDNA 2-arkitekturen, som sørger for at oppløsning aldri går på kompromiss med oppdateringsfrekvensen. Her får du dessuten 16 GB GDDR-minne, tre TORX 4.0-vifter og RGB Mystic Light.MSI Radeon RX 6800 XT GAMING X TRIO har en raskere grafikkmotor sammenlignet med MSI Radeon RX 6800 GAMING X TRIO, hvor den integrerte og strømmende multiprosessoren har mulighet til å gjøre flere beregninger samtidig.','General,Buss type:PCI Express 4.0,Graphics program:AMD Radeon RX 6800 XT,Core clock:2045 MHz,Boost clock:2250 MHz,Flow Processors:4608,VR - ready:Yes,Max resolution:7680 x 4320,Max supported screen:4,Interface:HDMI,Interface:3 Display ports,Supported API:DirectX 12, OpenGL 4.6;Memory,Size:16 GB,Technology:GDDR6 SDRAM,Buss width:256-bit;System requirements,Required power supply:750 W,Extra requirements:2 x 8 pin PCI Express power connector;'),(6,2,'Gigabyte Radeon RX 6800 XT GAMING OC',11990,'Gigabyte6800.PNG','AMD Radeon RX 6000 SeriesVi introduserer AMD Radeon RX 6000 Series -skjermkortene med den banebrytende AMD RDNA 2-arkitekturen, utviklet for å levere ekstremt kraftig ytelse til alle gamere. AMD Radeon RX 6000 Series- skjermkort driver en ny generasjon av konkurransespill og 4K-spill med levende grafikk og forbedrede opplevelser i alle slags spill og i alle rammer. Få den ultimate gamingopplevelsen med kraftige nye beregningsenheter, banebrytende AMD Infinity Cache og opptil 16 GB dedikert GDDR6-minne. Og sammen med en desktopprosessor i AMD Ryzen 5000 Series tilbyr AMD Smart Access Memory-teknologi nye nivåer av gamingytelse.','General,Buss type:PCI Express 4.0 x16,Graphics program:AMD Radeon RX 6800 XT,Boost clock:2285 MHz,Flow processors:4608,Process technology:7 nm,Max resolution:7680 x 4320,Max supported screens:4,Interface:2 HDMI,Interface:2 Display ports,Supported API:DirectX 12, OpenGL 4.6;Memory,Size:16 GB,Technology:GDDR6 SDRAM,Actual clock speed:16000 MHz,Buss width:256-bit,Bandwidth:512 GBps;System requirements,Required power supply:750 W,Extra Requirements:2 x 8 pin PCI Express power connector;'),(7,8,'WQHD gaming monitor',4490,'WQHDGamimgSkjerm.PNG','LG 27GL83A-B er en 27\" WQHD-gamingskjerm (2560 x 1440) som gir deg tilgang til 144 Hz oppdateringsfrekvens med 1 ms responstid. De høye hastighetene gjør at spillet flyter bedre og blir spesielt verdsatt i raske actionspill. Skjermen har også utstyrt IPS-panel med 99% av sRGB, og dette gir deg både enestående fargenøyaktighet og bedre synsvinklel. Andre funksjoner inkluderer Adaptive Synk (FreeSync) og NVIDIA G-Sync-kompatibilitet.','General,Screen type:LED backlit LCD screen / TFT active matrix,Energy class:B,Diagonal size:27\'\',Visible size:27\'\',Yearly energy consumption:57 kWh,Adaptiv synchronization technology:AMD FreeSync, NVIDIA G-Sync Compatible,Standard resolution:QHD 2560 x 1440 at144 Hz,pixel distance:0.2331 mm,Brightness:350 cd/m²,Contrast ratio:1000:1,HDR format:HDR10,Supported colors :1.07 bilion colors,Response time:1 ms,Backlight technology:LED-backlight,Horisontal viewing angle:178,Vertical  viewing angle:178,Weight:6.1 kg,Dimentions:61.42 cm x 27.44 cm x 46.48 cm - with stand,screen cover:3H Hard Coating, Dis 25 %,Panel type:IPS;Power supply,Required mains voltage:AC 120/230 V (50/60 Hz),Power consumption (on):39 W,Power consumption (typical):51 watt,Power consumption in saving mode:0.5 watt;Mechanical,Display position adjustment:Height, pivot (rotation), tilt,VESA mounting interface:100 x 100 mm;Various,Custom standards:DisplayPort 1.4;Connectivity,Interface:2 HDMI,Interface:DisplayPort,Inteface:Headphones;');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-06 14:19:49
