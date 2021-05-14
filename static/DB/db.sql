-- MySQL dump 10.13  Distrib 8.0.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: webshop
-- ------------------------------------------------------
-- Server version	8.0.24

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
  `Ordered` varchar(10) NOT NULL,
  PRIMARY KEY (`Cart_id`),
  KEY `User_id` (`User_id`),
  KEY `Product_id` (`Product_id`),
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `customers` (`User_id`),
  CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`Product_id`) REFERENCES `products` (`Product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (1,1,19,3,'No');
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
INSERT INTO `categories` VALUES (1,'CPU'),(2,'GPU'),(3,'PC'),(4,'Screen'),(5,'Headset'),(6,'Mouse'),(7,'Keyboard'),(8,'LED Lights');
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
  `Password` varchar(50) DEFAULT NULL,
  `Email` varchar(70) DEFAULT NULL,
  `Access_level` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`User_id`),
  UNIQUE KEY `Password` (`Password`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Anonymous','Anonymous','admin','admin',NULL,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,1,'Intel Core i7-11700K Processor',4490,'intel i7.PNG','Performance from every angleWith Intels latest desktop processor architecture and the right balance of fast clock speeds and powerful cores you’ll get he high FPS and low latency to get more from demanding titles. Paired with advanced overclocking controls on unlocked processors and support for the latest platform technology, 11thGen Intel Core processors allow you to play your way.','Processor,Cores:8,Threads:16,Cache:16 MB,Clock speed:3.6 GHz,Max turbo speed:5 GHz,Bus speed:8 GT/s,Compatible socket:LGA1200 Socket,Fabrication process:14 nm,Thermal design power:125 W,Thermo specification:100 ℃;Integrated graphics,Type:Intel UHD Graphics 750,Fundamental frequency:350 MHz,Max dynamic frequency:1.3 GHz,Maximum supported RAM size:64 GB;'),(2,1,'AMD Ryzen 9 5900X Processor',6290,'amd9.PNG','Vær ustoppelig med den enestående hastigheten til verdens beste prosessorer for stasjonære maskiner. AMD Ryzen 5000 Series-prosessorer gir deg det beste innen høy ytelse, uansett om du spiller de nyeste spillene, designer den neste skyskraperen eller tygger deg gjennom vitenskapelige data. Med AMD Ryzen er du alltid i forkant.','Processor,Cores:12,Threads:24,Cache:64 MB,Cache-L2:6 MB,Cache-L3:64MB,Clock speed:3.7GHz,Max turbo speed:4.8 GHz,Compatible processor base:Socket AM4,Fabrikasjon process:7 nm,Thermal design power:105 W;'),(3,1,'AMD Ryzen 7 3700X Prosessor',3449,'amd7.PNG','Optimal ytelseHøyere hastigheter, mer minne og større båndbredde enn forrige generasjon. 3. generasjons AMD Ryzen™-prosessorer med 7 nm «Zen 2»-kjerne² setter standarden for høy ytelse: eksklusiv produksjonsteknologi, historisk gjennomstrømming på brikken og revolusjonerende ytelse for gaming totalt sett. AMDs 3rd Gen Ryzen™-prosessorer ble designet på grunnlag av denne filosofien fra begynnelsen av, for å bryte med forventningene og sette en ny standard for høytytende gaming-prosessorer. Og det er akkurat det de gjør.','Processor,Cores:8,Threads:16,Cache:32 MB,Cache L3:32MB,Cache L2:4MB,Clock speed:3.6 GHz,Max turbo speed:4.4 GHz,Compatible processor base:Socket AM4,Fabrication process:7 nm,Thermal design power:65 W;'),(4,2,'ASUS GeForce RTX 3070 Dual OC 8GB',8690,'asus3070.PNG','ASUS Geforce RTX 3070 Dual OC leverer den nyeste NVIDIA Ampere-arkitekturen kombinert med rask ytelse og nye funksjoner. RTX 3070 Dual OC er robust og blir avkjølt effektivt av to aksiale vifter. Du får muligheten til å øke grafikkinnstillingene i favorittspillene dine med 8 GB GDDR6-minne og ta del i strålesporing og VRS (skygge med variabel hastighet), alt for en så maksimal spillopplevelse som mulig. Grafikkortet kommer overklokket fra fabrikken (OC), noe som gir deg raskere hastigheter. RTX 3070 Dual OC er også tilgjengelig med ASUS GPU Tweak II-programvaren, som vil hjelpe deg med alle grafikkortinnstillingene dine.','General,Buss type:PCI Express 4.0,Graphic program:NVIDIA GeForce RTX 3070,CUDA-Core:5888,Max resolution:7680 x 4320,Max supported screens:4,Interface:3 display ports,Interface:2 HDMI,Supported API:OpenGL 4.6;Memory,Size:8 GB,Technology:GDDR6 SDRAM,Memory speed:14 Gbps,Buss width:256-bit;System requirements,Required power supply:650 W,Extra requirement:2 x 8 pin PCI Express power connector;'),(5,2,'MSI Radeon RX 6800 XT GAMING X TRIO 16G',12490,'MSI6800.PNG','MSI Radeon RX 6800 XT GAMING X TRIO er et robust og kraftig grafikkort med effektivt kjølesystem, slik at grafikkortet holder seg avkjølt under lengre spilløkter. Du kan spille i 4K med ekstremt jevn bildefrekvens ved hjelp av AMD RDNA 2-arkitekturen, som sørger for at oppløsning aldri går på kompromiss med oppdateringsfrekvensen. Her får du dessuten 16 GB GDDR-minne, tre TORX 4.0-vifter og RGB Mystic Light.MSI Radeon RX 6800 XT GAMING X TRIO har en raskere grafikkmotor sammenlignet med MSI Radeon RX 6800 GAMING X TRIO, hvor den integrerte og strømmende multiprosessoren har mulighet til å gjøre flere beregninger samtidig.','General,Buss type:PCI Express 4.0,Graphics program:AMD Radeon RX 6800 XT,Core clock:2045 MHz,Boost clock:2250 MHz,Flow Processors:4608,VR - ready:Yes,Max resolution:7680 x 4320,Max supported screen:4,Interface:HDMI,Interface:3 Display ports,Supported API:DirectX 12, OpenGL 4.6;Memory,Size:16 GB,Technology:GDDR6 SDRAM,Buss width:256-bit;System requirements,Required power supply:750 W,Extra requirements:2 x 8 pin PCI Express power connector;'),(6,2,'Gigabyte Radeon RX 6800 XT GAMING OC',11990,'Gigabyte6800.PNG','AMD Radeon RX 6000 SeriesVi introduserer AMD Radeon RX 6000 Series -skjermkortene med den banebrytende AMD RDNA 2-arkitekturen, utviklet for å levere ekstremt kraftig ytelse til alle gamere. AMD Radeon RX 6000 Series- skjermkort driver en ny generasjon av konkurransespill og 4K-spill med levende grafikk og forbedrede opplevelser i alle slags spill og i alle rammer. Få den ultimate gamingopplevelsen med kraftige nye beregningsenheter, banebrytende AMD Infinity Cache og opptil 16 GB dedikert GDDR6-minne. Og sammen med en desktopprosessor i AMD Ryzen 5000 Series tilbyr AMD Smart Access Memory-teknologi nye nivåer av gamingytelse.','General,Buss type:PCI Express 4.0 x16,Graphics program:AMD Radeon RX 6800 XT,Boost clock:2285 MHz,Flow processors:4608,Process technology:7 nm,Max resolution:7680 x 4320,Max supported screens:4,Interface:2 HDMI,Interface:2 Display ports,Supported API:DirectX 12, OpenGL 4.6;Memory,Size:16 GB,Technology:GDDR6 SDRAM,Actual clock speed:16000 MHz,Buss width:256-bit,Bandwidth:512 GBps;System requirements,Required power supply:750 W,Extra Requirements:2 x 8 pin PCI Express power connector;'),(7,8,'WQHD gaming monitor',4490,'WQHDGamimgSkjerm.PNG','LG 27GL83A-B er en 27\" WQHD-gamingskjerm (2560 x 1440) som gir deg tilgang til 144 Hz oppdateringsfrekvens med 1 ms responstid. De høye hastighetene gjør at spillet flyter bedre og blir spesielt verdsatt i raske actionspill. Skjermen har også utstyrt IPS-panel med 99% av sRGB, og dette gir deg både enestående fargenøyaktighet og bedre synsvinklel. Andre funksjoner inkluderer Adaptive Synk (FreeSync) og NVIDIA G-Sync-kompatibilitet.','General,Screen type:LED backlit LCD screen / TFT active matrix,Energy class:B,Diagonal size:27\'\',Visible size:27\'\',Yearly energy consumption:57 kWh,Adaptiv synchronization technology:AMD FreeSync, NVIDIA G-Sync Compatible,Standard resolution:QHD 2560 x 1440 at144 Hz,pixel distance:0.2331 mm,Brightness:350 cd/m²,Contrast ratio:1000:1,HDR format:HDR10,Supported colors :1.07 bilion colors,Response time:1 ms,Backlight technology:LED-backlight,Horisontal viewing angle:178,Vertical  viewing angle:178,Weight:6.1 kg,Dimentions:61.42 cm x 27.44 cm x 46.48 cm - with stand,screen cover:3H Hard Coating, Dis 25 %,Panel type:IPS;Power supply,Required mains voltage:AC 120/230 V (50/60 Hz),Power consumption (on):39 W,Power consumption (typical):51 watt,Power consumption in saving mode:0.5 watt;Mechanical,Display position adjustment:Height, pivot (rotation), tilt,VESA mounting interface:100 x 100 mm;Various,Custom standards:DisplayPort 1.4;Connectivity,Interface:2 HDMI,Interface:DisplayPort,Inteface:Headphones;'),(8,8,'Lenovo L22e',1290,'Lenovo L22e.PNG','The Lenovo L22e is a 21.5 \"Full HD display suitable for the office due to its thin frames and wide viewing angle. The thin frames allow you to use several screens next to each other without a large space, and the viewing angle makes it easy to view screen content for family or colleagues.Full HD-oppløsning Med Full HD-oppløsning på 1920 x 1080 får du en skjerm som viser hver detalj og passer like bra for spill som for multimedia og arbeid. Det er også bra for deg som ønsker et stort arbeidsområde ved å bruke flere skjermer, dette fordi rammene er veldig tynne og ikke forstyrrer når du plasserer flere skjermer ved siden av hverandre.AMD FreeSync-teknologi AMD FreeSync-teknologi eliminerer screen tearing og hakkete bildefrekvenser for å gi deg sømløs grafikk og glatt spillopplevelse. Dette gir deg overtaket i FPS, racing og strategispill i sanntid. AMD FreeSync sørger for at bildefrekvensen blir bestemt av grafikkortet ditt og ikke begrenset av skjermen, noe som betyr at bildekortets og skjermbildets bildefrekvens reduseres for et jevnt og skarpt resultat.Low Blue Light-teknologiDenne gamingskjermen er spesielt designet for lange spilløkter med sin Low Blue Light-teknologi. Lenovo L22e  reduserer det blå lyset for å beskytte øynene dine. I tillegg er det en funksjon som reduserer flimmering på skjermen som minimerer belastningen på øynene og gir deg en mye mer behagelig spillopplevelse og et par penere øyne.','General,Type:LED backlit LCD screen,Diagonal size:21.5\",Visible size:21.5\",Side ratio:16:9,Standard resolution:Full HD (1080p) 1920 x 1080 at 60 Hz,Vertical recoverry rate:76 Hz,Horisontal recovery rate:90 kHz,Backlight technology:LED backlight,Dimentions(WxLxH):48.93 cm x 20 cm x 37.38 cm,Energy class:D;Connectivity,Interface:VGA,Interface:HDMI;Mechanical,Display position adjustment:Tilt,Tilt angle:-5/ 22,VESA mounting interface:100 x 100 mm;Power supply,Required mains voltage:AC 120/230 V (50/60 Hz),Power consumption during operation:22 watt,Power Consumption (Typical):22 watt,Standby power consumption:0.3 watt,Power consumption in save mode:0.3 watt;'),(9,8,'Acer Nitro QG271bii',1790,'acerNitro.PNG','Acer Nitro QG271Ybii er en 27\" stor gamingmonitor med Full HD-oppløsning og en rask responstid på bare 1 ms (VRB) som sørger for at den er klar for spill i raske action- og racingspill. Nitro QG271Ybii har også blitt utstyrt med AMD FreeSync Du kan også dra nytte av funksjoner som Acer Flicker-less og Acer BlueLightShield, noe som reduserer belastningen på øynene og sørger for komfort selv under lange spillmaraton.Full HD-oppløsning (1920 x 1080)Med en oppløsning på 1920 x 1080 vil du se alle detaljer. Du får oppleve en lysstyrke på 250 cd / m², god kontrast og realistiske farger som gir et realistisk bilde.AMD Radeon FreeSyncAMD FreeSync-teknologi eliminerer riving i bildet og hakkete bildefrekvenser for å gi deg sømløs grafikk og jevne spillopplevelser. Dette gir deg overtaket i FPS, racing og strategispill i sanntid. AMD FreeSync sørger for at bildehastigheten bestemmes av grafikkortet ditt og ikke er begrenset av skjermen, dette betyr at bildeshastigheten til grafikkortet og skjermen synkroniseres for et jevnt og skarpt resultat.1 ms responstid (VRB)VRB (Visual Response Boost) -teknologien skaper effekten av 1 ms Moving Picture Response Time (MPRT). Dette gjøres ved å raskt slå av bakgrunnsbelysningen eller sette inn et tomt, svart bilde mellom rammene, også kjent som en \"blink\". Dette resulterer i mindre merkbar uskarphet når bilder endres raskt.Acer Flicker-less og Acer BlueLightShieldAcer Flickerless-teknologi eliminerer skjermflimmer ved å gi en stabil strømforsyning til skjermen. Dette motvirker slitne øyne etter å ha sittet lenge foran en datamaskin for en behagelig datamaskinopplevelse. Denne skjermen har også Acer BlueLightShield som beskytter deg mot skadelig blått lys.','General,Type:LED backlit LCD screen / TFT active matrix,Energy class:F,Diagonal size:27\",Adaptive synchronization technology:AMD FreeSync,Panel type:VA,Side ratio:16:9,Standard resolution:Full HD (1080p) 1920 x 1080 at 75 Hz,Brightness:300 cd/m^2,Contrast ratio:3000:1 / 100000000:1 (dynamic),Color support:16,7 million colors,Response time: 1ms (VRB),Vertical recovery rate:56 - 76 Hz,Horizontal recovery rate:30 - 85 kHz,screen cover:Anti-reflex,Backlight technology:LED backlight,Dimentions (WxLxH):61.4 cm x 24 cm x 45.4 cm - with stand;Connectivity,Interface:VGA,Interface:2 x HDMI;Mechanical,Display position adjustment:Tilt,Tilt angle:-5/ 25,VESA mounting interface:100 x 100 mm;Power supply,Input voltage: InngangsspenningAC 120/230 V (50/60 Hz),Power consumption (on mode):26.1 W,Power consumption SDR (on mode):26.1 kWh/1000t,Power consumption (typical):24 watt,Standby power consumption:0.3 watt,Power consumption (off mode):0.25 watt;'),(10,7,'HP Pavilion TG01-1811no Desktop Gaming PC',7495,'Pavilion.PNG','The HP Pavilion TG01-1811no Desktop Gaming PC has the qualities that will help you raise your gaming level. With NVIDIA graphics, AMD Ryzen ™ 5 processor and more, the PC\'s gaming-oriented design will give you the power to play your favorite titles with high FPS and climb the rankings.The power of Ryzen ™AMD Ryzen ™ 5 4600G APU is a processor with integrated graphics solution. The base frequency is 3.7 GHz, and the clock frequency can be increased to 4.2 GHz with six cores in use. The processor is supported by 8 GB DDR4 RAM.Next generation graphicsWith the Nvidia GeForce GTX 1650, you get excellent visual quality, even for resource-intensive games. The graphics card comes with 4 GB of RAM and is built around the next generation Turing architecture so that you can play in Full HD 1080p quality with high frame rate.StorageThe 512 GB SSD disk provides fast start-up of both PC, games and programs.HDMIVia the HDMI v2.0 output on the graphics card, you can connect an HD TV or projector to display images and videos in up to 4K UHD resolution on a large screen.Connectivity:- 1 piece. HDMI 2.0, 1 pc. DVI- 1 piece. USB-C 3.2 Gen 1 port- 4 pcs. USB-A 3.2 Gen 1 port- 4 pcs. USB-A 2.0 ports- Lightning fast dual-band WiFi-ac, Bluetooth 4.2, Gigabit LAN port- 3-in-1 memory card reader- 1 piece. line-in, 1 pc. line-out, 1 pc. microphone port- 1 piece. 3.5 mm combined port for headphones / microphoneOther features:- Windows 10 Home 64-bit- 5.1 surround sound','Model description,Type:Gaming PC,Series:Pavilion,Chassis type:Black (Full Tower);Processor,CPU manufacturer:AMD,Type:AMD Ryzen 5,Cores:6,Threads:12,Speed:3,70 GHz,Maximum speed:4,20 GHz,Cache:8 MB,Chipset:AMD Promontory B550A;Motherboard,Model:Erica3;Storage and memory,RAM type:DDR4,RAM size:8 GB,Memory speed:3200,Type of storage:SSD,Type SSD:M.2 PCIe NVMe SSD,Storage capacity:512 GB;Graphics,Architecture graphics card:Dedicated,Number of graphics cards:1,Main brand (GPU):NVIDIA,Graphics Solution (Manufacturer):NVIDIA,Graphics solution (Model):GeForce GTX 1650,Dedicated video memory:4;Power supply,Power supply:310 W;'),(11,7,'PCSpecialist Tornado R5 Gaming PC',11495,'TornadoR5.PNG','1.    CPU:Combine hardcore gaming and seamless streaming into one with the Tornado R5 Gaming PC. Packed with a Six Core/Twelve thread Ryzen 5 3600 CPU (3.6GHz – 4.2GHz Max Boost): demand more with the superior multi-threaded performance of AMD Ryzen™. Experience your movies, photos, and the most popular esports games in Full HD (1920 x 1080) at high settings.2.    GPU:The GeForce® 1660 is built with the breakthrough graphics performance of the award-winning NVIDIA Turing™ architecture. Easily upgrade your PC and get performance that rivals the GeForce GTX 1070*, a 16 Series GPU is a blazing-fast supercharger for today’s most popular games, and even faster with modern titles.3.    Gaming Potential:Great for esports and popular PC gaming titles such as Apex Legends, Fortnite, Valorant, CS GO, Call of Duty Modern Warfare and more.4.    Features:Maintain smooth performance in your favourite suite of programs thanks to the included 8GB of high-quality Corsair DDR4 RAM and a reliable wireless connection, through the WiFi 6 and Blue tooth 5.0 technology. PCSpecialist have included a superfast 256GB M.2 SSD and a large 1TB Hard Drive with room to upgrade components should you want to in the future – just give PC Specialist a call!5.    Warranty:Whether you’re into gaming, streaming, watching movies or keeping up to date with your friends, the Tornado R5 Gaming PC has everything you need and more. All of PC Specialist’s award winning PCs are covered with a 3 Year Standard Warranty package and supported by our UK-based Customer Service Team.','Model description,Type:Gaming PC;Processor,CPU manufacturer:AMD,Processor type:AMD Ryzen 5,Cores:6,Speed:3.60 GHz,Maximum speed:4.20 GHz;Motherboard,Brand:Asus,Model:A320,SLI support:No;Storage and memory,RAM type:DDR4 Onboard,Size:8 GB,Type SSD:M.2 PCIe NVMe SSD,Storage capacity SDD:256 GB,Storage capacity HDD:1000 GB,Number of installed HDDS:2;Graphics,Architecture graphics card:Dedicated,Main brand (GPU):NVIDIA,Graphics Solution (Manufacturer):NVIDIA,Graphics solution (Model):GeForce GTX 1660,Dedicated video memory:6,Memory speed:2400 MHz;'),(13,5,'HUAWEI FREEBUDS STUDIO HEADPHONES GRAPHITE BLACK',2990,'huawei headset.png','HUAWEI FreeBuds Studio headphones are also great for gaming. When you play, the headphones automatically switch to low latency mode for the best gaming experience. The headphones also have smart wear recognition, which allows the headphones to automatically stop playing music when you remove the headphones and continue when you put them on your head. The headphone\'s touch and swipe controls make it easy to stop playback, change tracks, answer calls, and adjust the volume.','Features,Connection:Wireless,Headphone type:Around Ear/ Over-Ear ,Microphone:Yes,Active noise cancellation:Yes;Wireless features,Connection:Bluetooth,Type bluetooth:Bluetooth 5.2;Power and battery,Battery life:24 hours,Charging time:1 hour;Other specifications,Net weight:0.265 kg,Net measurements without packaging:194.0 x 152.0x82.0 mm,Primary color:Black;'),(14,5,'JBL EVEREST V710GA OVER EAR SILVER',2499,'JBL HEADSET.png','The JBL Everest 710 offers unmatched sound provided by the legendary JBL Pro Audio Sound, not to mention the unparalleled comfort offered by the premium materials. ShareMe 2.0 technology allows you to connect and share music with friends, via Bluetooth. A fast 2-hour charge, a sleek flat folding design and a compact hard carrying case make these headphones the perfect companion when traveling. The built-in microphone enables crystal-clear hands-free calling, and the convenient controls on the earcup allow you to adjust volume and change songs easily.','Features,Connection:Wireless,Microphone:Yes,Active noise cancellation:No;Wireless features,Connection:Bluetooth;design and layout,Material:Plastic;Other specifications,Net weight:0.460 kg,Net measurements without packaging:68.0 x 207.0 x 223.0 mm;'),(15,5,'SONY WH-CH510 ON-EAR BLACK',299,'SONY headset.png','The Sony WH-CH510 provides up to 35 hours of non-stop listening. Sound, which can be streamed wirelessly from a mobile or tablet with Bluetooth 5.0 technology, is pumped out through closed dynamic speaker elements of as much as 30 mm. And if you connect the WH-CH510 to your smartphone, you can also use the built-in microphone for hands-free calling.','Features,Connection:Wireless,Active noise cancellation:No,Microphone:Yes,Headphone type:On Ear;Wireless features,Connection:Bluetooth,Bluetooth type:Bluetooth 5.0;Power and battery ,Battery life:35 hours;Other specifications,Net weight:0.143 kg,Net measurements without packaging:172.0 x 160.0 x 70.0 mm,Primary color:Black;'),(16,7,'ELETRA EK1000 CABLE KEYBORD',199,'ELETRA keybord.png','Excellent wired USB keyboard from Eletra. Slim and light design is well suited where it is cramped. The full-size keyboard has all the necessary buttons, including the numpad.','Connections,Wireless:No;Qualities,Keyboard layout:Nordic,Size:Standard;Other specification,Net weight:0.110 kg,et measurements without packaging:25.0 x 145.0 x 440.0 mm;'),(17,7,'COUGAR ATTACK X3 RGB GAMING KEYBORD CHERRY MX SILVER',999,'COUGAR keybord.png','The keyboard has an aluminum surface that looks good even without light. When you long for the mood and want to see the keys even in the dark, you can set the colors as you wish at the top, thanks to the RGB lights. The keyboard has several preset light settings, and with the COUGAR UIX system you can create your own unique light show to create mood. The secret behind the shocking speed lies in the Attack X3 RGB Speedy switches, which have a response time of 1 ms and require a key depth of only 1.2 mm which is the shortest of all Cherry MX switches.','Design and layout,Material:Plastic,Primary color:Black;Connections,Wireless:No;Qualities,Keybord layout:Nordic,Adapted for gaming:Yes,Size:Standard,type of lighting:RGB;Other specification,Net weight:0.900 kg,Net measurements without packaging:170.0 x 467.0 x 40.0 mm;'),(18,7,'LOGITECH K270 WIRELESS KEYBORD',399,'logitech keybord.png','Compact full-size wireless keyboard with numeric keypad. Easy setup against your PC with the small Unifying receiver that can stay in the laptop at all times. You can also easily add up to 5 additional Unifying-compatible wireless mice or keyboards, without controlling with multiple USB receivers. With advanced 2.4 GHz wireless connection from Logitech, you avoid signal loss, even up to 10 meters away from the receiver. Automatic sleep mode gives the keyboard good battery capacity, up to 24 months.','Design and layout,Primary color:Black;Connections,Wireless:Yes,Wireless Connection:2.4 GHz;Qualitites,Keybord layout:Nordic,Adapted for gaming:No,Size:Standard,Lighting:No,Media buttons:Yes;Other specifications,Net weight:0.660 kg,Battery life:24 months,Water-repellent keyboard design :Yes;'),(19,6,'LOGITECH MX ANYWHERE 3 WIRELESS MOUSE GRAFITT',799,'Logitech mouse.png','MX Anywhere 3 is a compact wireless mouse with a modern design designed to work precisely on different surfaces and with different operating systems. This comfortable mouse has a 4000 DPI Darkfield sensor, fast and precise MagSpeed scrolling and configurable buttons. The compact ergonomic design with low profile and super-soft silicone side grips provide comfort everywhere, and the MX Anywhere 3 is comfortable to use at home or on the go. The sensor works precisely on almost all surfaces - even glass (4 mm minimum thickness), which allows you to work seamlessly whether you are in the office, in the cafe or on the sofa in the living room.','Design and layout,Primary color :Grey;Connections,Wireless:Yes,Wireless connection:Bluetooth;Qualities,DPI:4000,Adapted for gaming:No,Battery life:1680 hours,Number of buttons:6;Other specification,Net weight:0.099 kg,Net measurements without packaging:101.0 x 65.0 x 34.0 mm;'),(20,6,'RAZER NAGA PRO WIRELESS GAMING MOUSE',1799,'RAZER naga pro mouse.png','Razer Naga Pro is a versatile wireless gaming mouse with three interchangeable side panels. Thanks to the modular design and the interchangeable side panels, you can take control of any game genre with up to 20 customizable buttons. Wireless Razer ™ HyperSpeed technology provides an ultra-fast and low-latency wireless connection for demanding gaming. The mouse\'s advanced Razer Focus   optical sensor with true 20,000 DPI resolution offers a whole new level of precision and speed. With a resolution of up to 99.6%, the crosshairs remain on target even during the fastest situations. It has an incredibly long battery life of up to 100 hours in HyperSpeed mode to ensure you can play through the longest game sessions.With high-quality switches designed for gaming, every mouse click is activated at the speed of light. Razer optical mouse switches use an infrared light beam to detect clicks and provide an incredibly fast response time of 0.2 ms, which is up to three times faster than a standard mechanical switch. The switches have a service life of up to 70 million presses.','Design and layout,Material:Plastic,Primary color:Black ;Connections ,Wireless:Yes,Wireless connection:Bluetooth 2.4 GHz;Qualities,DPI:20 000,Adapted for gaming:Yes,Battery life:150 hours,Type of lighting:RGB,Acceleration:50 G,Amount of buttons:20,Polling rate:1000 Hertz (1/second),Internal memory:Yes,IPS:650;Other specification,Net weight :0.110 kg,Lifetime on switches:70 million clicks;'),(21,6,'CEPTER GLADIUS MMO-GAMING MOUSE',1299,'CEPTER GLADIUS mouse.png','Cepter Gladius is a versatile MMO gaming mouse with adjustable buttons and replaceable side panels. Do not let the mouse restrict you from playing MMO games. Make the gaming experience perfectly suited to your gaming style by selecting a side panel with up to nine buttons.Gladius comes with software that allows you to adjust button functions, macros, lighting, DPI and mouse resolution. The mouse has a 6-speed DPI switch that can be adjusted between 800/1600/2400/3600/5000/10 000 to suit your playing style. Mouse lighting can be easily adjusted with the software to your liking. Adjust multiple mouse profiles and save settings to suit different games.','Design and layout ,Material:Plastic,Primary color :Black ;Connections ,Wireless:No,Cable length:1.8 meter;Qualities ,DPI:10 000,Adapted for gaming:Yes,Type of lighting:RGB ,Amount of buttons:14,Adapted for:Right hand;Other specification ,Net weight:0.113 kg,Net measurements without packaging:160.0 x 230.0 x 70.0 mm,USB-connection:Yes;');
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

-- Dump completed on 2021-05-14 14:39:03
