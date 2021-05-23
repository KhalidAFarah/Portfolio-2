CREATE DATABASE IF NOT EXISTS Webshop;
USE Webshop;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Carts;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
User_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Firstname VARCHAR(50) NOT NULL,
Lastname VARCHAR(50) NOT NULL,
Username VARCHAR(50) NOT NULL,
Password VARCHAR(50) UNIQUE,
Email VARCHAR(70) UNIQUE,
Access_level INT NOT NULL DEFAULT 1
);
INSERT INTO Customers (Firstname, Lastname, Username, Password, Access_level) VALUES 
("Anonymous", "Anonymous", "admin", "admin", 2),
("Ahmed", "Iqbal", "ahmed", "ahmed2",1); 

CREATE TABLE Categories (
Category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(50) NOT NULL
);
INSERT INTO Categories (Name) VALUES ("Processor");
INSERT INTO Categories (Name) VALUES ("Graphic card");
INSERT INTO Categories (Name) VALUES ("PC");
INSERT INTO Categories (Name) VALUES ("Screen");

INSERT INTO Categories (Name) VALUES ("Headset");
INSERT INTO Categories (Name) VALUES ("Mouse");
INSERT INTO Categories (Name) VALUES ("Keyboard");
INSERT INTO Categories (Name) VALUES ("LED Lights");

