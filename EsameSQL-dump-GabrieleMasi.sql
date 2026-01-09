CREATE DATABASE  IF NOT EXISTS `toys` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `toys`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: toys
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ProductID` int NOT NULL,
  `ProductName` varchar(50) DEFAULT NULL,
  `Category` varchar(50) NOT NULL,
  `Supplier` varchar(100) DEFAULT NULL,
  `Age` varchar(20) DEFAULT NULL,
  `Material` varchar(45) DEFAULT NULL,
  `Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Action Man','doll','ToyWorks Ltd','6-10','Plastic',29.99),(2,'Barbie Rapunzel','doll','Mattel','6-10','Plastic',24.99),(3,'Teddy Bear M','Peluche','Trudy','3-6','Fabric',19.99),(4,'Teddy Bear L','Peluche','Trudy','3-6','Fabric',39.99),(5,'Hotwheels','Vehicles','Hasbro','5-9','Metal',24.99),(6,'Baiblade','Action','Takaratoy','10-14','Metal',29.99),(7,'Ferrari Modeling','Vehicles','Burago','6-10','Metal',49.99),(8,'Skateboard','Action','Billabong','10-14','Mixed',59.99),(9,'Monopoly','Board Games','Monopoly LTD.','10-14','Cardboard',37.99),(10,'Jumanji','Board Games','Hasbro','-4','Cardboard',44.99);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `RegionID` varchar(10) NOT NULL,
  `RegionName` varchar(50) DEFAULT NULL,
  `State` varchar(50) NOT NULL,
  `StateID` int NOT NULL,
  PRIMARY KEY (`StateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES ('SE1','SouthEurope','Greece',30),('WE1','WestEurope','Netherlands',31),('WE1','WestEurope','France',33),('SE1','SouthEurope','Italy',39),('NE1','NorthEurope','Sweden',46),('WE1','WestEurope','Germany',49),('OC1','Oceania','Australia',61),('AP1','AsianPacific','Japan',81),('NA1','NorthAmerica','USA',100),('NA1','NorthAmerica','Canada',101);
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `SalesID` int NOT NULL,
  `Date` date NOT NULL,
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `StoreID` varchar(20) NOT NULL,
  `RegionID` varchar(10) NOT NULL,
  `StateID` int NOT NULL,
  `SalesAmount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`SalesID`),
  KEY `sales-product` (`ProductID`),
  KEY `sales-region_idx` (`StateID`),
  CONSTRAINT `sales-product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`),
  CONSTRAINT `sales-region` FOREIGN KEY (`StateID`) REFERENCES `region` (`StateID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,'2025-02-10',1,'PARIS1','WE1',33,29.99),(2,'2025-03-05',3,'BERL1','WE1',49,19.99),(3,'2025-04-22',5,'ROM1','SE1',39,24.99),(4,'2025-05-14',3,'MIL1','SE1',39,19.99),(5,'2025-06-09',2,'PARIS1','WE1',33,24.99),(6,'2025-07-01',6,'TOK2','AP1',81,29.99),(7,'2025-08-19',7,'TOK2','AP1',81,49.99),(8,'2025-10-03',4,'BERL2','WE1',49,39.99),(9,'2025-12-11',10,'ROM1','SE1',39,44.99),(10,'2026-01-06',8,'TOR1','NA1',101,59.99);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-07 21:22:51
