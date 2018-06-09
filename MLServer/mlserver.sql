-- MySQL dump 10.16  Distrib 10.1.26-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: MLServer
-- ------------------------------------------------------
-- Server version	10.1.26-MariaDB-0+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `MLServer`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `MLServer` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `MLServer`;

--
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(75) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_user_id_2c513194_fk_auth_user_id` (`user_id`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add permission',3,'add_permission'),(8,'Can change permission',3,'change_permission'),(9,'Can delete permission',3,'delete_permission'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add user',7,'add_user'),(20,'Can change user',7,'change_user'),(21,'Can delete user',7,'delete_user'),(22,'Can add Token',8,'add_token'),(23,'Can change Token',8,'change_token'),(24,'Can delete Token',8,'delete_token'),(25,'Can add social application',9,'add_socialapp'),(26,'Can change social application',9,'change_socialapp'),(27,'Can delete social application',9,'delete_socialapp'),(28,'Can add social account',10,'add_socialaccount'),(29,'Can change social account',10,'change_socialaccount'),(30,'Can delete social account',10,'delete_socialaccount'),(31,'Can add social application token',11,'add_socialtoken'),(32,'Can change social application token',11,'change_socialtoken'),(33,'Can delete social application token',11,'delete_socialtoken'),(34,'Can add account emailaddress',12,'add_accountemailaddress'),(35,'Can change account emailaddress',12,'change_accountemailaddress'),(36,'Can delete account emailaddress',12,'delete_accountemailaddress'),(37,'Can add account_ emailaddress',12,'add_account_emailaddress'),(38,'Can change account_ emailaddress',12,'change_account_emailaddress'),(39,'Can delete account_ emailaddress',12,'delete_account_emailaddress'),(40,'Can add site',13,'add_site'),(41,'Can change site',13,'change_site'),(42,'Can delete site',13,'delete_site'),(43,'Can add lung equation',14,'add_lungequation'),(44,'Can change lung equation',14,'change_lungequation'),(45,'Can delete lung equation',14,'delete_lungequation'),(46,'Can add account',15,'add_account'),(47,'Can change account',15,'change_account'),(48,'Can delete account',15,'delete_account'),(49,'Can add fef',16,'add_fef'),(50,'Can change fef',16,'change_fef'),(51,'Can delete fef',16,'delete_fef'),(52,'Can add fe v1',17,'add_fev1'),(53,'Can change fe v1',17,'change_fev1'),(54,'Can delete fe v1',17,'delete_fev1'),(55,'Can add fvc',18,'add_fvc'),(56,'Can change fvc',18,'change_fvc'),(57,'Can delete fvc',18,'delete_fvc'),(58,'Can add pef',19,'add_pef'),(59,'Can change pef',19,'change_pef'),(60,'Can delete pef',19,'delete_pef');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$UOBXtdXn4UK5$Fbsn0rePdsYDczO2JKdpGz0hoi9KCYukx4gGaHLS+0M=','2018-05-01 01:57:32.893681',1,'hienpham','','','hienpham@hienpham.com',1,1,'2018-04-22 01:49:23.933147'),(2,'pbkdf2_sha256$36000$SCnANmz8On61$jTr3SV/JiXtVmC1z5LCU4OKv+YUFqI1ihiLCAc/vrok=',NULL,0,'john','','Lennon','lennon@thebeatles.com',0,1,'2018-04-22 07:41:33.255314');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authentication_account`
--

DROP TABLE IF EXISTS `authentication_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authentication_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(40) NOT NULL,
  `first_name` varchar(40) NOT NULL,
  `last_name` varchar(40) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authentication_account`
--

