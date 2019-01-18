-- MySQL dump 10.13  Distrib 5.5.40, for Win64 (x86)
--
-- Host: localhost    Database: xsgy
-- ------------------------------------------------------
-- Server version	5.5.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `apartinfo`
--

DROP TABLE IF EXISTS `apartinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apartinfo` (
  `Bno` int(4) NOT NULL,
  `Dno` int(4) NOT NULL,
  `allpeo` int(4) DEFAULT '4',
  `livepeo` int(4) DEFAULT NULL,
  `belongSchool` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Bno`,`Dno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartinfo`
--

LOCK TABLES `apartinfo` WRITE;
/*!40000 ALTER TABLE `apartinfo` DISABLE KEYS */;
INSERT INTO `apartinfo` VALUES (1,101,4,3,'软件'),(1,102,4,0,'软件'),(1,103,4,0,'软件'),(1,104,4,0,'软件'),(1,105,4,0,'软件'),(1,106,4,0,'软件'),(1,107,4,0,'软件'),(1,108,4,0,'软件'),(1,109,4,0,'软件'),(1,110,4,0,'软件'),(1,111,4,0,'软件'),(1,112,4,0,'软件'),(1,113,4,0,'软件'),(1,114,4,0,'软件'),(1,115,4,0,'软件'),(1,116,4,0,'软件'),(1,117,4,0,'软件'),(1,118,4,0,'软件'),(1,201,4,0,'软件'),(1,202,4,0,'软件'),(1,203,4,0,'软件'),(1,204,4,0,'软件'),(1,205,4,0,'软件'),(1,206,4,0,'软件'),(1,207,4,0,'软件'),(1,208,4,0,'软件'),(1,209,4,0,'软件'),(1,210,4,0,'软件'),(1,211,4,0,'软件'),(1,212,4,0,'软件'),(1,213,4,0,'软件'),(1,214,4,0,'软件'),(1,215,4,0,'软件'),(1,216,4,0,'软件'),(1,217,4,0,'软件'),(1,218,4,0,'软件'),(1,301,4,0,'软件'),(1,302,4,0,'软件'),(1,303,4,0,'软件'),(1,304,4,0,'软件'),(1,305,4,0,'软件'),(1,306,4,0,'软件'),(1,307,4,0,'软件'),(1,308,4,0,'软件'),(1,309,4,0,'软件'),(1,310,4,0,'软件'),(1,311,4,0,'软件'),(1,312,4,0,'软件'),(1,313,4,0,'软件'),(1,314,4,0,'软件'),(1,315,4,0,'软件'),(1,316,4,0,'软件'),(1,317,4,0,'软件'),(1,318,4,0,'软件'),(1,401,4,0,'软件'),(1,402,4,0,'软件'),(1,403,4,0,'软件'),(1,404,4,0,'软件'),(1,405,4,0,'软件'),(1,406,4,0,'软件'),(1,407,4,0,'软件'),(1,408,4,0,'软件'),(1,409,4,0,'软件'),(1,410,4,0,'软件'),(1,411,4,0,'软件'),(1,412,4,0,'软件'),(1,413,4,0,'软件'),(1,414,4,0,'软件'),(1,415,4,0,'软件'),(1,416,4,0,'软件'),(1,417,4,0,'软件'),(1,418,4,0,'软件'),(1,501,4,0,'软件'),(1,502,4,0,'软件'),(1,503,4,0,'软件'),(1,504,4,0,'软件'),(1,505,4,0,'软件'),(1,506,4,0,'软件'),(1,507,4,0,'软件'),(1,508,4,0,'软件'),(1,509,4,0,'软件'),(1,510,4,0,'软件'),(1,511,4,0,'软件'),(1,512,4,0,'软件'),(1,513,4,0,'软件'),(1,514,4,0,'软件'),(1,515,4,0,'软件'),(1,516,4,0,'软件'),(1,517,4,0,'软件'),(1,518,4,0,'软件'),(2,101,4,0,'软件'),(2,102,4,0,'软件'),(2,103,4,0,'软件'),(2,104,4,0,'软件'),(2,105,4,0,'软件'),(2,106,4,0,'软件'),(2,107,4,0,'软件'),(2,108,4,0,'软件'),(2,109,4,0,'软件'),(2,110,4,0,'软件'),(2,111,4,0,'软件'),(2,112,4,0,'软件'),(2,113,4,0,'软件'),(2,114,4,0,'软件'),(2,115,4,0,'软件'),(2,116,4,0,'软件'),(2,117,4,0,'软件'),(2,118,4,0,'软件'),(2,201,4,0,'软件'),(2,202,4,0,'软件'),(2,203,4,0,'软件'),(2,204,4,0,'软件'),(2,205,4,0,'软件'),(2,206,4,0,'软件'),(2,207,4,0,'软件'),(2,208,4,0,'软件'),(2,209,4,0,'软件'),(2,210,4,0,'软件'),(2,211,4,0,'软件'),(2,212,4,0,'软件'),(2,213,4,0,'软件'),(2,214,4,0,'软件'),(2,215,4,0,'软件'),(2,216,4,0,'软件'),(2,217,4,0,'软件'),(2,218,4,0,'软件'),(2,301,4,0,'软件'),(2,302,4,0,'软件'),(2,303,4,0,'软件'),(2,304,4,0,'软件'),(2,305,4,0,'软件'),(2,306,4,0,'软件'),(2,307,4,0,'软件'),(2,308,4,0,'软件'),(2,309,4,0,'软件'),(2,310,4,0,'软件'),(2,311,4,0,'软件'),(2,312,4,0,'软件'),(2,313,4,0,'软件'),(2,314,4,0,'软件'),(2,315,4,0,'软件'),(2,316,4,0,'软件'),(2,317,4,0,'软件'),(2,318,4,0,'软件'),(2,401,4,0,'软件'),(2,402,4,0,'软件'),(2,403,4,0,'软件'),(2,404,4,0,'软件'),(2,405,4,0,'软件'),(2,406,4,0,'软件'),(2,407,4,0,'软件'),(2,408,4,0,'软件'),(2,409,4,0,'软件'),(2,410,4,0,'软件'),(2,411,4,0,'软件'),(2,412,4,0,'软件'),(2,413,4,0,'软件'),(2,414,4,0,'软件'),(2,415,4,0,'软件'),(2,416,4,0,'软件'),(2,417,4,0,'软件'),(2,418,4,0,'软件'),(2,501,4,0,'软件'),(2,502,4,0,'软件'),(2,503,4,0,'软件'),(2,504,4,0,'软件'),(2,505,4,0,'软件'),(2,506,4,0,'软件'),(2,507,4,0,'软件'),(2,508,4,0,'软件'),(2,509,4,0,'软件'),(2,510,4,0,'软件'),(2,511,4,0,'软件'),(2,512,4,0,'软件'),(2,513,4,0,'软件'),(2,514,4,0,'软件'),(2,515,4,0,'软件'),(2,516,4,0,'软件'),(2,517,4,0,'软件'),(2,518,4,0,'软件');
/*!40000 ALTER TABLE `apartinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset` (
  `pname` varchar(255) NOT NULL,
  `price` varchar(20) DEFAULT NULL,
  `ptotal` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`pname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset`
--

LOCK TABLES `asset` WRITE;
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
INSERT INTO `asset` VALUES ('凳子','30','178'),('水龙头','20','100'),('窗帘','50','80'),('门锁','10','290'),('风扇','100','20');
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_history`
--

DROP TABLE IF EXISTS `asset_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_history` (
  `date` varchar(255) NOT NULL,
  `bno` int(4) DEFAULT NULL,
  `pname` varchar(255) DEFAULT NULL,
  `pcount` int(8) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_history`
--

LOCK TABLES `asset_history` WRITE;
/*!40000 ALTER TABLE `asset_history` DISABLE KEYS */;
INSERT INTO `asset_history` VALUES ('2019-01-15 09:31:17',1,'凳子',20,'李四'),('2019-01-15 09:59:49',1,'门锁',10,'张三'),('2019-01-15 10:34:36',2,'凳子',2,'王五');
/*!40000 ALTER TABLE `asset_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger1 BEFORE insert

ON asset_history FOR EACH ROW

BEGIN

  update asset set ptotal=ptotal-new.pcount where pname=new.pname;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `in_or_out`
--

DROP TABLE IF EXISTS `in_or_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `in_or_out` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `peoname` varchar(20) DEFAULT NULL,
  `peotype` varchar(255) DEFAULT NULL,
  `goodsname` varchar(255) DEFAULT NULL,
  `in_time` varchar(255) DEFAULT NULL,
  `out_time` varchar(255) DEFAULT NULL,
  `count_time` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_or_out`
--

LOCK TABLES `in_or_out` WRITE;
/*!40000 ALTER TABLE `in_or_out` DISABLE KEYS */;
INSERT INTO `in_or_out` VALUES (8,'张三','学生','','2019-01-15 16:5:55','2019-01-15 16:06:22','0天0时0分27秒'),(9,'李四','维修人员','','2019-01-15 16:6:01','2019-01-15 18:24:39','0天2时18分38秒'),(10,'王五','维修人员','灯泡','2019-01-15 16:6:08','2019-01-15 18:24:40','0天2时18分32秒');
/*!40000 ALTER TABLE `in_or_out` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `no` int(10) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `sex` varchar(4) DEFAULT NULL,
  `college` varchar(20) DEFAULT NULL,
  `major` varchar(20) DEFAULT NULL,
  `class` varchar(20) DEFAULT NULL,
  `Bno` int(4) DEFAULT NULL,
  `Dno` int(4) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (2016006501,'张三','男','软件','软件工程','1801',1,101),(2016006502,'李四','男','软件','软件工程','1801',1,101),(2016006503,'王五','男','软件','软件工程','1801',1,101);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `triggerInsert` BEFORE INSERT ON `student` FOR EACH ROW begin

  declare _dno int;

  declare _bno int;

  declare _livepeo int;

  declare _sex varchar(4);

  declare _allpeo int;

  declare _college varchar(20) character set utf8;



  set _college = new.college;

  set _sex = new.sex;

  select Bno into _bno from apartinfo where belongSchool = _college AND livepeo <4 AND Bno=if(_sex!='男','2','1') limit 1;

  select Dno into _dno from apartinfo where belongSchool = _college AND livepeo <4 AND Bno=if(_sex!='男','2','1') limit 1;

  update apartinfo set livepeo=livepeo+1 where belongSchool = _college AND livepeo <4 AND Bno=if(_sex!='男','2','1') limit 1;

  set new.Bno=_bno;

  set new.Dno=_dno;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `triggerDelete` AFTER DELETE ON `student` FOR EACH ROW begin

  declare _dno int;

  declare _bno int;

  declare _allpeo int;

  declare _college varchar(20) character set utf8;



  set _bno = old.Bno;

  set _dno = old.Dno;

  set _college = old.college;

  update apartinfo set livepeo=livepeo-1 where belongSchool = _college AND livepeo <4 AND Bno=_bno AND Dno = _dno;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','CBCDCPCJHKFHKFKHEDIJEKAOEKIABPMD');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-16 11:20:31
