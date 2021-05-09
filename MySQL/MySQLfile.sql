CREATE DATABASE IF NOT EXISTS Webshop;
USE Webshop;
CREATE TABLE IF NOT EXISTS Customers (
User_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Firstname VARCHAR(50) NOT NULL,
Lastname VARCHAR(50) NOT NULL,
Username VARCHAR(50) NOT NULL,
Password VARCHAR(50) NOT NULL UNIQUE,
Email VARCHAR(70)
);

CREATE TABLE IF NOT EXISTS Categories (
Category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(50) NOT NULL
);
INSERT INTO Categories (Name) VALUES ("CPU");
INSERT INTO Categories (Name) VALUES ("GPU");
INSERT INTO Categories (Name) VALUES ("PC");
INSERT INTO Categories (Name) VALUES ("Screen");

INSERT INTO Categories (Name) VALUES ("Headset");
INSERT INTO Categories (Name) VALUES ("Mouse");
INSERT INTO Categories (Name) VALUES ("Keyboard");
INSERT INTO Categories (Name) VALUES ("LED Lights");

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
INSERT INTO Products VALUES 
(1,1,'Intel Core i7-11700K Processor',4490,'intel i7.PNG','Performance from every angleWith Intels latest desktop processor architecture and the right balance of fast clock speeds and powerful cores you’ll get he high FPS and low latency to get more from demanding titles. Paired with advanced overclocking controls on unlocked processors and support for the latest platform technology, 11thGen Intel Core processors allow you to play your way.','Processor,Cores:8,Threads:16,Cache:16 MB,Clock speed:3.6 GHz,Max turbo speed:5 GHz,Bus speed:8 GT/s,Compatible socket:LGA1200 Socket,Fabrication process:14 nm,Thermal design power:125 W,Thermo specification:100 ℃;Integrated graphics,Type:Intel UHD Graphics 750,Fundamental frequency:350 MHz,Max dynamic frequency:1.3 GHz,Maximum supported RAM size:64 GB;'),
(2,1,'AMD Ryzen 9 5900X Processor',6290,'amd9.PNG','Vær ustoppelig med den enestående hastigheten til verdens beste prosessorer for stasjonære maskiner. AMD Ryzen 5000 Series-prosessorer gir deg det beste innen høy ytelse, uansett om du spiller de nyeste spillene, designer den neste skyskraperen eller tygger deg gjennom vitenskapelige data. Med AMD Ryzen er du alltid i forkant.','Processor,Cores:12,Threads:24,Cache:64 MB,Cache-L2:6 MB,Cache-L3:64MB,Clock speed:3.7GHz,Max turbo speed:4.8 GHz,Compatible processor base:Socket AM4,Fabrikasjon process:7 nm,Thermal design power:105 W;'),
(3,1,'AMD Ryzen 7 3700X Prosessor',3449,'amd7.PNG','Optimal ytelseHøyere hastigheter, mer minne og større båndbredde enn forrige generasjon. 3. generasjons AMD Ryzen™-prosessorer med 7 nm «Zen 2»-kjerne² setter standarden for høy ytelse: eksklusiv produksjonsteknologi, historisk gjennomstrømming på brikken og revolusjonerende ytelse for gaming totalt sett. AMDs 3rd Gen Ryzen™-prosessorer ble designet på grunnlag av denne filosofien fra begynnelsen av, for å bryte med forventningene og sette en ny standard for høytytende gaming-prosessorer. Og det er akkurat det de gjør.','Processor,Cores:8,Threads:16,Cache:32 MB,Cache L3:32MB,Cache L2:4MB,Clock speed:3.6 GHz,Max turbo speed:4.4 GHz,Compatible processor base:Socket AM4,Fabrication process:7 nm,Thermal design power:65 W;'),
(4,2,'ASUS GeForce RTX 3070 Dual OC 8GB',8690,'asus3070.PNG','ASUS Geforce RTX 3070 Dual OC leverer den nyeste NVIDIA Ampere-arkitekturen kombinert med rask ytelse og nye funksjoner. RTX 3070 Dual OC er robust og blir avkjølt effektivt av to aksiale vifter. Du får muligheten til å øke grafikkinnstillingene i favorittspillene dine med 8 GB GDDR6-minne og ta del i strålesporing og VRS (skygge med variabel hastighet), alt for en så maksimal spillopplevelse som mulig. Grafikkortet kommer overklokket fra fabrikken (OC), noe som gir deg raskere hastigheter. RTX 3070 Dual OC er også tilgjengelig med ASUS GPU Tweak II-programvaren, som vil hjelpe deg med alle grafikkortinnstillingene dine.','General,Buss type:PCI Express 4.0,Graphic program:NVIDIA GeForce RTX 3070,CUDA-Core:5888,Max resolution:7680 x 4320,Max supported screens:4,Interface:3 display ports,Interface:2 HDMI,Supported API:OpenGL 4.6;Memory,Size:8 GB,Technology:GDDR6 SDRAM,Memory speed:14 Gbps,Buss width:256-bit;System requirements,Required power supply:650 W,Extra requirement:2 x 8 pin PCI Express power connector;'),
(5,2,'MSI Radeon RX 6800 XT GAMING X TRIO 16G',12490,'MSI6800.PNG','MSI Radeon RX 6800 XT GAMING X TRIO er et robust og kraftig grafikkort med effektivt kjølesystem, slik at grafikkortet holder seg avkjølt under lengre spilløkter. Du kan spille i 4K med ekstremt jevn bildefrekvens ved hjelp av AMD RDNA 2-arkitekturen, som sørger for at oppløsning aldri går på kompromiss med oppdateringsfrekvensen. Her får du dessuten 16 GB GDDR-minne, tre TORX 4.0-vifter og RGB Mystic Light.MSI Radeon RX 6800 XT GAMING X TRIO har en raskere grafikkmotor sammenlignet med MSI Radeon RX 6800 GAMING X TRIO, hvor den integrerte og strømmende multiprosessoren har mulighet til å gjøre flere beregninger samtidig.','General,Buss type:PCI Express 4.0,Graphics program:AMD Radeon RX 6800 XT,Core clock:2045 MHz,Boost clock:2250 MHz,Flow Processors:4608,VR - ready:Yes,Max resolution:7680 x 4320,Max supported screen:4,Interface:HDMI,Interface:3 Display ports,Supported API:DirectX 12, OpenGL 4.6;Memory,Size:16 GB,Technology:GDDR6 SDRAM,Buss width:256-bit;System requirements,Required power supply:750 W,Extra requirements:2 x 8 pin PCI Express power connector;'),
(6,2,'Gigabyte Radeon RX 6800 XT GAMING OC',11990,'Gigabyte6800.PNG','AMD Radeon RX 6000 SeriesVi introduserer AMD Radeon RX 6000 Series -skjermkortene med den banebrytende AMD RDNA 2-arkitekturen, utviklet for å levere ekstremt kraftig ytelse til alle gamere. AMD Radeon RX 6000 Series- skjermkort driver en ny generasjon av konkurransespill og 4K-spill med levende grafikk og forbedrede opplevelser i alle slags spill og i alle rammer. Få den ultimate gamingopplevelsen med kraftige nye beregningsenheter, banebrytende AMD Infinity Cache og opptil 16 GB dedikert GDDR6-minne. Og sammen med en desktopprosessor i AMD Ryzen 5000 Series tilbyr AMD Smart Access Memory-teknologi nye nivåer av gamingytelse.','General,Buss type:PCI Express 4.0 x16,Graphics program:AMD Radeon RX 6800 XT,Boost clock:2285 MHz,Flow processors:4608,Process technology:7 nm,Max resolution:7680 x 4320,Max supported screens:4,Interface:2 HDMI,Interface:2 Display ports,Supported API:DirectX 12, OpenGL 4.6;Memory,Size:16 GB,Technology:GDDR6 SDRAM,Actual clock speed:16000 MHz,Buss width:256-bit,Bandwidth:512 GBps;System requirements,Required power supply:750 W,Extra Requirements:2 x 8 pin PCI Express power connector;'),
(7,8,'WQHD gaming monitor',4490,'WQHDGamimgSkjerm.PNG','LG 27GL83A-B er en 27\" WQHD-gamingskjerm (2560 x 1440) som gir deg tilgang til 144 Hz oppdateringsfrekvens med 1 ms responstid. De høye hastighetene gjør at spillet flyter bedre og blir spesielt verdsatt i raske actionspill. Skjermen har også utstyrt IPS-panel med 99% av sRGB, og dette gir deg både enestående fargenøyaktighet og bedre synsvinklel. Andre funksjoner inkluderer Adaptive Synk (FreeSync) og NVIDIA G-Sync-kompatibilitet.','General,Screen type:LED backlit LCD screen / TFT active matrix,Energy class:B,Diagonal size:27\'\',Visible size:27\'\',Yearly energy consumption:57 kWh,Adaptiv synchronization technology:AMD FreeSync, NVIDIA G-Sync Compatible,Standard resolution:QHD 2560 x 1440 at144 Hz,pixel distance:0.2331 mm,Brightness:350 cd/m²,Contrast ratio:1000:1,HDR format:HDR10,Supported colors :1.07 bilion colors,Response time:1 ms,Backlight technology:LED-backlight,Horisontal viewing angle:178,Vertical  viewing angle:178,Weight:6.1 kg,Dimentions:61.42 cm x 27.44 cm x 46.48 cm - with stand,screen cover:3H Hard Coating, Dis 25 %,Panel type:IPS;Power supply,Required mains voltage:AC 120/230 V (50/60 Hz),Power consumption (on):39 W,Power consumption (typical):51 watt,Power consumption in saving mode:0.5 watt;Mechanical,Display position adjustment:Height, pivot (rotation), tilt,VESA mounting interface:100 x 100 mm;Various,Custom standards:DisplayPort 1.4;Connectivity,Interface:2 HDMI,Interface:DisplayPort,Inteface:Headphones;');


CREATE TABLE IF NOT EXISTS Carts (
Cart_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
User_id INT UNSIGNED NOT NULL,
Product_id INT UNSIGNED NOT NULL,
Amount INT UNSIGNED NOT NULL,
Ordered VARCHAR(10) NOT NULL,
FOREIGN KEY (User_id) REFERENCES Customers (User_id),
FOREIGN KEY (Product_id) REFERENCES Products (Product_id)
);

CREATE TABLE IF NOT EXISTS Orders (
Order_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
User_id INT UNSIGNED NOT NULL,
Product_id INT UNSIGNED NOT NULL,
Amount INT UNSIGNED NOT NULL,
Date DATETIME NOT NULL DEFAULT NOW(),
FOREIGN KEY (User_id) REFERENCES Customers (User_id),
FOREIGN KEY (Product_id) REFERENCES Products (Product_id)
);

CREATE USER  IF NOT EXISTS "general" IDENTIFIED BY "general";
GRANT ALL privileges ON Webshop . * TO "general";