LOCK TABLES `authentication_account` WRITE;
/*!40000 ALTER TABLE `authentication_account` DISABLE KEYS */;
INSERT INTO `authentication_account` VALUES (1,'pbkdf2_sha256$36000$LZTOAyoIlxlM$M2Vd3WvnqGevaRZgJpFDbNLZzSJKNZhp2Ojb45ls5yI=','2018-05-21 05:13:59.604394','hien@mail.com','hienpham','','',1,'2018-05-02 02:28:41.668255','2018-05-02 23:40:10.792427',1,1),(3,'pbkdf2_sha256$36000$04KudbqA4DA3$1vsg4z7nDQtGitzQQKeq6tr5k1Ln9SBHJaNTozDwNmY=','2018-05-13 14:52:32.578593','phuc@phuc.com','phuc','','',1,'2018-05-02 04:03:43.941097','2018-05-13 14:51:11.135153',1,0),(6,'pbkdf2_sha256$36000$N9HpKSfoBX3k$bz7HNryPsZBSOzyKsH4q8V/rt9w+KyWRCTrvHVCRMkY=','2018-05-23 05:05:09.168402','hienxinhdep@mail.com','hienxinhdep','','',1,'2018-05-02 05:02:46.759028','2018-05-02 05:02:46.764446',1,1);
/*!40000 ALTER TABLE `authentication_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('40883458115a526059ce03e6b92f101f04d159b1','2018-04-22 02:40:37.206890',1);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-04-25 10:23:48.757474','2','LungEquation object',1,'[{\"added\": {}}]',14,1),(2,'2018-04-25 10:23:58.742045','1','LungEquation object',3,'',14,1),(3,'2018-04-25 10:33:33.393905','3','LungEquation object',1,'[{\"added\": {}}]',14,1),(4,'2018-04-26 03:12:14.217383','3','LungEquation object',2,'[{\"changed\": {\"fields\": [\"params\", \"learning_rate\", \"iterations\", \"error\"]}}]',14,1),(5,'2018-04-26 03:32:51.991199','2','LungEquation object',2,'[{\"changed\": {\"fields\": [\"params\", \"learning_rate\", \"iterations\", \"error\"]}}]',14,1),(6,'2018-04-26 10:56:45.825636','4','LungEquation object',1,'[{\"added\": {}}]',14,1),(7,'2018-04-27 04:15:41.733161','5','LungEquation object',1,'[{\"added\": {}}]',14,1),(10,'2018-05-02 05:03:15.280414','4','binh@mail.com',3,'',15,6),(11,'2018-05-02 05:03:25.856046','1','hien@mail.com',2,'[{\"changed\": {\"fields\": [\"is_active\"]}}]',15,6),(12,'2018-05-02 23:40:10.794170','1','hien@mail.com',2,'[{\"changed\": {\"fields\": [\"is_superuser\"]}}]',15,6),(13,'2018-05-05 04:25:34.397590','1','PEF object',1,'[{\"added\": {}}]',19,1),(14,'2018-05-05 04:25:54.129463','2','PEF object',1,'[{\"added\": {}}]',19,1),(15,'2018-05-05 04:26:05.032796','3','PEF object',1,'[{\"added\": {}}]',19,1),(16,'2018-05-05 04:26:14.475433','4','PEF object',1,'[{\"added\": {}}]',19,1),(17,'2018-05-05 04:26:23.764215','5','PEF object',1,'[{\"added\": {}}]',19,1),(18,'2018-05-05 04:26:33.608505','6','PEF object',1,'[{\"added\": {}}]',19,1),(19,'2018-05-05 04:26:43.019187','7','PEF object',1,'[{\"added\": {}}]',19,1),(20,'2018-05-05 04:26:51.888572','8','PEF object',1,'[{\"added\": {}}]',19,1),(21,'2018-05-05 04:27:01.859324','9','PEF object',1,'[{\"added\": {}}]',19,1),(22,'2018-05-05 04:27:11.737861','10','PEF object',1,'[{\"added\": {}}]',19,1),(23,'2018-05-05 04:27:23.339796','11','PEF object',1,'[{\"added\": {}}]',19,1),(24,'2018-05-05 04:27:32.379485','12','PEF object',1,'[{\"added\": {}}]',19,1),(25,'2018-05-05 04:27:41.202105','13','PEF object',1,'[{\"added\": {}}]',19,1),(26,'2018-05-05 04:27:49.513241','14','PEF object',1,'[{\"added\": {}}]',19,1),(27,'2018-05-05 04:28:00.170291','15','PEF object',1,'[{\"added\": {}}]',19,1),(28,'2018-05-05 04:28:08.465018','16','PEF object',1,'[{\"added\": {}}]',19,1),(29,'2018-05-05 04:28:18.945083','17','PEF object',1,'[{\"added\": {}}]',19,1),(30,'2018-05-05 04:28:27.650741','18','PEF object',1,'[{\"added\": {}}]',19,1),(31,'2018-05-05 04:28:35.425726','19','PEF object',1,'[{\"added\": {}}]',19,1),(32,'2018-05-05 04:28:42.409986','20','PEF object',1,'[{\"added\": {}}]',19,1),(33,'2018-05-05 04:28:50.481440','21','PEF object',1,'[{\"added\": {}}]',19,1),(34,'2018-05-05 04:29:02.912025','22','PEF object',1,'[{\"added\": {}}]',19,1),(35,'2018-05-05 04:29:10.817720','23','PEF object',1,'[{\"added\": {}}]',19,1),(36,'2018-05-05 04:29:20.707789','24','PEF object',1,'[{\"added\": {}}]',19,1),(37,'2018-05-05 04:29:38.433698','25','PEF object',1,'[{\"added\": {}}]',19,1),(38,'2018-05-05 04:31:27.398265','25','PEF object',2,'[{\"changed\": {\"fields\": [\"trained\"]}}]',19,1),(39,'2018-05-05 04:31:36.788549','24','PEF object',2,'[{\"changed\": {\"fields\": [\"trained\"]}}]',19,1),(40,'2018-05-05 04:31:41.219842','23','PEF object',2,'[{\"changed\": {\"fields\": [\"trained\"]}}]',19,1),(41,'2018-05-05 04:31:44.952520','22','PEF object',2,'[{\"changed\": {\"fields\": [\"trained\"]}}]',19,1),(42,'2018-05-05 04:31:50.259825','21','PEF object',2,'[{\"changed\": {\"fields\": [\"trained\"]}}]',19,1),(43,'2018-05-05 04:31:59.425284','20','PEF object',2,'[{\"changed\": {\"fields\": [\"trained\"]}}]',19,1),(44,'2018-05-05 04:32:06.290831','19','PEF object',2,'[{\"changed\": {\"fields\": [\"trained\"]}}]',19,1),(45,'2018-05-05 04:47:17.599281','1','FEF object',1,'[{\"added\": {}}]',16,1),(46,'2018-05-05 04:49:55.402188','2','FEF object',1,'[{\"added\": {}}]',16,1),(47,'2018-05-05 04:50:04.280626','3','FEF object',1,'[{\"added\": {}}]',16,1),(48,'2018-05-05 04:50:11.928098','4','FEF object',1,'[{\"added\": {}}]',16,1),(49,'2018-05-05 04:50:19.147289','5','FEF object',1,'[{\"added\": {}}]',16,1),(50,'2018-05-05 04:50:31.232711','6','FEF object',1,'[{\"added\": {}}]',16,1),(51,'2018-05-05 04:50:39.477418','7','FEF object',1,'[{\"added\": {}}]',16,1),(52,'2018-05-05 04:50:47.001433','8','FEF object',1,'[{\"added\": {}}]',16,1),(53,'2018-05-05 04:50:54.361052','9','FEF object',1,'[{\"added\": {}}]',16,1),(54,'2018-05-05 04:51:02.321919','10','FEF object',1,'[{\"added\": {}}]',16,1),(55,'2018-05-05 04:51:10.709397','11','FEF object',1,'[{\"added\": {}}]',16,1),(56,'2018-05-05 04:51:34.094739','11','FEF object',2,'[]',16,1),(57,'2018-05-05 04:51:42.767457','12','FEF object',1,'[{\"added\": {}}]',16,1),(58,'2018-05-05 04:51:52.094547','13','FEF object',1,'[{\"added\": {}}]',16,1),(59,'2018-05-05 04:52:01.249564','14','FEF object',1,'[{\"added\": {}}]',16,1),(60,'2018-05-05 04:52:10.656308','15','FEF object',1,'[{\"added\": {}}]',16,1),(61,'2018-05-05 04:52:19.060650','16','FEF object',1,'[{\"added\": {}}]',16,1),(62,'2018-05-05 04:52:26.326994','17','FEF object',1,'[{\"added\": {}}]',16,1),(63,'2018-05-05 04:52:36.386071','18','FEF object',1,'[{\"added\": {}}]',16,1),(64,'2018-05-05 04:55:02.174506','19','FEF object',1,'[{\"added\": {}}]',16,1),(65,'2018-05-05 04:55:10.825810','20','FEF object',1,'[{\"added\": {}}]',16,1),(66,'2018-05-05 04:55:19.055879','21','FEF object',1,'[{\"added\": {}}]',16,1),(67,'2018-05-05 04:55:27.579440','22','FEF object',1,'[{\"added\": {}}]',16,1),(68,'2018-05-05 04:55:36.201437','23','FEF object',1,'[{\"added\": {}}]',16,1),(69,'2018-05-05 04:55:44.002893','24','FEF object',1,'[{\"added\": {}}]',16,1),(70,'2018-05-05 04:55:50.849998','25','FEF object',1,'[{\"added\": {}}]',16,1),(71,'2018-05-05 04:55:57.959555','26','FEF object',1,'[{\"added\": {}}]',16,1),(72,'2018-05-05 04:57:12.496411','27','FEF object',1,'[{\"added\": {}}]',16,1),(73,'2018-05-05 04:57:20.537844','28','FEF object',1,'[{\"added\": {}}]',16,1),(74,'2018-05-05 04:57:27.692489','29','FEF object',1,'[{\"added\": {}}]',16,1),(75,'2018-05-05 04:57:34.724682','30','FEF object',1,'[{\"added\": {}}]',16,1),(76,'2018-05-05 04:57:41.569849','31','FEF object',1,'[{\"added\": {}}]',16,1),(77,'2018-05-05 04:57:48.745079','32','FEF object',1,'[{\"added\": {}}]',16,1),(78,'2018-05-05 04:57:56.795641','33','FEF object',1,'[{\"added\": {}}]',16,1),(79,'2018-05-05 04:58:04.097708','34','FEF object',1,'[{\"added\": {}}]',16,1),(80,'2018-05-05 04:58:11.339938','35','FEF object',1,'[{\"added\": {}}]',16,1),(81,'2018-05-05 04:58:17.771391','36','FEF object',1,'[{\"added\": {}}]',16,1),(82,'2018-05-05 04:58:25.249103','37','FEF object',1,'[{\"added\": {}}]',16,1),(83,'2018-05-05 04:58:32.196263','38','FEF object',1,'[{\"added\": {}}]',16,1),(84,'2018-05-05 04:58:51.276274','39','FEF object',1,'[{\"added\": {}}]',16,1),(85,'2018-05-05 04:58:59.923897','40','FEF object',1,'[{\"added\": {}}]',16,1),(86,'2018-05-05 04:59:07.444729','41','FEF object',1,'[{\"added\": {}}]',16,1),(87,'2018-05-05 04:59:15.114845','42','FEF object',1,'[{\"added\": {}}]',16,1),(88,'2018-05-05 04:59:22.363278','43','FEF object',1,'[{\"added\": {}}]',16,1),(89,'2018-05-05 04:59:29.012660','44','FEF object',1,'[{\"added\": {}}]',16,1),(90,'2018-05-05 04:59:36.361580','45','FEF object',1,'[{\"added\": {}}]',16,1),(91,'2018-05-05 04:59:50.910494','46','FEF object',1,'[{\"added\": {}}]',16,1),(92,'2018-05-05 04:59:58.962809','47','FEF object',1,'[{\"added\": {}}]',16,1),(93,'2018-05-05 05:00:06.812502','48','FEF object',1,'[{\"added\": {}}]',16,1),(94,'2018-05-05 05:00:14.842265','49','FEF object',1,'[{\"added\": {}}]',16,1),(95,'2018-05-05 05:00:21.730592','50','FEF object',1,'[{\"added\": {}}]',16,1),(96,'2018-05-05 05:00:29.223494','51','FEF object',1,'[{\"added\": {}}]',16,1),(97,'2018-05-05 05:00:36.879823','52','FEF object',1,'[{\"added\": {}}]',16,1),(98,'2018-05-05 05:00:44.899260','53','FEF object',1,'[{\"added\": {}}]',16,1),(99,'2018-05-05 05:00:54.222542','54','FEF object',1,'[{\"added\": {}}]',16,1),(100,'2018-05-05 05:02:06.946224','55','FEF object',1,'[{\"added\": {}}]',16,1),(101,'2018-05-05 05:02:14.450839','56','FEF object',1,'[{\"added\": {}}]',16,1),(102,'2018-05-05 05:02:22.204097','57','FEF object',1,'[{\"added\": {}}]',16,1),(103,'2018-05-05 05:02:29.609263','58','FEF object',1,'[{\"added\": {}}]',16,1),(104,'2018-05-05 05:02:36.512712','59','FEF object',1,'[{\"added\": {}}]',16,1),(105,'2018-05-05 05:02:45.735736','60','FEF object',1,'[{\"added\": {}}]',16,1),(106,'2018-05-05 05:02:54.002633','61','FEF object',1,'[{\"added\": {}}]',16,1),(107,'2018-05-05 05:03:07.522788','62','FEF object',1,'[{\"added\": {}}]',16,1),(108,'2018-05-05 05:03:15.252099','63','FEF object',1,'[{\"added\": {}}]',16,1),(109,'2018-05-05 05:03:23.674949','64','FEF object',1,'[{\"added\": {}}]',16,1),(110,'2018-05-05 05:03:32.100430','65','FEF object',1,'[{\"added\": {}}]',16,1),(111,'2018-05-05 05:03:40.096648','66','FEF object',1,'[{\"added\": {}}]',16,1),(112,'2018-05-05 05:03:46.955705','67','FEF object',1,'[{\"added\": {}}]',16,1),(113,'2018-05-05 05:03:54.053192','68','FEF object',1,'[{\"added\": {}}]',16,1),(114,'2018-05-05 05:04:00.631724','69','FEF object',1,'[{\"added\": {}}]',16,1),(115,'2018-05-05 05:04:08.055476','70','FEF object',1,'[{\"added\": {}}]',16,1),(116,'2018-05-05 05:04:14.871227','71','FEF object',1,'[{\"added\": {}}]',16,1),(117,'2018-05-05 05:04:22.561281','72','FEF object',1,'[{\"added\": {}}]',16,1),(118,'2018-05-05 05:05:43.562875','2','LungEquation object',2,'[{\"changed\": {\"fields\": [\"params\", \"error\"]}}]',14,1),(119,'2018-05-05 10:28:14.377067','2','LungEquation object',2,'[{\"changed\": {\"fields\": [\"error\"]}}]',14,1),(120,'2018-05-05 10:41:58.463564','4','LungEquation object',2,'[{\"changed\": {\"fields\": [\"params\", \"error\"]}}]',14,1),(121,'2018-05-06 09:02:37.474986','3','LungEquation object',2,'[{\"changed\": {\"fields\": [\"error\"]}}]',14,6),(122,'2018-05-06 09:09:38.030435','4','LungEquation object',2,'[{\"changed\": {\"fields\": [\"params\", \"error\"]}}]',14,6),(123,'2018-05-06 09:15:05.124271','5','LungEquation object',2,'[{\"changed\": {\"fields\": [\"params\", \"iterations\", \"error\"]}}]',14,6),(124,'2018-05-06 09:18:43.472772','1','FVC object',1,'[{\"added\": {}}]',18,6),(125,'2018-05-06 09:18:55.915869','2','FVC object',1,'[{\"added\": {}}]',18,6),(126,'2018-05-06 09:19:10.142098','3','FVC object',1,'[{\"added\": {}}]',18,6),(127,'2018-05-06 09:19:21.979222','4','FVC object',1,'[{\"added\": {}}]',18,6),(128,'2018-05-06 09:19:32.067147','5','FVC object',1,'[{\"added\": {}}]',18,6),(129,'2018-05-06 09:19:41.977608','6','FVC object',1,'[{\"added\": {}}]',18,6),(130,'2018-05-06 09:19:51.883796','7','FVC object',1,'[{\"added\": {}}]',18,6),(131,'2018-05-06 09:20:02.263739','8','FVC object',1,'[{\"added\": {}}]',18,6),(132,'2018-05-06 09:20:13.264395','9','FVC object',1,'[{\"added\": {}}]',18,6),(133,'2018-05-06 09:20:22.162107','10','FVC object',1,'[{\"added\": {}}]',18,6),(134,'2018-05-06 09:20:30.712624','11','FVC object',1,'[{\"added\": {}}]',18,6),(135,'2018-05-06 09:20:38.497231','12','FVC object',1,'[{\"added\": {}}]',18,6),(136,'2018-05-06 09:20:45.998706','13','FVC object',1,'[{\"added\": {}}]',18,6),(137,'2018-05-06 09:20:55.265043','14','FVC object',1,'[{\"added\": {}}]',18,6),(138,'2018-05-06 09:21:03.458254','15','FVC object',1,'[{\"added\": {}}]',18,6),(139,'2018-05-06 09:21:10.680647','16','FVC object',1,'[{\"added\": {}}]',18,6),(140,'2018-05-06 09:21:19.559039','17','FVC object',1,'[{\"added\": {}}]',18,6),(141,'2018-05-06 09:21:26.974039','18','FVC object',1,'[{\"added\": {}}]',18,6),(142,'2018-05-06 09:21:34.596579','19','FVC object',1,'[{\"added\": {}}]',18,6),(143,'2018-05-06 09:21:41.981043','20','FVC object',1,'[{\"added\": {}}]',18,6),(144,'2018-05-06 09:21:58.080036','21','FVC object',1,'[{\"added\": {}}]',18,6),(145,'2018-05-06 09:22:06.488510','22','FVC object',1,'[{\"added\": {}}]',18,6),(146,'2018-05-06 09:22:14.123437','23','FVC object',1,'[{\"added\": {}}]',18,6),(147,'2018-05-06 09:22:21.174026','24','FVC object',1,'[{\"added\": {}}]',18,6),(148,'2018-05-06 09:22:27.965528','25','FVC object',1,'[{\"added\": {}}]',18,6),(149,'2018-05-06 09:22:36.144047','26','FVC object',1,'[{\"added\": {}}]',18,6),(150,'2018-05-06 09:22:43.087950','27','FVC object',1,'[{\"added\": {}}]',18,6),(151,'2018-05-06 09:23:09.357439','1','FEV1 object',1,'[{\"added\": {}}]',17,6),(152,'2018-05-06 09:23:16.814422','2','FEV1 object',1,'[{\"added\": {}}]',17,6),(153,'2018-05-06 09:23:24.120675','3','FEV1 object',1,'[{\"added\": {}}]',17,6),(154,'2018-05-06 09:23:31.380830','4','FEV1 object',1,'[{\"added\": {}}]',17,6),(155,'2018-05-06 09:23:39.003672','5','FEV1 object',1,'[{\"added\": {}}]',17,6),(156,'2018-05-06 09:23:46.401990','6','FEV1 object',1,'[{\"added\": {}}]',17,6),(157,'2018-05-06 09:23:55.310042','7','FEV1 object',1,'[{\"added\": {}}]',17,6),(158,'2018-05-06 09:24:03.646632','8','FEV1 object',1,'[{\"added\": {}}]',17,6),(159,'2018-05-06 09:24:10.352844','9','FEV1 object',1,'[{\"added\": {}}]',17,6),(160,'2018-05-06 09:24:19.309373','10','FEV1 object',1,'[{\"added\": {}}]',17,6),(161,'2018-05-06 09:24:28.822451','11','FEV1 object',1,'[{\"added\": {}}]',17,6),(162,'2018-05-06 09:24:36.253384','12','FEV1 object',1,'[{\"added\": {}}]',17,6),(163,'2018-05-06 09:24:43.488914','13','FEV1 object',1,'[{\"added\": {}}]',17,6),(164,'2018-05-06 09:24:57.049170','14','FEV1 object',1,'[{\"added\": {}}]',17,6),(165,'2018-05-06 09:25:05.556062','15','FEV1 object',1,'[{\"added\": {}}]',17,6),(166,'2018-05-06 09:25:18.749999','16','FEV1 object',1,'[{\"added\": {}}]',17,6),(167,'2018-05-06 09:25:29.098621','17','FEV1 object',1,'[{\"added\": {}}]',17,6),(168,'2018-05-06 09:25:42.509916','18','FEV1 object',1,'[{\"added\": {}}]',17,6),(169,'2018-05-06 09:25:53.502213','19','FEV1 object',1,'[{\"added\": {}}]',17,6),(170,'2018-05-06 09:26:01.174612','20','FEV1 object',1,'[{\"added\": {}}]',17,6),(171,'2018-05-06 09:26:09.380977','21','FEV1 object',1,'[{\"added\": {}}]',17,6),(172,'2018-05-06 09:26:16.916647','22','FEV1 object',1,'[{\"added\": {}}]',17,6),(173,'2018-05-06 09:26:24.234789','23','FEV1 object',1,'[{\"added\": {}}]',17,6),(174,'2018-05-06 09:26:31.829076','24','FEV1 object',1,'[{\"added\": {}}]',17,6),(175,'2018-05-06 09:26:40.640314','25','FEV1 object',1,'[{\"added\": {}}]',17,6),(176,'2018-05-08 05:10:03.240711','2','LungEquation object',2,'[{\"changed\": {\"fields\": [\"ms_error\", \"dataset_size\", \"proportion\", \"test_err\"]}}]',14,6),(177,'2018-05-08 05:15:32.449757','4','LungEquation object',2,'[{\"changed\": {\"fields\": [\"ms_error\", \"dataset_size\", \"proportion\", \"test_err\"]}}]',14,6),(178,'2018-05-08 05:16:42.471481','5','LungEquation object',2,'[{\"changed\": {\"fields\": [\"ms_error\", \"dataset_size\", \"proportion\", \"test_err\"]}}]',14,6),(179,'2018-05-09 09:25:46.507305','3','LungEquation object',2,'[{\"changed\": {\"fields\": [\"ms_error\", \"dataset_size\", \"proportion\", \"test_err\"]}}]',14,6),(180,'2018-05-13 14:51:11.139704','3','phuc@phuc.com',2,'[{\"changed\": {\"fields\": [\"is_active\"]}}]',15,6);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(10,'allauth','socialaccount'),(9,'allauth','socialapp'),(11,'allauth','socialtoken'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(15,'authentication','account'),(8,'authtoken','token'),(5,'contenttypes','contenttype'),(16,'lung_function','fef'),(17,'lung_function','fev1'),(18,'lung_function','fvc'),(14,'lung_function','lungequation'),(19,'lung_function','pef'),(12,'MLServer','account_emailaddress'),(7,'MLServer','user'),(6,'sessions','session'),(13,'sites','site');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-04-21 11:01:37.546180'),(2,'auth','0001_initial','2018-04-21 11:01:40.425648'),(3,'admin','0001_initial','2018-04-21 11:01:40.873265'),(4,'admin','0002_logentry_remove_auto_add','2018-04-21 11:01:40.898186'),(5,'contenttypes','0002_remove_content_type_name','2018-04-21 11:01:41.296595'),(6,'auth','0002_alter_permission_name_max_length','2018-04-21 11:01:41.388220'),(7,'auth','0003_alter_user_email_max_length','2018-04-21 11:01:41.491254'),(8,'auth','0004_alter_user_username_opts','2018-04-21 11:01:41.525960'),(9,'auth','0005_alter_user_last_login_null','2018-04-21 11:01:41.617999'),(10,'auth','0006_require_contenttypes_0002','2018-04-21 11:01:41.631882'),(11,'auth','0007_alter_validators_add_error_messages','2018-04-21 11:01:41.666214'),(12,'auth','0008_alter_user_username_max_length','2018-04-21 11:01:41.902968'),(13,'sessions','0001_initial','2018-04-21 11:01:42.375873'),(14,'MLServer','0001_initial','2018-04-21 11:21:04.145787'),(15,'authtoken','0001_initial','2018-04-21 11:27:23.260237'),(16,'authtoken','0002_auto_20160226_1747','2018-04-21 11:27:23.421432'),(17,'MLServer','0002_user_email','2018-04-22 03:19:53.692917'),(18,'MLServer','0003_auto_20180422_0321','2018-04-22 03:22:00.805030'),(19,'MLServer','0004_accountemailaddress','2018-04-22 03:31:40.615190'),(20,'MLServer','0005_auto_20180422_0333','2018-04-22 03:33:23.751983'),(21,'account','0001_initial','2018-04-22 06:59:15.224912'),(22,'MLServer','0006_auto_20180422_0700','2018-04-22 07:00:09.038209'),(23,'MLServer','0007_remove_user_emailaddress','2018-04-22 07:00:54.924023'),(24,'sites','0001_initial','2018-04-22 07:08:12.262942'),(25,'sites','0002_alter_domain_unique','2018-04-22 07:08:12.303613'),(26,'lung_function','0001_initial','2018-04-24 01:50:08.094431'),(27,'lung_function','0002_auto_20180426_0310','2018-04-26 03:10:37.267552'),(28,'MLServer','0002_delete_user','2018-05-01 01:56:55.191599'),(29,'authentication','0001_initial','2018-05-02 02:27:18.576200'),(30,'authentication','0002_auto_20180502_0426','2018-05-02 04:51:23.013104'),(31,'authentication','0003_auto_20180502_0427','2018-05-02 04:51:26.462964'),(32,'lung_function','0003_fef_fev1_fvc_pef','2018-05-05 04:18:06.104494'),(33,'lung_function','0004_auto_20180508_0459','2018-05-08 04:59:49.888431');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2hn1j561qcx047844l4bejqs9640p0ps','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-05-22 01:15:16.989503'),('2pr6z566hp9jvrlpndl5x1c0rr5jfrka','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-05-22 00:20:58.224513'),('9pnby9a5lf0y2nf9w5cqmccv9fbg0o4o','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-05-22 00:22:07.185027'),('bmnj9i9zk0soi2pva1h2a89jgb8t0xhd','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-05-22 01:14:00.515903'),('chrrupburten06zo7qoeir7mlkpyyvlm','OTAwMjVkOThlMjQyNWJmNDY0ODJjOWZjMGNjMDU4NmFiODk5YWFlYzp7Il9hdXRoX3VzZXJfaGFzaCI6IjVmOTk3ZDZhN2YwMTZmZDExZjE1OTI5ODBlOWRkNGIyZmY1Mjk1Y2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-09 23:22:02.491100'),('fb2ef1u8wij1l561a6lfww6x3iefsmt5','OTAwMjVkOThlMjQyNWJmNDY0ODJjOWZjMGNjMDU4NmFiODk5YWFlYzp7Il9hdXRoX3VzZXJfaGFzaCI6IjVmOTk3ZDZhN2YwMTZmZDExZjE1OTI5ODBlOWRkNGIyZmY1Mjk1Y2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-09 09:25:28.964792'),('fot9r8vd21or5bk7ed7yn8scqk48j1x0','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-05-22 00:21:23.913990'),('iqrzd285vcquo2zcmep0q9qnwjgzkyxw','OWUzZGZhN2FhYmE2NDU4YmNhOGUxZjM4ODQ4ZGExODMxNTA3YThkZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA3ZGQwODdkZjcwMTcyMzgyNWY2MjIzMDcyZjg0OGViZGRkZGNjYmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-17 00:47:57.549546'),('k3ysdo92e379vhav29yv8g67ligeu5nh','OTAwMjVkOThlMjQyNWJmNDY0ODJjOWZjMGNjMDU4NmFiODk5YWFlYzp7Il9hdXRoX3VzZXJfaGFzaCI6IjVmOTk3ZDZhN2YwMTZmZDExZjE1OTI5ODBlOWRkNGIyZmY1Mjk1Y2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-06 06:45:22.778762'),('l85aal6lydnr776pak31r5zlmp5tslml','OWUzZGZhN2FhYmE2NDU4YmNhOGUxZjM4ODQ4ZGExODMxNTA3YThkZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA3ZGQwODdkZjcwMTcyMzgyNWY2MjIzMDcyZjg0OGViZGRkZGNjYmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-23 07:58:33.278624'),('lwwqj1w4ggyd54rqbdcyjdp6o0e7fnoh','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-05-21 00:14:29.816078'),('mrsdytbs9n2dp2yi67fmoqqc58vjggx1','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-05-21 00:02:43.869057'),('o978b3i1lqqvg4inm96qpi3q44ahd1cb','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-05-22 00:43:33.769156'),('pmfuhauhw8xy40xp7nobmnwhiea0qwt3','OWUzZGZhN2FhYmE2NDU4YmNhOGUxZjM4ODQ4ZGExODMxNTA3YThkZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA3ZGQwODdkZjcwMTcyMzgyNWY2MjIzMDcyZjg0OGViZGRkZGNjYmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-24 00:26:51.644084'),('r1njc865pm63lejkqut3f76cf6cdexck','OTAwMjVkOThlMjQyNWJmNDY0ODJjOWZjMGNjMDU4NmFiODk5YWFlYzp7Il9hdXRoX3VzZXJfaGFzaCI6IjVmOTk3ZDZhN2YwMTZmZDExZjE1OTI5ODBlOWRkNGIyZmY1Mjk1Y2IiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-15 01:57:32.902934'),('r323b8tqi0pyomeuw552q2xhwnwzfsg3','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-06-06 05:05:09.177133'),('ugcao13g179ozstvkvjsm2bph03tse3b','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-05-22 01:15:45.172199'),('vdlf2ay7nmdbjjb7dnwzkicszovokolh','OWUzZGZhN2FhYmE2NDU4YmNhOGUxZjM4ODQ4ZGExODMxNTA3YThkZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA3ZGQwODdkZjcwMTcyMzgyNWY2MjIzMDcyZjg0OGViZGRkZGNjYmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-06-04 05:13:59.618823'),('vhhr4o38ige2xpv7trz4rb13wupefj87','MDYxMmI4YzA5NzljMmFjNmZkMGRjNDhiNzFhMmIzZDMzZGE0OGUxODp7Il9hdXRoX3VzZXJfaGFzaCI6IjVmOTk3ZDZhN2YwMTZmZDExZjE1OTI5ODBlOWRkNGIyZmY1Mjk1Y2IiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2018-05-06 07:18:30.750661'),('vxs75fg9t5rx6yf9xk3kas5u1n91vzn9','OWUzZGZhN2FhYmE2NDU4YmNhOGUxZjM4ODQ4ZGExODMxNTA3YThkZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA3ZGQwODdkZjcwMTcyMzgyNWY2MjIzMDcyZjg0OGViZGRkZGNjYmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-23 06:52:21.951817'),('wye4dc33el8d68o41sbnwfjpl89macww','OWUzZGZhN2FhYmE2NDU4YmNhOGUxZjM4ODQ4ZGExODMxNTA3YThkZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA3ZGQwODdkZjcwMTcyMzgyNWY2MjIzMDcyZjg0OGViZGRkZGNjYmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-17 13:24:21.524781'),('xvj27zpw8c3w4vx4xay7rqebfps19k0e','ZDBjMDI1MGNkNTVkNDJmNTY3MjNkZjVkYjcwZDJmMmVmNmFlZDZiNDp7Il9hdXRoX3VzZXJfaGFzaCI6IjczOGRhYmM5OWQwMTVkMjdmZDcwNDIxYjQzMDAwZDgzNmFmYmVmMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=','2018-05-22 01:47:47.992515'),('zhsabths7ps1yrmny2aaw7rqfwaicun2','OWUzZGZhN2FhYmE2NDU4YmNhOGUxZjM4ODQ4ZGExODMxNTA3YThkZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA3ZGQwODdkZjcwMTcyMzgyNWY2MjIzMDcyZjg0OGViZGRkZGNjYmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-17 00:57:58.084447'),('zhzw0ecf8wrzujllzh0kf9f20rwcxajv','OWUzZGZhN2FhYmE2NDU4YmNhOGUxZjM4ODQ4ZGExODMxNTA3YThkZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjA3ZGQwODdkZjcwMTcyMzgyNWY2MjIzMDcyZjg0OGViZGRkZGNjYmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2018-05-16 08:19:32.951961');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lung_function_fef`
--

DROP TABLE IF EXISTS `lung_function_fef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lung_function_fef` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `input_value` double NOT NULL,
  `output_value` double NOT NULL,
  `trained` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lung_function_fef`
--

LOCK TABLES `lung_function_fef` WRITE;
/*!40000 ALTER TABLE `lung_function_fef` DISABLE KEYS */;
INSERT INTO `lung_function_fef` VALUES (1,59.3583981657,8.53,1),(2,57.8948298863,8.54,1),(3,58.7836319042,11.5,1),(4,57.3013242444,8.36,1),(5,52.7748907954,6.77,1),(6,55.5426344867,7.49,1),(7,57.9136764819,8.41,1),(8,56.6571777033,7.53,1),(9,50.0291010477,5.36,1),(10,56.335232347,7.45,1),(11,56.5359501831,7.69,1),(12,60.4274917731,9.23,1),(13,58.2597200684,8.52,1),(14,53.7259859095,6.92,1),(15,56.9250483077,8.5,1),(16,57.441377832,7.7,1),(17,51.4080305182,6.4,1),(18,58.4058718458,8.94,1),(19,56.2546807938,7.56,1),(20,56.4203846661,7.9,1),(21,54.6865596685,8.19,1),(22,56.6512027603,8.19,1),(23,50.0353836469,6.56,1),(24,53.8683064718,6.25,1),(25,56.814997866,8.01,1),(26,55.9226670024,6.53,1),(27,49.046883656,4.15,1),(28,56.2640086542,7.42,1),(29,54.5405347119,7.59,1),(30,59.4917991282,8.9,1),(31,56.6557352117,5.54,1),(32,50.0916363855,6.68,1),(33,54.2699506594,8.5,1),(34,56.6300791856,7.7,1),(35,44.9302866977,6.38,1),(36,57.8237213923,7.77,1),(37,45.6770780481,4.15,1),(38,51.6113730544,5.6,1),(39,43.3602488886,4.86,1),(40,49.86159204,6.31,1),(41,45.0134772783,4.72,1),(42,46.9930546381,4.2,1),(43,53.5828933628,6.74,1),(44,49.2293581015,5.32,1),(45,39.7707243555,2.89,1),(46,42.1264180358,5.27,1),(47,44.4557746862,5.14,1),(48,53.3887582105,5.84,1),(49,53.3976936911,3.19,1),(50,39.2338813339,3.77,1),(51,43.399135068,6.85,1),(52,52.0290169238,5.77,1),(53,51.0675757512,5.54,1),(54,51.0204108796,4.4,1),(55,37.7349825362,1.81,1),(56,42.0970267052,4.07,1),(57,39.4499562269,2.32,1),(58,34.6019276591,3.4,1),(59,42.215091488,2.29,1),(60,35.488897003,2.23,1),(61,38.1956179199,3.85,1),(62,36.5137487033,2.78,1),(63,30.3065574664,1.78,1),(64,28.3680357027,2.41,1),(65,33.2689114929,2.55,1),(66,36.0161486722,2.61,1),(67,38.6774340797,1.57,1),(68,35.7794127729,1.85,1),(69,35.0806108594,2.46,1),(70,31.3068974396,2.49,1),(71,32.870731051,3.49,1),(72,44.9169503594,2.52,1);
/*!40000 ALTER TABLE `lung_function_fef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lung_function_fev1`
--

DROP TABLE IF EXISTS `lung_function_fev1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lung_function_fev1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `input_value` double NOT NULL,
  `output_value` double NOT NULL,
  `trained` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lung_function_fev1`
--

LOCK TABLES `lung_function_fev1` WRITE;
/*!40000 ALTER TABLE `lung_function_fev1` DISABLE KEYS */;
INSERT INTO `lung_function_fev1` VALUES (1,4.42087031197,3.99,1),(2,4.00648423407,3.65,1),(3,6.04172905572,3.9,1),(4,3.83611592409,4.04,1),(5,4.02396632961,3.1,1),(6,3.37310527601,3.44,1),(7,3.36927149556,3.64,1),(8,4.39914510303,3.75,1),(9,2.84339279973,2.66,1),(10,4.02284494962,3.12,1),(11,3.74747135064,3.3,1),(12,4.88606916293,3.94,1),(13,4.29561487972,3.46,1),(14,4.52065757673,3.42,1),(15,4.69474267063,3.41,1),(16,5.1581290568,3.86,1),(17,2.73249063235,3.47,1),(18,4.80473069451,3.62,1),(19,5.77939167649,3.45,0),(20,3.99124379508,3.34,0),(21,4.72336021732,3.84,0),(22,4.43365336576,3.54,0),(23,3.84279189029,3.96,0),(24,4.42263345474,3.58,0),(25,5.29249086358,4.12,0);
/*!40000 ALTER TABLE `lung_function_fev1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lung_function_fvc`
--

DROP TABLE IF EXISTS `lung_function_fvc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lung_function_fvc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `input_value` double NOT NULL,
  `output_value` double NOT NULL,
  `trained` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lung_function_fvc`
--

LOCK TABLES `lung_function_fvc` WRITE;
/*!40000 ALTER TABLE `lung_function_fvc` DISABLE KEYS */;
INSERT INTO `lung_function_fvc` VALUES (1,4.42087031197,4.82,1),(2,4.00648423407,3.81,1),(3,6.04172905572,4.27,1),(4,3.83611592409,4.14,1),(5,4.02396632961,3.49,1),(6,3.37310527601,3.79,1),(7,3.36927149556,3.64,1),(8,4.39914510303,3.97,1),(9,2.84339279973,3.01,1),(10,4.02284494962,3.32,1),(11,3.74747135064,3.43,1),(12,4.88606916293,4.26,1),(13,4.29561487972,4.33,1),(14,4.52065757673,3.95,1),(15,4.69474267063,3.63,1),(16,5.1581290568,4.19,1),(17,2.73249063235,3.67,1),(18,4.80473069451,3.82,1),(19,5.90473069451,4.71,1),(20,5.4851290568,4.85,1),(21,5.77939167649,4.13,0),(22,3.99124379508,3.83,0),(23,4.72336021732,4.3,0),(24,4.43365336576,4.18,0),(25,3.84279189029,4.12,0),(26,4.42263345474,3.84,0),(27,5.29249086358,4.52,0);
/*!40000 ALTER TABLE `lung_function_fvc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lung_function_lungequation`
--

DROP TABLE IF EXISTS `lung_function_lungequation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lung_function_lungequation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_value` varchar(255) NOT NULL,
  `order` int(11) NOT NULL,
  `params` longtext NOT NULL,
  `ms_error` double DEFAULT NULL,
  `iterations` int(11) DEFAULT NULL,
  `learning_rate` double DEFAULT NULL,
  `dataset_size` int(11) DEFAULT NULL,
  `proportion` double DEFAULT NULL,
  `test_err` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lung_function_lungequation`
--

LOCK TABLES `lung_function_lungequation` WRITE;
/*!40000 ALTER TABLE `lung_function_lungequation` DISABLE KEYS */;
INSERT INTO `lung_function_lungequation` VALUES (2,'pef',2,'(0.0025124734, 4.1233514e-05, 6.7261277e-07)',0.584363672325,10000,0.00000000001,25,0.7,6.7594484601702),(3,'fef',2,'(0.002360452, 4.2340947e-05, 7.6777485e-07)',1.10815556077,10000,0.000000000001,72,0,0),(4,'fvc',2,'(-0.0735514, 1.0682987, 0.80031973)',0.136591451248,20000,0.0001,25,0.7,4.54972103663853),(5,'fev1',2,'(-0.10494825, 1.1611407, 0.58054125)',0.091577660163,20000,0.00001,25,0.7,6.3736196245466);
/*!40000 ALTER TABLE `lung_function_lungequation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lung_function_pef`
--

DROP TABLE IF EXISTS `lung_function_pef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lung_function_pef` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `input_value` double NOT NULL,
  `output_value` double NOT NULL,
  `trained` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lung_function_pef`
--

LOCK TABLES `lung_function_pef` WRITE;
/*!40000 ALTER TABLE `lung_function_pef` DISABLE KEYS */;
INSERT INTO `lung_function_pef` VALUES (1,59.3583981657,8.53,1),(2,57.8948298863,8.54,1),(3,58.7836319042,11.5,1),(4,57.3013242444,8.36,1),(5,52.7748907954,6.77,1),(6,55.5426344867,7.49,1),(7,57.9136764819,8.41,1),(8,56.6571777033,7.53,1),(9,50.0291010477,5.36,1),(10,56.335232347,7.45,1),(11,56.5359501831,7.69,1),(12,60.4274917731,9.23,1),(13,58.2597200684,8.52,1),(14,53.7259859095,6.92,1),(15,56.9250483077,8.5,1),(16,57.441377832,7.7,1),(17,51.4080305182,6.4,1),(18,58.4058718458,8.94,1),(19,58.4514573692,9.08,0),(20,57.8556795998,8.59,0),(21,57.7306926013,9.71,0),(22,55.2446016538,7.31,0),(23,59.6066821759,9.83,0),(24,56.6759238754,7.98,0),(25,60.0444764053,10.16,0);
/*!40000 ALTER TABLE `lung_function_pef` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-09 11:37:22
