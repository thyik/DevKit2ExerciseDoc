-- MySQL dump 10.13  Distrib 8.0.19, for osx10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: test
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_type` tinyint DEFAULT '0',
  `customer_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `customer_wallet` double(11,0) NOT NULL,
  `customer_tolerance` double(11,2) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,0,'Simone','knsejnf@gmail.com',8000,0.80),(2,1,'Betsy','sdbsakd@gmail.com',10000,0.60),(3,0,'Matthew','dfnsd@gmail.com',9000,0.80),(4,1,'Lisa','skadsla@gmail.com',8000,0.80),(5,1,'Jimmy','bk34d34@gmail.com',8000,0.50),(6,0,'Ximeng','lmkefnew@gmail.com',6000,0.80),(7,1,'Laoxi','mnljewe@gmail.com',6000,0.50),(8,0,'Xiaoxing','asdsa@gmail.com',6000,0.80),(9,1,'Xiaoqi','mkrntc@gmail.com',6000,0.50),(10,0,'Meiqi','msnrgjfn@gmail.com',8000,0.70),(11,0,'Zixuan','kmfehfe@gmail.com',8000,0.70),(12,0,'Xuanyi','knfiurb4r@gmail.com',6000,0.80),(13,1,'Laoxi','mndff473@gmail.com',6000,0.50),(14,0,'Xiaoxing','lknfo4rh@gmail.com',6000,0.80),(15,1,'Xiaoqi','kewnfo4@gmail.com',6000,0.50),(16,0,'Meiqi','i12ednd@gmail.com',8000,0.70),(17,0,'Zixuan','ionqwh3@gmail.com',8000,0.70),(18,0,'Ximeng','kekln44@gmail.com',6000,0.80),(19,1,'Laoxi','lmsxn21@gmail.com',6000,0.50),(20,0,'Xiaoxing','asd233@gmail.com',6000,0.80),(21,2,'Fujing','xvebr4u@gmail.com',6000,0.50),(22,2,'Yammy','nsdknfl@gmail.com',8000,0.50),(23,2,'Dajuan','mxwdnwvd@gmail.com',8000,0.50),(24,2,'Sunnee','nxsasg@gmail.com',6000,0.50),(25,2,'Chaoyue','lmd3nd@gmail.com',6000,0.50),(26,2,'Shanzhi','2wssbahsd@gmail.com',6000,0.50),(27,2,'Zining','sascsax@gmail.com',6000,0.50),(28,2,'Ziting','vaxayew@gmail.com',8000,0.50),(29,2,'Zixuan','bshsdwd@gmail.com',8000,0.50);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) DEFAULT NULL,
  `product_market_price` double DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'iPhone XS',500),(2,'iPhone XR',600),(3,'Google pixel',500),(4,'Huawei P30 pro',300),(5,'iPhone XS case',10),(6,'iPhone XR case',10),(7,'Google pixel case',15),(8,'Huawei P30 pro case',20);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `seller_id` int NOT NULL AUTO_INCREMENT,
  `seller_name` varchar(255) DEFAULT NULL,
  `seller_wallet` double(11,2) DEFAULT '0.00',
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (1,'Alice',143600.00),(2,'Bob',29350.00),(3,'Carol',113500.00),(4,'Dave',55900.00),(5,'Eve',49950.00),(6,'Farah',10000.00);
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `product_quality` double(11,2) DEFAULT NULL,
  `seller_id` int NOT NULL,
  `stock_quantity` int DEFAULT '0',
  `stock_cost` double DEFAULT '0',
  `stock_price` double DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,1,0.80,1,0,30,500),(2,2,0.70,2,7,20,330),(3,3,0.80,4,50,60,1000),(4,4,0.60,3,38,60,810),(5,5,0.50,5,47,60,1000),(6,6,0.80,1,33,70,900),(7,7,0.70,2,10,60,1000),(8,8,0.80,4,42,60,1000);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `transaction_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `seller_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `transaction_quantity` int DEFAULT '0',
  `transaction_amount` double DEFAULT '0',
  PRIMARY KEY (`transaction_id`),
  KEY `seller_id` (`seller_id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`seller_id`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,'2019-03-08 20:16:00',3,2,2,1,480),(2,'2019-04-11 12:48:57',4,1,3,1,400),(3,'2019-04-11 12:48:57',4,1,7,1,80),(4,'2019-05-16 22:57:07',2,1,5,2,200),(5,'2019-07-17 16:23:27',5,3,4,1,300),(6,'2019-07-18 08:59:37',5,3,8,2,160),(7,'2019-09-01 21:00:52',1,2,6,1,95),(8,'2019-11-30 13:58:52',1,1,6,1,1000),(9,'2019-11-30 13:58:52',3,7,4,2,1950),(10,'2019-11-30 13:58:52',4,10,8,1,1000),(11,'2019-11-30 13:58:52',2,5,7,2,1950),(12,'2019-11-30 13:58:52',1,4,1,3,1500),(13,'2019-11-30 13:58:52',3,2,4,3,2800),(14,'2019-11-30 13:58:52',5,25,5,1,1000),(15,'2019-11-30 13:58:52',1,6,1,3,1500),(16,'2019-11-30 13:58:52',1,11,6,3,2950),(17,'2019-11-30 13:58:52',5,19,5,2,1950),(18,'2019-11-30 13:58:52',2,29,7,1,1000),(19,'2019-11-30 13:58:52',2,13,7,4,3950),(20,'2019-11-30 13:58:52',1,24,6,2,1950),(21,'2019-11-30 13:58:52',1,12,1,3,1500),(22,'2019-11-30 13:58:52',4,21,8,3,2950),(23,'2019-11-30 13:58:52',4,8,8,3,2950),(24,'2019-11-30 13:58:52',1,9,1,5,2450),(25,'2019-11-30 13:58:52',3,15,4,5,4950),(26,'2019-11-30 13:58:52',2,28,7,3,2950),(27,'2019-11-30 13:58:52',3,22,4,2,1950),(28,'2019-11-30 13:58:52',1,20,1,1,500),(29,'2019-11-30 13:58:52',4,23,8,1,1000),(30,'2019-11-30 13:58:52',1,17,1,5,2450),(31,'2019-11-30 13:58:52',1,18,6,1,1000),(32,'2019-11-30 13:58:52',2,16,2,3,900),(33,'2019-11-30 13:58:52',1,3,6,4,3950),(34,'2019-11-30 13:58:52',1,25,6,1,1000),(35,'2019-11-30 13:58:52',1,14,6,5,4950);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-21 17:40:55
