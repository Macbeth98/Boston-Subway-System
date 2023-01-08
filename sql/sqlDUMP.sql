CREATE DATABASE  IF NOT EXISTS `GaddamMSivakumarN` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `GaddamMSivakumarN`;
-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: GaddamMSivakumarN
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
-- Table structure for table `administrative_staff`
--

DROP TABLE IF EXISTS `administrative_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrative_staff` (
  `responsibilities` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `staff_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_id` int NOT NULL,
  `station_id` int NOT NULL,
  PRIMARY KEY (`employee_id`,`station_id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  KEY `station_fk_administrative_staff` (`station_id`),
  CONSTRAINT `employees_fk_administrative_staff` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `station_fk_administrative_staff` FOREIGN KEY (`station_id`) REFERENCES `station` (`station_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrative_staff`
--

LOCK TABLES `administrative_staff` WRITE;
/*!40000 ALTER TABLE `administrative_staff` DISABLE KEYS */;
INSERT INTO `administrative_staff` VALUES ('Checking','Admin',1,1),('Issuing','Admin',2,2),('Checking','Admin',3,3),('Issuing','Admin',4,4),('Issuing','Admin',5,5),('Issuing','Admin',6,6),('Issuing','Admin',7,7),('Checking','Admin',8,8),('Checking','Admin',9,9),('Checking','Admin',10,10),('Checking','Admin',11,11),('Issuing','Admin',12,12),('Checking','Admin',13,13),('Checking','Admin',14,14),('Issuing','Admin',15,15),('Checking','Admin',16,16),('Checking','Admin',17,17),('Checking','Admin',18,18),('Issuing','Admin',19,19),('Checking','Admin',20,20),('Checking','Admin',21,21),('Ticket checking','Worker',51,1);
/*!40000 ALTER TABLE `administrative_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargo_unit`
--

DROP TABLE IF EXISTS `cargo_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo_unit` (
  `tram_id` int NOT NULL,
  `cargo_capacity` int DEFAULT NULL,
  `cargo_blocks` int DEFAULT NULL,
  PRIMARY KEY (`tram_id`),
  CONSTRAINT `tram_fk_cargo_unit` FOREIGN KEY (`tram_id`) REFERENCES `tram` (`tram_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo_unit`
--

LOCK TABLES `cargo_unit` WRITE;
/*!40000 ALTER TABLE `cargo_unit` DISABLE KEYS */;
INSERT INTO `cargo_unit` VALUES (1,200,4),(2,300,5),(3,100,3),(4,300,2),(5,200,5),(6,100,3),(7,100,3),(8,100,3);
/*!40000 ALTER TABLE `cargo_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_code` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`city_code`),
  UNIQUE KEY `city_state_name` (`state_name`,`city_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Boston','MA');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `employee_dob` date NOT NULL,
  `employee_sex` enum('M','F') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_address` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_shift_timings` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `employee_salary` int NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'smith','1988-05-07','M','1 Parker Street','7am to 3pm',20),(2,'damon','1989-05-09','M','2 marcella Street','9am to 4pm',21),(3,'tina','1985-06-17','F','22 calumet Street','3pm to 6pm',20),(4,'taylor','1982-09-27','M','1 smith Street','3pm to 6pm',20),(5,'gracia','1989-05-16','F','2 stagecoach rd','3pm to 6pm',20),(6,'sylvie','1995-05-27','F','10 Hill Street','7am to 3pm',20),(7,'Ashwin','1990-08-17','M','5 green Street','8am to 4pm',30),(8,'Aswath','1992-03-15','M','221 Parker Street','5pm to 1am',30),(9,'Janani','1996-09-14','F','12 smith Street','6pm to 1am',30),(10,'Madhu','1988-08-24','F','2 Center Street','9am to 3pm',30),(11,'James','1993-11-07','M','2 Green Street','9am to 3pm',30),(12,'Noah','1987-07-12','M','5 South Street','6pm to 1am',30),(13,'Jack','1995-05-17','M','45 Center Street','6pm to 1am',30),(14,'Liam','1988-05-13','M','8 Main Street','6pm to 1am',30),(15,'Anthony','1994-10-03','M','22 Parker Hill Ave','9am to 3pm',30),(16,'Aditi','1996-04-13','F','25 Parker Hill Ave','6pm to 1am',20),(17,'Neha','1986-07-07','F','22 Mission Main Ave','9am to 5pm',20),(18,'Naveen','1988-06-17','M','256 Center Street','2pm to 10pm',30),(19,'Arte Harms','1991-09-18','F','5543 Elmside Drive','5 AM to 2 PM',55),(20,'Giorgio Lambregts','1997-09-10','F','2 Ridgeview Point','6 PM to 3AM',61),(21,'Fayina Garrity','1998-01-11','F','9965 Veith Junction','2 PM to 9 PM',51),(22,'Ginger Cunde','1996-01-22','M','12784 Eagan Lane','2pm to 4pm',40),(23,'Claus Denne','1989-09-11','F','63 Holmberg Trail','1pm to 9pm',92),(24,'Denny Tremollet','1997-03-31','F','68746 Bunker Hill Court','9am to 5pm',68),(25,'Marsha Woodings','1998-04-25','M','313 Oak Crossing','10am to 6pm',98),(26,'Pascale Favel','1997-02-25','M','22 Continental Place','8am to 5pm',33),(27,'Yorke Yewman','1988-07-11','F','3 West Street','3pm to 10pm',62),(28,'Fayre Brandino','1987-07-08','M','70285 Chinook Junction','4pm to 12am',58),(29,'Alon Purdie','2000-07-18','F','28414 Cottonwood Parkway','2pm to 10pm',27),(30,'Petronilla Mathewes','1999-08-26','M','30 Butternut Park','10am to 4pm',70),(31,'Erroll Parysiak','1987-09-11','M','372 Golden Leaf Trail','10am to 6pm',69),(32,'Genvieve Ysson','1991-09-12','M','8 Hoffman Alley','9am to 5pm',52),(33,'Ximenez Metzig','1991-03-05','F','3097 Anderson Avenue','10am to 6pm',82),(34,'Adelind Frankiss','1998-10-27','F','500 Carioca Junction','6pm to 1am',27),(35,'Mart Sherme','1987-03-27','M','4381 Farragut Place','6pm to 12am',89),(36,'Iggie McIlharga','2000-08-24','F','6105 Larry Street','4pm to 10pm',51),(37,'Britni Gerding','1996-07-14','F','9374 Mosinee Hill','3pm to 10pm',62),(38,'Vevay Kunkler','1998-07-08','M','8872 Laurel Place','8am to 4pm',51),(39,'Stevy Tuffield','1995-11-20','F','16227 Kipling Park','12pm tp 7pm',27),(40,'Lavena Acreman','1997-03-01','M','0 Old Shore Park','11am to 6pm',75),(41,'Morena Reach','1987-06-09','F','993 Kim Circle','10am to 6pm',75),(42,'Consalve Milhench','1997-11-20','M','488 Sachtjen Junction','10am to 5pm',56),(43,'Phoebe Osburn','2994-06-08','M','82 Oak Circle','4pm to 11pm',41),(44,'Paulie Simoncini','1994-09-20','F','939 Oxford Crossing','3pm to 10pm',91),(45,'Man Rounsefull','1990-11-10','M','692 Melvin Road','3pm to 11pm',29),(46,'Archaimbaud Keepe','1981-01-21','F','6039 Del Mar Hill','4pm to 11pm',30),(47,'Robby Faithfull','2000-01-14','M','39964 Sutherland Circle','9am to 4pm',76),(48,'Stavro Gamlin','1990-03-16','F','2 Maple Drive','10am to 5pm',93),(49,'Jeno Shoulders','1996-01-24','F','59879 Kensington Park','9am to 4pm',91),(50,'Clerkclaude Feenan','1986-08-23','M','397 Troy Center','10am to 5pm',91),(51,'Arul','1998-09-19','M','65 Staint St, Boston, MA - 02215','9 am to 6 pm',30);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line`
--

DROP TABLE IF EXISTS `line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line` (
  `line_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`line_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line`
--

LOCK TABLES `line` WRITE;
/*!40000 ALTER TABLE `line` DISABLE KEYS */;
INSERT INTO `line` VALUES ('Blue Line'),('Green Line B'),('Green Line C'),('Green Line D'),('Green Line E'),('Orange Line'),('Red Line'),('Red Line M');
/*!40000 ALTER TABLE `line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `luggage`
--

DROP TABLE IF EXISTS `luggage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `luggage` (
  `luggage_id` int NOT NULL AUTO_INCREMENT,
  `luggage_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `luggage_weight` int DEFAULT NULL,
  `tram_id` int DEFAULT NULL,
  `ticket_id` int DEFAULT NULL,
  PRIMARY KEY (`luggage_id`),
  KEY `tram_fk_luggage` (`tram_id`),
  KEY `ticket_fk_luggage` (`ticket_id`),
  CONSTRAINT `ticket_fk_luggage` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tram_fk_luggage` FOREIGN KEY (`tram_id`) REFERENCES `tram` (`tram_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `luggage`
--

LOCK TABLES `luggage` WRITE;
/*!40000 ALTER TABLE `luggage` DISABLE KEYS */;
INSERT INTO `luggage` VALUES (8,'suitcase',12,1,19),(9,'suitcase',12,1,20),(10,'suitcase',12,1,21),(11,'suitcase',12,1,22),(12,'suitcase',12,1,23),(13,'suitcase',12,1,24),(14,'suitcase',12,1,25),(15,'suitcase',12,1,26),(16,'suitcase',12,1,27),(17,'suitcase',12,1,28),(18,'suitcase',12,1,29),(19,'suitcase',12,1,30),(20,'suitcase',12,1,31),(21,'suitcase',12,1,32),(22,'suitcase',12,1,38),(23,'suitcase',12,1,41),(24,'suitcase',12,1,42),(25,'suitcase',12,1,43),(26,'suitcase',40,5,44),(27,'suitcase',40,5,45),(28,'suitcase',40,5,46);
/*!40000 ALTER TABLE `luggage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `employee_id` int NOT NULL,
  `station_id` int NOT NULL,
  PRIMARY KEY (`employee_id`,`station_id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  UNIQUE KEY `station_id` (`station_id`),
  CONSTRAINT `employees_fk_manager` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `station_fk_manager` FOREIGN KEY (`station_id`) REFERENCES `station` (`station_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (22,2),(23,3),(24,4),(25,5),(26,6),(27,7),(28,8),(29,9),(30,10),(31,11),(32,12),(33,13),(34,14),(35,15),(36,16),(37,17),(38,18),(39,19),(40,20),(41,21),(42,1);
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motorman`
--

DROP TABLE IF EXISTS `motorman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `motorman` (
  `license_id` int NOT NULL,
  `tram_experience` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  PRIMARY KEY (`license_id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  CONSTRAINT `employees_fk_motorman` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motorman`
--

LOCK TABLES `motorman` WRITE;
/*!40000 ALTER TABLE `motorman` DISABLE KEYS */;
INSERT INTO `motorman` VALUES (721270,9,46),(751348,5,44),(766024,10,43),(782479,3,45),(787520,5,49),(822709,5,48),(840108,9,47),(919604,4,50);
/*!40000 ALTER TABLE `motorman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motorman_tram`
--

DROP TABLE IF EXISTS `motorman_tram`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `motorman_tram` (
  `employee_id` int NOT NULL,
  `tram_id` int NOT NULL,
  PRIMARY KEY (`employee_id`,`tram_id`),
  KEY `motorman_tram_fk_tram` (`tram_id`),
  CONSTRAINT `motorman_tram_fk_motorman` FOREIGN KEY (`employee_id`) REFERENCES `motorman` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `motorman_tram_fk_tram` FOREIGN KEY (`tram_id`) REFERENCES `tram` (`tram_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motorman_tram`
--

LOCK TABLES `motorman_tram` WRITE;
/*!40000 ALTER TABLE `motorman_tram` DISABLE KEYS */;
/*!40000 ALTER TABLE `motorman_tram` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `passenger_id` int NOT NULL AUTO_INCREMENT,
  `passenger_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `passenger_email` varchar(45) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `passenger_dob` date DEFAULT NULL,
  `passenger_sex` enum('M','F') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `passenger_address` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `cashback` int DEFAULT '0',
  PRIMARY KEY (`passenger_id`),
  UNIQUE KEY `passenger_email_UNIQUE` (`passenger_email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
INSERT INTO `passenger` VALUES (1,'emma','emma@gmail.com','1998-05-13','F','35 Park St Boston',129),(2,'amelia','amelia@gmail.com','1988-05-21','F','2 moon Street',3),(3,'Steve','steve@gmail.com','1977-07-26','M','1 smith Street',3),(4,'Gabriel','gabriel@gmail.com','1986-03-25','F','5 Pond Street',3),(5,'Sophia','sophia@gmail.com','1991-06-17','F','1 charles Street',2),(6,'Scarlett','scarlett@gmail.com','1992-04-26','F','2 Mass Street',2),(7,'Lucas','lucas@gmail.com','1996-05-16','M','1 carson Street',1),(8,'Liam','liam@gmail.com','1995-07-18','M','2 Carson Street',1),(9,'Grace','grace@gmail.com','1989-05-16','F','23 charles Street',1),(10,'Emily','emily@gmail.com','1997-06-27','F','1 shawmut ave',1),(11,'Olivia','olivia@gmail.com','1999-03-10','F','1 huntington ave',1),(12,'Stevie','stevie@gmail.com','1982-08-13','F','11 smith Street',0),(13,'Anvesh','anvessh.12@gmail.com','1999-10-19','M','45 Yok St, Cambridge, MA',0);
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `route_id` int NOT NULL AUTO_INCREMENT,
  `route_length` int DEFAULT NULL,
  `line_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`route_id`),
  KEY `line_fk_route` (`line_name`),
  CONSTRAINT `line_fk_route` FOREIGN KEY (`line_name`) REFERENCES `line` (`line_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (1,100,'Green Line B'),(2,200,'Green Line C'),(3,100,'Green Line D'),(4,400,'Green Line E'),(5,200,'Red Line'),(6,100,'Red Line M'),(7,100,'Blue Line'),(8,100,'Orange Line');
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route_station`
--

DROP TABLE IF EXISTS `route_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route_station` (
  `route_id` int NOT NULL,
  `station_id` int NOT NULL,
  `stop_no` int NOT NULL,
  PRIMARY KEY (`route_id`,`station_id`),
  KEY `rs_fk_station` (`station_id`),
  CONSTRAINT `rs_fk_route` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rs_fk_station` FOREIGN KEY (`station_id`) REFERENCES `station` (`station_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route_station`
--

LOCK TABLES `route_station` WRITE;
/*!40000 ALTER TABLE `route_station` DISABLE KEYS */;
INSERT INTO `route_station` VALUES (1,2,4),(1,4,5),(1,10,1),(1,17,3),(1,18,2),(1,20,6),(3,2,4),(3,4,5),(3,12,1),(3,17,3),(3,19,2),(3,20,6),(5,1,3),(5,2,4),(5,7,2),(5,9,1),(5,14,5),(5,21,6),(8,1,3),(8,3,4),(8,5,2),(8,6,1),(8,16,5);
/*!40000 ALTER TABLE `route_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `station_id` int NOT NULL AUTO_INCREMENT,
  `station_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `station_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `station_aminities` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `city_code` int DEFAULT NULL,
  PRIMARY KEY (`station_id`),
  UNIQUE KEY `station_name` (`station_name`),
  KEY `city_fk_station` (`city_code`),
  CONSTRAINT `city_fk_station` FOREIGN KEY (`city_code`) REFERENCES `city` (`city_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'Downtown Crossing','1 Down Street','Parking',1),(2,'Park St','2 Park Street','ATM',1),(3,'State','4 Down State','Lounge',1),(4,'Govt Center','3 Center street','Parking',1),(5,'Ruggles','1 Rugg Street','ATM',1),(6,'Stony Brook','4 Brook Ave','Lounge',1),(7,'JFK','2 Umass Ave','Parking',1),(8,'Shawmut','3 Pond Ave','Parking',1),(9,'Wollaston','3 Wood Street','Lounge',1),(10,'South St','4 South street','Lounge',1),(11,'Kent St','2 king street','Parking',1),(12,'Newton Centre','22 center street','Parking',1),(13,'Symphony','2 huntington ave','Parking',1),(14,'Harvard','3 harvard sq','Parking',1),(15,'Wood Island','34 wood ave','Lounge',1),(16,'Assembly','21 assembly ave','ATM',1),(17,'Copley','27 Copley St','ATM, Lounge',1),(18,'BU Central','7 Central St','ATM, Lounge',1),(19,'Longwood','2 Long St','ATM',1),(20,'Union Square','28 Union St','ATM',1),(21,'Alewife','30 Alewife Ave','ATM',1);
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `station_id` int NOT NULL,
  `route_id` int NOT NULL,
  `passenger_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `tram_id` int NOT NULL,
  `luggage` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ticket_id`),
  KEY `rs_fk_route_station` (`route_id`,`station_id`),
  KEY `passenger_fk_ticket` (`passenger_id`),
  KEY `administrative_staff_fk_ticket` (`employee_id`),
  KEY `tram_fk_ticket` (`tram_id`),
  CONSTRAINT `administrative_staff_fk_ticket` FOREIGN KEY (`employee_id`) REFERENCES `administrative_staff` (`employee_id`),
  CONSTRAINT `passenger_fk_ticket` FOREIGN KEY (`passenger_id`) REFERENCES `passenger` (`passenger_id`),
  CONSTRAINT `rs_fk_route_station` FOREIGN KEY (`route_id`, `station_id`) REFERENCES `route_station` (`route_id`, `station_id`),
  CONSTRAINT `tram_fk_ticket` FOREIGN KEY (`tram_id`) REFERENCES `tram` (`tram_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (19,'2022-12-08 22:30:24',10,1,1,1,1,1),(20,'2022-12-08 22:30:25',10,1,1,1,1,1),(21,'2022-12-08 22:30:26',10,1,1,1,1,1),(22,'2022-12-08 22:30:27',10,1,1,1,1,1),(23,'2022-12-08 22:30:27',10,1,1,1,1,1),(24,'2022-12-08 22:30:28',10,1,1,1,1,1),(25,'2022-12-08 22:30:28',10,1,1,1,1,1),(26,'2022-12-08 22:30:30',10,1,1,1,1,1),(27,'2022-12-08 22:30:31',10,1,1,1,1,1),(28,'2022-12-08 22:30:31',10,1,1,1,1,1),(29,'2022-12-08 22:30:34',10,1,1,1,1,1),(30,'2022-12-08 22:30:35',10,1,1,1,1,1),(31,'2022-12-08 22:30:35',10,1,1,1,1,1),(32,'2022-12-08 22:30:36',10,1,1,1,1,1),(36,'2022-12-08 22:44:41',10,1,1,1,1,0),(37,'2022-12-08 22:47:00',10,1,1,1,1,0),(38,'2022-12-08 22:47:08',10,1,1,1,1,1),(39,'2022-12-08 22:49:13',10,1,1,1,1,0),(40,'2022-12-08 22:50:56',10,1,1,1,1,0),(41,'2022-12-08 22:51:29',10,1,1,1,1,1),(42,'2022-12-08 22:52:15',10,1,1,1,1,1),(43,'2022-12-08 22:52:55',10,1,1,1,1,1),(44,'2022-12-09 21:10:02',2,5,1,1,5,1),(45,'2022-12-09 22:16:55',2,5,1,1,5,1),(46,'2022-12-09 22:42:37',1,5,1,1,5,1),(47,'2022-12-09 22:55:41',10,1,2,1,1,0),(48,'2022-12-09 22:55:41',10,1,3,1,1,0),(49,'2022-12-09 22:55:41',10,1,4,1,1,0),(50,'2022-12-09 22:55:41',10,1,5,1,1,0),(51,'2022-12-09 22:55:41',10,1,6,1,1,0),(52,'2022-12-09 22:55:47',12,3,1,2,2,0),(53,'2022-12-09 22:55:47',12,3,7,2,2,0),(54,'2022-12-09 22:55:47',12,3,8,2,2,0),(55,'2022-12-09 22:55:47',12,3,9,2,2,0),(56,'2022-12-09 22:55:47',12,3,10,2,2,0),(57,'2022-12-09 22:55:47',12,3,11,2,2,0),(58,'2022-12-09 22:55:47',12,3,2,2,2,0),(59,'2022-12-09 22:55:47',12,3,3,2,2,0),(60,'2022-12-09 22:55:47',12,3,4,2,2,0),(61,'2022-12-09 22:55:52',19,3,1,3,2,0),(62,'2022-12-09 22:55:52',19,3,2,3,2,0),(63,'2022-12-09 22:55:52',19,3,3,3,2,0),(64,'2022-12-09 22:55:52',19,3,4,3,2,0),(65,'2022-12-09 22:55:52',19,3,5,3,2,0),(66,'2022-12-09 22:55:52',19,3,6,3,2,0);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `cashback_trigger` AFTER INSERT ON `ticket` FOR EACH ROW BEGIN
	UPDATE passenger
           SET cashback = cashback + 1
           WHERE passenger_id = NEW.passenger_id;
       -- DECLARE id_exists Boolean;
--        SELECT 1
--        INTO @id_exists
--        FROM ticket
--        WHERE ticket.passenger_id = NEW.passenger_id;

--        IF @id_exists = 1
--        THEN
--            UPDATE passenger
--            SET cashback = cashback + '0.1'
--            WHERE passenger_id = NEW.passenger_id;
--         END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tram`
--

DROP TABLE IF EXISTS `tram`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tram` (
  `tram_id` int NOT NULL,
  `tram_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `days` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `timing` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `route_id` int NOT NULL,
  `reverse` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`tram_id`),
  KEY `route_fk_tram` (`route_id`),
  CONSTRAINT `route_fk_tram` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tram`
--

LOCK TABLES `tram` WRITE;
/*!40000 ALTER TABLE `tram` DISABLE KEYS */;
INSERT INTO `tram` VALUES (1,'South St','Mon/Tue/Wed','9am-1am',1,1),(2,'Newton Centre','Mon/Tue/Wed','9am-1am',3,1),(3,'Union Square','Thu/Fri/Sat','9am-10pm',1,0),(4,'Union Square','Thu/Fri/Sat','9am-10pm',3,0),(5,'Wollaston','Mon/Tue/Wed','9am-1am',5,1),(6,'Alewife','Mon/Tue/Wed','9am-1am',5,0),(7,'Stony Brook','Mon/Tue/Wed','9am-6pm',8,1),(8,'Assembly','Mon/Tue/Wed','9am-6pm',8,0);
/*!40000 ALTER TABLE `tram` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'GaddamMSivakumarN'
--
/*!50003 DROP FUNCTION IF EXISTS `createTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `createTicket`(
	station_id int, route_id int, passenger_id int, 
    employee_id int, tram_id int, luggage Boolean
) RETURNS int
    READS SQL DATA
    DETERMINISTIC
begin
	declare date_time DateTime;
    declare insertId int;
    
    IF station_id IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'Fatal cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    IF route_id IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'Attack date cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    IF passenger_id IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'Town cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    IF employee_id IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'State cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    IF tram_id IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'State cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    IF luggage IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'State cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    set date_time = Now();
    set insertId = (select ticket_id from ticket order by ticket_id desc limit 1);
    insert into ticket values (insertId + 1, date_time, station_id, route_id, passenger_id, employee_id, tram_id, luggage);
    return insertId + 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `tramcargoweight` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `tramcargoweight`(tr_id INT,dt_time varchar(30)) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE Total_weight INT;
    SELECT SUM(l.luggage_weight) INTO Total_weight
    FROM ticket ti
    INNER JOIN luggage l
    ON ti.ticket_id=l.ticket_id
    WHERE Date(ti.date_time) = Date(dt_time) AND ti.tram_id=tr_id;
    RETURN(Total_weight);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_passenger_tickets_with_luggage_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_passenger_tickets_with_luggage_data`(in passenger_id int)
BEGIN
	IF passenger_id IS NULL THEN
        SIGNAL SQLSTATE '23000' 
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
	END IF;
    
	select t.*, l.* from ticket as t left outer join luggage as l on t.ticket_id = l.ticket_id;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_route_data_for_route` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_route_data_for_route`(in route_id int)
begin
	if route_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Tram id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    select * from station as s inner join route_station as rs on s.station_id = rs.station_id where rs.route_id = route_id order by rs.stop_no;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_route_stations_for_tram` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_route_stations_for_tram`(in tram_id int)
begin
    
	if tram_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Tram id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
     select s.*, rs.route_id, rs.stop_no from station as s inner join route_station as rs on s.station_id = rs.station_id 
     inner join tram as t on t.route_id = rs.route_id where t.tram_id = tram_id order by rs.stop_no;
     
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_stations_for_given_station` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_stations_for_given_station`(in station_id_p int)
begin
	if station_id_p is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Station id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    select * from station where station_id in ( 
		select station_id from route_station where route_id in (select route_id from route_station where station_id = station_id_p) order by route_id, stop_no desc
    ) and station_id != station_id_p;
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_stations_in_route` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_stations_in_route`(in route_id int)
begin
	if route_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    select * from route_station as rs inner join station as s on rs.station_id = s.station_id where rs.route_id = route_id order by stop_no asc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_trams_with_cargo_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_trams_with_cargo_data`(in route_id int)
begin
	if route_id is null then
		select t.*, c.* from tram as t inner join cargo_unit as c on t.tram_id = c.tram_id;
	else
		select t.*, c.* from tram as t inner join cargo_unit as c on t.tram_id = c.tram_id where t.route_id = route_id; 
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_tram_for_given_start_end_stations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tram_for_given_start_end_stations`(in start_station_id int, in end_station_id int)
begin
	declare start_route_id int;
    declare end_route_id int;
    
    if start_station_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Start Station id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    if end_station_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'End Station id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    if start_station_id = end_station_id then
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Start and End Station id cannot be the same', MYSQL_ERRNO = 1048 ;
	end if;
    
	select  t.*, rs1.route_id, rs1.stop_no as start_stop, rs2.stop_no as end_stop from (
	(select * from route_station where station_id = start_station_id) as rs1 
    inner join
    (select * from route_station where station_id = end_station_id) as rs2
    on rs1.route_id = rs2.route_id
	) inner join tram as t on rs1.route_id = t.route_id where t.reverse = (rs1.stop_no > rs2.stop_no);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `most_routes_used` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `most_routes_used`()
BEGIN
 
 select r.*, coalesce(m.used_count, 0) as used_count from route as r left outer join (
	select route_id, count(*) as used_count from ticket group by route_id
 ) as m on r.route_id = m.route_id order by used_count desc;
 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `passengerroute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `passengerroute`(IN rt_id INT)
BEGIN
 
 IF rt_id IS NULL THEN
        SIGNAL SQLSTATE '23000' 
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
 END IF;
 
 SELECT p.passenger_name, r.line_name, count(*) as travelled_in_route
 FROM ticket as t 
 INNER JOIN passenger as p on p.passenger_id = t.passenger_id 
 INNER JOIN route as r on r.route_id = t.route_id 
 WHERE t.route_id=rt_id
 GROUP BY p.passenger_id, r.route_id;
 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `passenger_emp_route` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `passenger_emp_route`(IN rt_id INT)
BEGIN
	if rt_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
SELECT passenger_name,employee_name,count(*)
FROM passenger p
INNER JOIN ticket t
ON p.passenger_id=t.passenger_id
INNER JOIN employees e
ON e.employee_id=t.employee_id
GROUP BY t.passenger_id,t.employee_id,rt_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `passenger_travel_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `passenger_travel_history`(in passenger_id int)
BEGIN
	IF passenger_id IS NULL THEN
        SIGNAL SQLSTATE '23000' 
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
	END IF;
    
	select p.*, t.*, tr.*, r.*, s.* from passenger as p inner join ticket as t on p.passenger_id = t.passenger_id 
    inner join tram as tr on tr.tram_id = t.tram_id inner join route as r on r.route_id = t.route_id
    inner join station as s on s.station_id = t.station_id
    where p.passenger_id = passenger_id order by t.ticket_id desc;
 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `routes_for_station` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `routes_for_station`(in station_id_p int)
begin
	if station_id_p is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Station id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    select * from route where route_id in (select route_id from route_station where station_id = station_id_p);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stationbusyday` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `stationbusyday`(IN inpfirstday datetime,IN inplastday datetime,IN inpstationid INT)
BEGIN
 
 IF inpstationid IS NULL THEN
        SIGNAL SQLSTATE '23000' 
        SET MESSAGE_TEXT = 'Station id cannot be null', MYSQL_ERRNO = 1048 ;
 END IF;
 
 if inpfirstday IS NULL OR inplastday IS NULL THEN
 SELECT DATE(date_time) as date, count(*) AS Total_count
 FROM ticket
 WHERE  station_id=inpstationid
 GROUP BY DATE(date_time)
 ORDER BY Total_count DESC
 LIMIT 1;
 ELSE
 SELECT date_time,count(*) AS Total_count
 FROM ticket
 WHERE (date_time BETWEEN inpfirstday AND inplastday) AND station_id=inpstationid
 GROUP BY DATE(date_time)
 ORDER BY Total_count DESC
 LIMIT 1;
 END IF;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tramsforroute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tramsforroute`(IN inprtid INT,IN inpday varchar(20))
BEGIN
 -- DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'SQLException encountered' Message; 
 -- DECLARE EXIT HANDLER FOR SQLSTATE '23000' SELECT 'SQLSTATE 23000' ErrorCode;
 -- DECLARE TableNotFound CONDITION for 1146 ; 
 -- DECLARE EXIT HANDLER FOR TableNotFound SELECT 'Please create table first' Message; 
 IF inprtid IS NULL THEN
        SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
 END IF;
 IF inpday IS NULL THEN
        SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Input day cannot be null', MYSQL_ERRNO = 1048 ;
 END IF;
 
 SELECT *
 FROM tram
  WHERE 
 route_id=1 
 AND
 days LIKE Concat('%$', inpday, '%') ESCAPE '$';
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-09 23:37:01