CREATE TABLE Products (
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
(2,1,'AMD Ryzen 9 5900X Processor',6290,'amd9.PNG','Be unstoppable with the unmatched speed of the world''s best desktop processors. AMD Ryzen 5000 Series processors give you the best in high performance, whether you''re playing the latest games, designing the next skyscraper or chewing your way through scientific data. With the AMD Ryzen, you''re always ahead. ','Processor,Cores:12,Threads:24,Cache:64 MB,Cache-L2:6 MB,Cache-L3:64MB,Clock speed:3.7GHz,Max turbo speed:4.8 GHz,Compatible processor base:Socket AM4,Fabrikasjon process:7 nm,Thermal design power:105 W;'),
(3,1,'AMD Ryzen 7 3700X Prosessor',3449,'amd7.PNG','Optimal performanceHigher speeds, more memory and greater bandwidth than the previous generation. 3rd generation AMD Ryzen 7 processors with 7 nm Zen2 core set the standard for high performance: exclusive production technology, historic chip throughput and revolutionary gaming performance overall. AMDs 3rd Gen Ryzen ™ processors were designed based on this philosophy from the beginning, to break expectations and set a new standard for high-performance gaming processors.And that''s exactly what they''re doing. ','Processor,Cores:8,Threads:16,Cache:32 MB,Cache L3:32MB,Cache L2:4MB,Clock speed:3.6 GHz,Max turbo speed:4.4 GHz,Compatible processor base:Socket AM4,Fabrication process:7 nm,Thermal design power:65 W;'),
(4,2,'ASUS GeForce RTX 3070 Dual OC 8GB',8690,'asus3070.PNG','ASUS Geforce RTX 3070 Dual OC delivers the latest NVIDIA Ampere architecture combined with fast performance and new features. The RTX 3070 Dual OC is robust and is efficiently cooled by two axial fans. You get the ability to increase the graphics settings of your favorite games with 8 GB of GDDR6 memory and take part in beam tracking and VRS (variable speed shadow), all for the maximum gaming experience possible. The graphics card comes overclocked from the factory (OC), which gives you faster speeds. The RTX 3070 Dual OC is also available with the ASUS GPU Tweak II software, which will help you with all your graphics card settings.','General,Buss type:PCI Express 4.0,Graphic program:NVIDIA GeForce RTX 3070,CUDA-Core:5888,Max resolution:7680 x 4320,Max supported screens:4,Interface:3 display ports,Interface:2 HDMI,Supported API:OpenGL 4.6;Memory,Size:8 GB,Technology:GDDR6 SDRAM,Memory speed:14 Gbps,Buss width:256-bit;System requirements,Required power supply:650 W,Extra requirement:2 x 8 pin PCI Express power connector;'),
(5,2,'MSI Radeon RX 6800 XT GAMING X TRIO 16G',12490,'MSI6800.PNG','MSI Radeon RX 6800 XT GAMING X TRIO is a robust and powerful graphics card with an efficient cooling system, so that the graphics card stays cool during longer gaming sessions. You can play in 4K with extremely smooth frame rate using the AMD RDNA 2 architecture, which ensures that resolution never compromises on refresh rate. You also get 16 GB GDDR memory, three TORX 4.0 fans and RGB Mystic Light. MSI Radeon RX 6800 XT GAMING X TRIO has a faster graphics engine compared to MSI Radeon RX 6800 GAMING X TRIO, where the integrated and streaming multiprocessor has the option to do multiple calculations at once.','General,Buss type:PCI Express 4.0,Graphics program:AMD Radeon RX 6800 XT,Core clock:2045 MHz,Boost clock:2250 MHz,Flow Processors:4608,VR - ready:Yes,Max resolution:7680 x 4320,Max supported screen:4,Interface:HDMI,Interface:3 Display ports,Supported API:DirectX 12:Memory,Size:16 GB,Technology:GDDR6 SDRAM,Buss width:256-bit;System requirements,Required power supply:750 W,Extra requirements:2 x 8 pin PCI Express power connector;'),
(6,2,'Gigabyte Radeon RX 6800 XT GAMING OC',11990,'Gigabyte6800.PNG','AMD Radeon RX 6000 SeriesWe introduce the AMD Radeon RX 6000 Series graphics cards with the groundbreaking AMD RDNA 2 architecture, designed to deliver extremely powerful performance to all gamers. AMD Radeon RX 6000 Series graphics card drives a new generation of competitive games and 4K games with vivid graphics and enhanced experiences in all kinds of games and in all settings. Get the ultimate gaming experience with powerful new computing devices, groundbreaking AMD Infinity Cache and up to 16 GB of dedicated GDDR6 memory. And with an AMD Ryzen 5000 Series desktop processor, AMD Smart Access Memory technology offers new levels of gaming performance. ','General,Buss type:PCI Express 4.0 x16,Graphics program:AMD Radeon RX 6800 XT,Boost clock:2285 MHz,Flow processors:4608,Process technology:7 nm,Max resolution:7680 x 4320,Max supported screens:4,Interface:2 HDMI,Interface:2 Display ports,Supported API:DirectX 12, OpenGL 4.6;Memory,Size:16 GB,Technology:GDDR6 SDRAM,Actual clock speed:16000 MHz,Buss width:256-bit,Bandwidth:512 GBps;System requirements,Required power supply:750 W,Extra Req'),
(7,4,'WQHD gaming monitor',4490,'WQHDGamimgSkjerm.PNG','LG 27GL83A-B is a 27\" WQHD gaming screen (2560 x 1440) that gives you access to 144 Hz refresh rate with 1 ms response time. The high speeds make the game flow better and are especially appreciated in fast action games. The screen also has an IPS panel with 99% of sRGB, and this gives you both outstanding color accuracy and better viewing angle. Other features include Adaptive Sync (FreeSync) and NVIDIA G-Sync compatibility. ','General,Screen type:LED backlit LCD screen / TFT active matrix,Energy class:B,Diagonal size:27\'\',Visible size:27\'\',Yearly energy consumption:57 kWh,Adaptiv synchronization technology:AMD FreeSync, NVIDIA G-Sync Compatible,Standard resolution:QHD 2560 x 1440 at144 Hz,pixel distance:0.2331 mm,Brightness:350 cd/m²,Contrast ratio:1000:1,HDR format:HDR10,Supported colors :1.07 bilion colors,Response time:1 ms,Backlight technology:LED-backlight,Horisontal viewing angle:178,Vertical  viewing angle:178,Weight:6.1 kg,Dimentions:61.42 cm x 27.44 cm x 46.48 cm - with stand,screen cover:3H Hard Coating, Dis 25 %,Panel type:IPS;Power supply,Required mains voltage:AC 120/230 V (50/60 Hz),Power consumption (on):39 W,Power consumption (typical):51 watt,Power consumption in saving mode:0.5 watt;Mechanical,Display position adjustment:Height, pivot (rotation), tilt,VESA mounting interface:100 x 100 mm;Various,Custom standards:DisplayPort 1.4;Connectivity,Interface:2 HDMI,Interface:DisplayPort,Inteface:Headphones;'),
(8,4,'Lenovo L22e',1290,'Lenovo L22e.PNG','The Lenovo L22e is a 21.5 \"Full HD display suitable for the office due to its thin frames and wide viewing angle. The thin frames allow you to use several screens next to each other without a large space, and the viewing angle makes it easy to view screen content for family or colleagues.','General,Type:LED backlit LCD screen,Diagonal size:21.5\",Visible size:21.5\",Side ratio:16:9,Standard resolution:Full HD (1080p) 1920 x 1080 at 60 Hz,Vertical recoverry rate:76 Hz,Horisontal recovery rate:90 kHz,Backlight technology:LED backlight,Dimentions(WxLxH):48.93 cm x 20 cm x 37.38 cm,Energy class:D;Connectivity,Interface:VGA,Interface:HDMI;Mechanical,Display position adjustment:Tilt,Tilt angle:-5/ 22,VESA mounting interface:100 x 100 mm;Power supply,Required mains voltage:AC 120/230 V (50/60 Hz),Power consumption during operation:22 watt,Power Consumption (Typical):22 watt,Standby power consumption:0.3 watt,Power consumption in save mode:0.3 watt;'),
(9,4,'Acer Nitro QG271bii',1790,'acerNitro.PNG','Acer Nitro QG271Ybii er en 27\" large gaming monitor with Full HD resolution and a fast response time of only 1 ms (VRB) which ensures that it is ready for play in fast action and racing games. Nitro QG271Ybii has also been equipped with AMD FreeSync You can also take advantage of features such as Acer Flicker-less and Acer BlueLightShield, which reduces the strain on the eyes and provides comfort even during long game marathons. Full HD resolution (1920 x 1080) With a resolution of 1920 x 1080 you will see all the details. You get to experience a brightness of 250 cd / m², good contrast and realistic colors that give a realistic image. AMD Radeon FreeSyncAMD FreeSync technology eliminates tearing in the image and choppy frame rates to give you seamless graphics and smooth gaming experiences. This gives you the edge in FPS, racing and strategy games in real time. AMD FreeSync ensures that the image speed is determined by your graphics card and is not limited by the screen, this means that the image speed of the graphics card and the screen is synchronized for a smooth and sharp result.1 ms response time (VRB) VRB (Visual Response Boost) technology creates the effect of 1 ms Moving Picture Response Time (MPRT). This is done by quickly turning off the backlight or inserting a blank, black image between the frames, also known as a \ "blink \". This results in less noticeable blur when images change rapidly. Acer Flicker-less and Acer BlueLightShieldAcer Flickerless technology eliminates screen flicker by providing a stable power supply to the screen. This counteracts tired eyes after sitting in front of a computer for a long time for a comfortable computer experience. This monitor also has Acer BlueLightShield which protects you from harmful blue light. ','General,Type:LED backlit LCD screen / TFT active matrix,Energy class:F,Diagonal size:27\",Adaptive synchronization technology:AMD FreeSync,Panel type:VA,Side ratio:16:9,Standard resolution:Full HD (1080p) 1920 x 1080 at 75 Hz,Brightness:300 cd/m^2,Contrast ratio:3000:1 / 100000000:1 (dynamic),Color support:16,7 million colors,Response time: 1ms (VRB),Vertical recovery rate:56 - 76 Hz,Horizontal recovery rate:30 - 85 kHz,screen cover:Anti-reflex,Backlight technology:LED backlight,Dimentions (WxLxH):61.4 cm x 24 cm x 45.4 cm - with stand;Connectivity,Interface:VGA,Interface:2 x HDMI;Mechanical,Display position adjustment:Tilt,Tilt angle:-5/ 25,VESA mounting interface:100 x 100 mm;Power supply,Input voltage: InngangsspenningAC 120/230 V (50/60 Hz),Power consumption (on mode):26.1 W,Power consumption SDR (on mode):26.1 kWh/1000t,Power consumption (typical):24 watt,Standby power consumption:0.3 watt,Power consumption (off mode):0.25 watt;'),
(10,3,'HP Pavilion TG01-1811no Desktop Gaming PC',7495,'Pavilion.PNG','The HP Pavilion TG01-1811no Desktop Gaming PC has the qualities that will help you raise your gaming level. With NVIDIA graphics, AMD Ryzen ™ 5 processor and more, the PC''s gaming-oriented design will give you the power to play your favorite titles with high FPS and climb the rankings.The power of Ryzen ™AMD Ryzen ™ 5 4600G APU is a processor with integrated graphics solution. The base frequency is 3.7 GHz, and the clock frequency can be increased to 4.2 GHz with six cores in use. The processor is supported by 8 GB DDR4 RAM.Next generation graphicsWith the Nvidia GeForce GTX 1650, you get excellent visual quality, even for resource-intensive games. The graphics card comes with 4 GB of RAM and is built around the next generation Turing architecture so that you can play in Full HD 1080p quality with high frame rate.StorageThe 512 GB SSD disk provides fast start-up of both PC, games and programs.HDMIVia the HDMI v2.0 output on the graphics card, you can connect an HD TV or projector to display images and videos in up to 4K UHD resolution on a large screen.Connectivity:- 1 piece. HDMI 2.0, 1 pc. DVI- 1 piece. USB-C 3.2 Gen 1 port- 4 pcs. USB-A 3.2 Gen 1 port- 4 pcs. USB-A 2.0 ports- Lightning fast dual-band WiFi-ac, Bluetooth 4.2, Gigabit LAN port- 3-in-1 memory card reader- 1 piece. line-in, 1 pc. line-out, 1 pc. microphone port- 1 piece. 3.5 mm combined port for headphones / microphoneOther features:- Windows 10 Home 64-bit- 5.1 surround sound','Model description,Type:Gaming PC,Series:Pavilion,Chassis type:Black (Full Tower);Processor,CPU manufacturer:AMD,Type:AMD Ryzen 5,Cores:6,Threads:12,Speed:3,70 GHz,Maximum speed:4,20 GHz,Cache:8 MB,Chipset:AMD Promontory B550A;Motherboard,Model:Erica3;Storage and memory,RAM type:DDR4,RAM size:8 GB,Memory speed:3200,Type of storage:SSD,Type SSD:M.2 PCIe NVMe SSD,Storage capacity:512 GB;Graphics,Architecture graphics card:Dedicated,Number of graphics cards:1,Main brand (GPU):NVIDIA,Graphics Solution (Manufacturer):NVIDIA,Graphics solution (Model):GeForce GTX 1650,Dedicated video memory:4;Power supply,Power supply:310 W;'),
(11,3,'PCSpecialist Tornado R5 Gaming PC',11495,'TornadoR5.PNG','1.CPU:Combine hardcore gaming and seamless streaming into one with the Tornado R5 Gaming PC. Packed with a Six Core/Twelve thread Ryzen 5 3600 CPU (3.6GHz – 4.2GHz Max Boost): demand more with the superior multi-threaded performance of AMD Ryzen™. Experience your movies, photos, and the most popular esports games in Full HD (1920 x 1080) at high settings.2.    GPU:The GeForce® 1660 is built with the breakthrough graphics performance of the award-winning NVIDIA Turing™ architecture. Easily upgrade your PC and get performance that rivals the GeForce GTX 1070*, a 16 Series GPU is a blazing-fast supercharger for today’s most popular games, and even faster with modern titles.3.    Gaming Potential:Great for esports and popular PC gaming titles such as Apex Legends, Fortnite, Valorant, CS GO, Call of Duty Modern Warfare and more.4.    Features:Maintain smooth performance in your favourite suite of programs thanks to the included 8GB of high-quality Corsair DDR4 RAM and a reliable wireless connection, through the WiFi 6 and Blue tooth 5.0 technology. PCSpecialist have included a superfast 256GB M.2 SSD and a large 1TB Hard Drive with room to upgrade components should you want to in the future – just give PC Specialist a call!5.    Warranty:Whether you’re into gaming, streaming, watching movies or keeping up to date with your friends, the Tornado R5 Gaming PC has everything you need and more. All of PC Specialist’s award winning PCs are covered with a 3 Year Standard Warranty package and supported by our UK-based Customer Service Team.','Model description,Type:Gaming PC;Processor,CPU manufacturer:AMD,Processor type:AMD Ryzen 5,Cores:6,Speed:3.60 GHz,Maximum speed:4.20 GHz;Motherboard,Brand:Asus,Model:A320,SLI support:No;Storage and memory,RAM type:DDR4 Onboard,Size:8 GB,Type SSD:M.2 PCIe NVMe SSD,Storage capacity SDD:256 GB,Storage capacity HDD:1000 GB,Number of installed HDDS:2;Graphics,Architecture graphics card:Dedicated,Main brand (GPU):NVIDIA,Graphics Solution (Manufacturer):NVIDIA,Graphics solution (Model):GeForce GTX 1660,Dedicated video memory:6,Memory speed:2400 MHz;'),
(12,3,'Acer Chromebook CB514',4490,'Acer.png','The combination of a metallic case, a Corning® Gorilla® Glass trackpad, USB Type-C and a 12-hour battery life gives the Chromebook a luxurious look and feel.','General,Product Type:Chromebook,Operating System:Google Chrome OS,Battery Time:12h;Processor,CPU:Intel Celeron N3450 ,Max Turbo Speed:2.2GHz,Number of cores :4,Properties:Intel Burst Technology;RAM,Memory:4GB,Technology:LPDDR4 SDRAM;Screen,Screen:14inch,Screen Technology:LED,Screen Resolution:1920x1080 Full HD;Sound'),
(13,5,"HUAWEI FREEBUDS STUDIO HEADPHONES GRAPHITE BLACK", 2990, "huawei headset.png", "HUAWEI FreeBuds Studio headphones are also great for gaming. When you play, the headphones automatically switch to low latency mode for the best gaming experience. The headphones also have smart wear recognition, which allows the headphones to automatically stop playing music when you remove the headphones and continue when you put them on your head. The headphone's touch and swipe controls make it easy to stop playback, change tracks, answer calls, and adjust the volume.", "Features,Connection:Wireless,Headphone type:Around Ear/ Over-Ear ,Microphone:Yes,Active noise cancellation:Yes;Wireless features,Connection:Bluetooth,Type bluetooth:Bluetooth 5.2;Power and battery,Battery life:24 hours,Charging time:1 hour;Other specifications,Net weight:0.265 kg,Net measurements without packaging:194.0 x 152.0x82.0 mm,Primary color:Black;"),
(14,5,'JBL EVEREST V710GA OVER EAR SILVER',2499,'JBL HEADSET.png','The JBL Everest 710 offers unmatched sound provided by the legendary JBL Pro Audio Sound, not to mention the unparalleled comfort offered by the premium materials. ShareMe 2.0 technology allows you to connect and share music with friends, via Bluetooth. A fast 2-hour charge, a sleek flat folding design and a compact hard carrying case make these headphones the perfect companion when traveling. The built-in microphone enables crystal-clear hands-free calling, and the convenient controls on the earcup allow you to adjust volume and change songs easily.','Features,Connection:Wireless,Microphone:Yes,Active noise cancellation:No;Wireless features,Connection:Bluetooth;design and layout,Material:Plastic;Other specifications,Net weight:0.460 kg,Net measurements without packaging:68.0 x 207.0 x 223.0 mm;'),
(15,5,'SONY WH-CH510 ON-EAR BLACK',299,'SONY headset.png','The Sony WH-CH510 provides up to 35 hours of non-stop listening. Sound, which can be streamed wirelessly from a mobile or tablet with Bluetooth 5.0 technology, is pumped out through closed dynamic speaker elements of as much as 30 mm. And if you connect the WH-CH510 to your smartphone, you can also use the built-in microphone for hands-free calling.','Features,Connection:Wireless,Active noise cancellation:No,Microphone:Yes,Headphone type:On Ear;Wireless features,Connection:Bluetooth,Bluetooth type:Bluetooth 5.0;Power and battery ,Battery life:35 hours;Other specifications,Net weight:0.143 kg,Net measurements without packaging:172.0 x 160.0 x 70.0 mm,Primary color:Black;'),
(16,7,'ELETRA EK1000 CABLE KEYBORD',199,'ELETRA keybord.png','Excellent wired USB keyboard from Eletra. Slim and light design is well suited where it is cramped. The full-size keyboard has all the necessary buttons, including the numpad.','Connections,Wireless:No;Qualities,Keyboard layout:Nordic,Size:Standard;Other specification,Net weight:0.110 kg,Net measurements without packaging:25.0 x 145.0 x 440.0 mm;'),
(17,7,'COUGAR ATTACK X3 RGB GAMING KEYBORD CHERRY MX SILVER',999,'COUGAR keybord.png','The keyboard has an aluminum surface that looks good even without light. When you long for the mood and want to see the keys even in the dark, you can set the colors as you wish at the top, thanks to the RGB lights. The keyboard has several preset light settings, and with the COUGAR UIX system you can create your own unique light show to create mood. The secret behind the shocking speed lies in the Attack X3 RGB Speedy switches, which have a response time of 1 ms and require a key depth of only 1.2 mm which is the shortest of all Cherry MX switches.','Design and layout,Material:Plastic,Primary color:Black;Connections,Wireless:No;Qualities,Keybord layout:Nordic,Adapted for gaming:Yes,Size:Standard,type of lighting:RGB;Other specification,Net weight:0.900 kg,Net measurements without packaging:170.0 x 467.0 x 40.0 mm;'),
(18,7,'LOGITECH K270 WIRELESS KEYBORD',399,'logitech keybord.png','Compact full-size wireless keyboard with numeric keypad. Easy setup against your PC with the small Unifying receiver that can stay in the laptop at all times. You can also easily add up to 5 additional Unifying-compatible wireless mice or keyboards, without controlling with multiple USB receivers. With advanced 2.4 GHz wireless connection from Logitech, you avoid signal loss, even up to 10 meters away from the receiver. Automatic sleep mode gives the keyboard good battery capacity, up to 24 months.','Design and layout,Primary color:Black;Connections,Wireless:Yes,Wireless Connection:2.4 GHz;Qualitites,Keybord layout:Nordic,Adapted for gaming:No,Size:Standard,Lighting:No,Media buttons:Yes;Other specifications,Net weight:0.660 kg,Battery life:24 months,Water-repellent keyboard design :Yes;'),
(19,6,'LOGITECH MX ANYWHERE 3 WIRELESS MOUSE GRAFITT',799,'Logitech mouse.png','MX Anywhere 3 is a compact wireless mouse with a modern design designed to work precisely on different surfaces and with different operating systems. This comfortable mouse has a 4000 DPI Darkfield sensor, fast and precise MagSpeed scrolling and configurable buttons. The compact ergonomic design with low profile and super-soft silicone side grips provide comfort everywhere, and the MX Anywhere 3 is comfortable to use at home or on the go. The sensor works precisely on almost all surfaces - even glass (4 mm minimum thickness), which allows you to work seamlessly whether you are in the office, in the cafe or on the sofa in the living room.','Design and layout,Primary color :Grey;Connections,Wireless:Yes,Wireless connection:Bluetooth;Qualities,DPI:4000,Adapted for gaming:No,Battery life:1680 hours,Number of buttons:6;Other specification,Net weight:0.099 kg,Net measurements without packaging:101.0 x 65.0 x 34.0 mm;'),
(20,6,'RAZER NAGA PRO WIRELESS GAMING MOUSE',1799,'RAZER naga pro mouse.png','Razer Naga Pro is a versatile wireless gaming mouse with three interchangeable side panels. Thanks to the modular design and the interchangeable side panels, you can take control of any game genre with up to 20 customizable buttons. Wireless Razer ™ HyperSpeed technology provides an ultra-fast and low-latency wireless connection for demanding gaming. The mouse''s advanced Razer Focus   optical sensor with true 20,000 DPI resolution offers a whole new level of precision and speed. With a resolution of up to 99.6%, the crosshairs remain on target even during the fastest situations. It has an incredibly long battery life of up to 100 hours in HyperSpeed mode to ensure you can play through the longest game sessions.With high-quality switches designed for gaming, every mouse click is activated at the speed of light. Razer optical mouse switches use an infrared light beam to detect clicks and provide an incredibly fast response time of 0.2 ms, which is up to three times faster than a standard mechanical switch. The switches have a service life of up to 70 million presses.','Design and layout,Material:Plastic,Primary color:Black ;Connections ,Wireless:Yes,Wireless connection:Bluetooth 2.4 GHz;Qualities,DPI:20 000,Adapted for gaming:Yes,Battery life:150 hours,Type of lighting:RGB,Acceleration:50 G,Amount of buttons:20,Polling rate:1000 Hertz (1/second),Internal memory:Yes,IPS:650;Other specification,Net weight :0.110 kg,Lifetime on switches:70 million clicks;'),
(21,6,'CEPTER GLADIUS MMO-GAMING MOUSE',1299,'CEPTER GLADIUS mouse.png','Cepter Gladius is a versatile MMO gaming mouse with adjustable buttons and replaceable side panels. Do not let the mouse restrict you from playing MMO games. Make the gaming experience perfectly suited to your gaming style by selecting a side panel with up to nine buttons.Gladius comes with software that allows you to adjust button functions, macros, lighting, DPI and mouse resolution. The mouse has a 6-speed DPI switch that can be adjusted between 800/1600/2400/3600/5000/10 000 to suit your playing style. Mouse lighting can be easily adjusted with the software to your liking. Adjust multiple mouse profiles and save settings to suit different games.','Design and layout ,Material:Plastic,Primary color :Black ;Connections ,Wireless:No,Cable length:1.8 meter;Qualities ,DPI:10 000,Adapted for gaming:Yes,Type of lighting:RGB ,Amount of buttons:14,Adapted for:Right hand;Other specification ,Net weight:0.113 kg,Net measurements without packaging:160.0 x 230.0 x 70.0 mm,USB-connection:Yes;'),
(22,8,'Elgato Key Light',2399,'elgato.png','Quality lighting is the secret behind the camera''s gloss feed. From the way you smile and celebrate to the way you focus and freak out - viewers want to see every expression in detail. After all, you''re the star of the show. They subscribe to see you. And with Key Light, they instantly learn that you''re a pro.','General,Width:35cm,Length:25cm,Depth:3cm,Dimmable:Yes;Light Head,Number of lamps:160,Brightness in LUX:2500,Functions:Color Temperature control;'),
(23,8,'Philips Hue White ',839,'philips.png','Extend the TV experience to the whole room, or take the gaming experience to a new level. Download a third-party app and discover the amazing things you can do with your Philips hat. Or you can sync the light to your favorite music and get the most out of it. You can turn any room into a dance floor and see how the lights respond to the music, download one of the third-party apps and start the party with your Philips hat.','Light Source,Type:LED ,Socket Type:E27,Watt Usage:10W,Light Bulb class:A ,number of colors:16 million,Function:remote control;Size'),
(24,8,'Philips Hue',1699,'philip_hue.png','Philips Hue starter kit with bridge and three smart LED bulbs that provide a soft, warm white to cold daylight (2000-6500 K) and can light up to 16 million colors. Can be adapted to music, used as a wake-up light and synchronized with other light bulbs / lamps. The bridge is connected to a router, and the light bulbs are then controlled directly via an app on the mobile.','Light Source,Socket Type:GU10,Watt usage:5.7W,Light Class:A ,Colors:16 million colors,Dimmable:Yes,Lifetime:15000h,Function:Immediate full light;Size'),
(25,3,'Lenovo IdeaCentre G5',8000,'lenovoG5.png','This formidable tower is made especially for games and e-sports and opens up completely new productivity and creativity opportunities. IdeaCentre Gaming 5 is equipped with AMD Ryzen 5 3600 processor, dedicated graphics cards up to NVIDIA GTX 1650, 8 GB DDR4 memory and good storage options, all in a light-breaking chameleon blue packaging.','Processor,CPU:AMD Ryzen 5 3600 / 3.6 GHz,Max Turbo Speed:4.2GHz,Number of Cores:6,Number of CPU''s:1,Chipset Type:AMD PRO 565;RAM,Installed Size:8GB,Real Memory Speed:3200 MHz;Hard Disk,Type:SSD - M.2 2242,Capacity:1 x 512 GB,Interface Type:PCI Express,Features:NVM Express (NVMe);Size'),
(26,3,'MacBook Air 13 (2020) 256GB',11990,'mac.png','Apple''s thinnest and lightest laptop gets superpowers with the Apple M1 chip. Get rid of your projects with a lightning-fast eight-core processor. Take graphics-heavy apps and games to the next level with a graphics processor of up to eight cores. And speed up machine learning with a 16-core Neural Engine. In addition, it is fanless and completely silent, and has the longest battery life ever - up to 18 hours¹. MacBook Air. Still easy to take with you. Just much more powerful.','Operating System,Operating system:MacOs;Producer,Brand:Apple;Processor,Processor:Intel® Core™ i3;Graphic,Graphicprocessor(family):Iris Plus Graphics,Graphicprocessor(model):Intel Iris Plus Graphics 645,Dedicated Graphicprocesso:No;Storage,Type of Storage:SSD,Total Storage Capasity:256GB,SSD Capacity:256GB;RAM,Memory capacity:8GB,RAM:8 GB (2x4 GB);Screen,Screen Size:13.3 Inch,Screen Resolution:2560x1600,Screen Technology:LED,Touchscreen:No;Properties,Formfactor on Pc:Macbook,For Gaming:No;Other Properties,NettoWeight:1.449 kg,Artikkel ID:1068138,Battery Time:15h,Charging port:USB-C;');

CREATE TABLE Carts (
Cart_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
User_id INT UNSIGNED NOT NULL,
Product_id INT UNSIGNED NOT NULL,
Amount INT UNSIGNED NOT NULL,
FOREIGN KEY (User_id) REFERENCES Customers (User_id),
FOREIGN KEY (Product_id) REFERENCES Products (Product_id)
);

CREATE TABLE Orders (
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
