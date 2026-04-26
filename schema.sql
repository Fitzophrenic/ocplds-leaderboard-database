-- MySQL dump 10.13  Distrib 9.7.0, for macos15 (arm64)
--
-- Host: localhost    Database: ocplds_database
-- ------------------------------------------------------
-- Server version	9.7.0

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
-- Table structure for table `Leaderboard`
--

DROP TABLE IF EXISTS `Leaderboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Leaderboard` (
  `LeaderboardID` int NOT NULL AUTO_INCREMENT,
  `SectionID` int NOT NULL,
  `WindowID` int NOT NULL,
  `RunID` int NOT NULL,
  `PlayerID` int NOT NULL,
  `PlayerRank` int NOT NULL,
  `BestTime` time NOT NULL,
  PRIMARY KEY (`LeaderboardID`),
  UNIQUE KEY `unique_player_rank` (`WindowID`,`SectionID`,`PlayerID`),
  KEY `SectionID` (`SectionID`),
  KEY `RunID` (`RunID`),
  KEY `PlayerID` (`PlayerID`),
  CONSTRAINT `leaderboard_ibfk_1` FOREIGN KEY (`SectionID`) REFERENCES `Map_Sections` (`SectionID`),
  CONSTRAINT `leaderboard_ibfk_2` FOREIGN KEY (`WindowID`) REFERENCES `Submission_Windows` (`WindowID`),
  CONSTRAINT `leaderboard_ibfk_3` FOREIGN KEY (`RunID`) REFERENCES `Runs` (`RunID`),
  CONSTRAINT `leaderboard_ibfk_4` FOREIGN KEY (`PlayerID`) REFERENCES `Players` (`PlayerID`),
  CONSTRAINT `leaderboard_chk_1` CHECK ((`PlayerRank` between 1 and 3))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Map_Sections`
--

DROP TABLE IF EXISTS `Map_Sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Map_Sections` (
  `SectionID` int NOT NULL AUTO_INCREMENT,
  `MapID` int NOT NULL,
  `SectionName` enum('Main','Bonus','Easy','Medium','Hard') NOT NULL,
  `DifficultyLevel` enum('Easy','Medium','Hard') DEFAULT NULL,
  PRIMARY KEY (`SectionID`),
  KEY `MapID` (`MapID`),
  CONSTRAINT `map_sections_ibfk_1` FOREIGN KEY (`MapID`) REFERENCES `Maps` (`MapID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Maps`
--

DROP TABLE IF EXISTS `Maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Maps` (
  `MapID` int NOT NULL AUTO_INCREMENT,
  `MapName` varchar(100) NOT NULL,
  `MapCode` varchar(20) NOT NULL,
  PRIMARY KEY (`MapID`),
  UNIQUE KEY `MapCode` (`MapCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Players`
--

DROP TABLE IF EXISTS `Players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Players` (
  `PlayerID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `DiscordID` varchar(50) DEFAULT NULL,
  `Platform` varchar(20) NOT NULL,
  PRIMARY KEY (`PlayerID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Runs`
--

DROP TABLE IF EXISTS `Runs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Runs` (
  `RunID` int NOT NULL AUTO_INCREMENT,
  `PlayerID` int NOT NULL,
  `SectionID` int NOT NULL,
  `WindowID` int NOT NULL,
  `CompletionTime` time NOT NULL,
  `ScreenshotURL` varchar(255) DEFAULT NULL,
  `SourcePlatform` varchar(50) NOT NULL,
  `SourceURL` varchar(255) DEFAULT NULL,
  `SubmissionDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `EntryMethod` enum('auto','manual') DEFAULT 'manual',
  `IsVerified` tinyint(1) DEFAULT '0',
  `ImageClear` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`RunID`),
  KEY `PlayerID` (`PlayerID`),
  KEY `SectionID` (`SectionID`),
  KEY `WindowID` (`WindowID`),
  CONSTRAINT `runs_ibfk_1` FOREIGN KEY (`PlayerID`) REFERENCES `Players` (`PlayerID`),
  CONSTRAINT `runs_ibfk_2` FOREIGN KEY (`SectionID`) REFERENCES `Map_Sections` (`SectionID`),
  CONSTRAINT `runs_ibfk_3` FOREIGN KEY (`WindowID`) REFERENCES `Submission_Windows` (`WindowID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Submission_Windows`
--

DROP TABLE IF EXISTS `Submission_Windows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Submission_Windows` (
  `WindowID` int NOT NULL AUTO_INCREMENT,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime NOT NULL,
  `IsSeasonReset` tinyint(1) DEFAULT '0',
  `ResetAppliedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`WindowID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Verifications`
--

DROP TABLE IF EXISTS `Verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Verifications` (
  `VerificationID` int NOT NULL AUTO_INCREMENT,
  `RunID` int NOT NULL,
  `VerifiedBy` varchar(100) NOT NULL,
  `VerifiedDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `RejectionNotes` text,
  `HasNewTimes` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`VerificationID`),
  UNIQUE KEY `RunID` (`RunID`),
  CONSTRAINT `verifications_ibfk_1` FOREIGN KEY (`RunID`) REFERENCES `Runs` (`RunID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-22 22:03:38
