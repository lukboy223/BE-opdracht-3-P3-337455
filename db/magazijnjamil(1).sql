-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 10, 2024 at 08:30 PM
-- Server version: 8.0.31
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `magazijnjamil`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `spReadLeverancier`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadLeverancier` ()   BEGIN
        SELECT
       LEV.id as LeverancierId,
       LEV.Naam AS LeverancierNaam,
       ContactPersoon,
       LeverancierNummer,
       Mobiel,
       COUNT(DISTINCT PRO.Naam) AS VerProducten
    FROM Leverancier AS LEV
    LEFT JOIN ProductPerLeverancier AS PROLev
    ON LEV.id = PROLev.LeverancierId
    left join Product as PRO
    on PROLev.ProductId = PRO.Id
    GROUP BY LEV.id, LeverancierNaam
    ORDER BY VerProducten DESC;
END$$

DROP PROCEDURE IF EXISTS `spReadLeverancierById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadLeverancierById` (`GivenLevId` INT UNSIGNED)   BEGIN
    SELECT
       Id,
       Naam AS LeverancierNaam,
       ContactPersoon,
       LeverancierNummer,
       Mobiel
    
    FROM Leverancier
    WHERE Id = GivenLevId;
END$$

DROP PROCEDURE IF EXISTS `spReadMagazijnProduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadMagazijnProduct` ()   BEGIN
SELECT
    Naam
    ,Barcode
    ,VerpakingsInhoudKilogram
    ,AantalAanwezig
    ,Product.Id
FROM Magazijn
INNER JOIN Product
ON Magazijn.ProductId = Product.Id
order by Barcode;


 END$$

DROP PROCEDURE IF EXISTS `spReadProductLeverancierById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadProductLeverancierById` (IN `GivenProductId` INT UNSIGNED)   BEGIN
SELECT
    Product.Naam AS ProductNaam
    ,ProductPerLeverAncier.DatumLevering
    ,ProductPerLeverAncier.Aantal AS LeveringAantal
    ,ProductPerLeverAncier.DatumEerstVolgendeLevering
    ,Leverancier.Naam AS LeverancierNaam
    ,Leverancier.ContactPersoon
    ,Leverancier.LeverancierNummer
    ,Leverancier.Mobiel
FROM ProductPerLeverAncier
INNER JOIN Product ON ProductPerLeverAncier.ProductId = Product.Id
INNER JOIN Leverancier ON ProductPerLeverAncier.LeverancierId = Leverancier.Id
WHERE ProductPerLeverAncier.ProductId = GivenProductId
ORDER BY ProductPerLeverAncier.DatumLevering;


END$$

DROP PROCEDURE IF EXISTS `spReadProductLeverancierByLevId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadProductLeverancierByLevId` (IN `GivenLevId` INT UNSIGNED)   BEGIN
SELECT
     LevPro.ProductId
    ,(magazijn.AantalAanwezig + LevPro.Aantal) as AantalAanwezig
    ,magazijn.VerpakingsInhoudKilogram
    ,Product.Naam                               AS ProductNaam
    ,LevPro.DatumLevering
FROM ProductPerLeverAncier                      AS LevPro
INNER JOIN Product
ON LevPro.ProductId              = Product.Id
INNER JOIN magazijn
ON LevPro.ProductId              = magazijn.ProductId
WHERE LevPro.LeverancierId       = GivenLevId
group by Product.Naam
ORDER BY LevPro.DatumLevering;


END$$

DROP PROCEDURE IF EXISTS `spReadProductLeverancierByProId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadProductLeverancierByProId` (IN `GivenProductId` INT UNSIGNED)   BEGIN
SELECT
    ProductPerLeverAncier.Id as PPLId
    ,Product.Naam AS ProductNaam
    ,ProductPerLeverAncier.isActief
    ,Leverancier.Naam AS LeverancierNaam
    ,Leverancier.ContactPersoon
    ,Leverancier.LeverancierNummer
    ,Leverancier.Mobiel
FROM ProductPerLeverAncier
INNER JOIN Product ON ProductPerLeverAncier.ProductId = Product.Id
INNER JOIN Leverancier ON ProductPerLeverAncier.LeverancierId = Leverancier.Id
WHERE ProductPerLeverAncier.ProductId = GivenProductId
limit 1;


END$$

DROP PROCEDURE IF EXISTS `spReadProductPerAllergeenById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadProductPerAllergeenById` (IN `GivenProductId` INT)   BEGIN
SELECT
    Product.Naam as ProductNaam
    ,Product.Barcode
    ,Allergeen.Naam as AllergeenNaam
    ,Allergeen.Omschrijving
FROM ProductPerAllergeen
INNER JOIN Product
ON ProductPerAllergeen.ProductId = Product.Id
INNER JOIN Allergeen
ON ProductPerAllergeen.AllergeenId = Allergeen.Id
WHERE ProductPerAllergeen.ProductId = GivenProductId
ORDER BY AllergeenNaam;

 END$$

DROP PROCEDURE IF EXISTS `spUpdateLeverancierPerProduct`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateLeverancierPerProduct` (IN `PPLId` INT UNSIGNED, IN `DatumLev` DATE, IN `AantalLev` MEDIUMINT UNSIGNED)   BEGIN

update productperleverancier
SET 
    DatumLevering = DatumLev
    ,Aantal = AantalLev

WHERE Id = PPLId;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `allergeen`
--

DROP TABLE IF EXISTS `allergeen`;
CREATE TABLE IF NOT EXISTS `allergeen` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(50) NOT NULL,
  `Omschrijving` varchar(250) NOT NULL,
  `isActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `allergeen`
--

INSERT INTO `allergeen` (`Id`, `Naam`, `Omschrijving`, `isActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Gluten', 'Dit product bevat gluten', b'1', NULL, '2024-12-10 21:18:44.027678', '2024-12-10 21:18:44.027678'),
(2, 'Gelatine', 'Dit product bevat gelatine ', b'1', NULL, '2024-12-10 21:18:44.027678', '2024-12-10 21:18:44.027678'),
(3, 'AZO-Kleurstof', 'Dit product bevat AZO-kleurstoffen ', b'1', NULL, '2024-12-10 21:18:44.027678', '2024-12-10 21:18:44.027678'),
(4, 'Lactose', 'Dit product bevat lactose ', b'1', NULL, '2024-12-10 21:18:44.027678', '2024-12-10 21:18:44.027678'),
(5, 'Soja', 'Dit product bevat soja ', b'1', NULL, '2024-12-10 21:18:44.027678', '2024-12-10 21:18:44.027678');

-- --------------------------------------------------------

--
-- Table structure for table `leverancier`
--

DROP TABLE IF EXISTS `leverancier`;
CREATE TABLE IF NOT EXISTS `leverancier` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(50) NOT NULL,
  `ContactPersoon` varchar(120) NOT NULL,
  `LeverancierNummer` varchar(50) NOT NULL,
  `Mobiel` varchar(15) NOT NULL,
  `isActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  UNIQUE KEY `LeverancierNummer` (`LeverancierNummer`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `leverancier`
--

INSERT INTO `leverancier` (`Id`, `Naam`, `ContactPersoon`, `LeverancierNummer`, `Mobiel`, `isActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Venco', 'Bert van Linge', 'L1029384719', '06-28493827', b'1', NULL, '2024-12-10 21:18:44.050786', '2024-12-10 21:18:44.050786'),
(2, 'Astra Sweets', 'Jasper del Monte', 'L1029284315', '06-39398734 ', b'1', NULL, '2024-12-10 21:18:44.050786', '2024-12-10 21:18:44.050786'),
(3, 'Haribo', 'Sven Stalman', 'L1029324748', '06-24383291', b'1', NULL, '2024-12-10 21:18:44.050786', '2024-12-10 21:18:44.050786'),
(4, 'Basset', 'Joyce Stelterberg', 'L1023845773', '06-48293823', b'1', NULL, '2024-12-10 21:18:44.050786', '2024-12-10 21:18:44.050786'),
(5, 'De Bron', 'Remco Veenstra', 'L1023857736', '06-34291234', b'1', NULL, '2024-12-10 21:18:44.050786', '2024-12-10 21:18:44.050786'),
(6, 'Quality Street', 'Jogan Nooij', 'L1029234586', '06-23458456', b'1', NULL, '2024-12-10 21:18:44.050786', '2024-12-10 21:18:44.050786');

-- --------------------------------------------------------

--
-- Table structure for table `magazijn`
--

DROP TABLE IF EXISTS `magazijn`;
CREATE TABLE IF NOT EXISTS `magazijn` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` int UNSIGNED NOT NULL,
  `VerpakingsInhoudKilogram` decimal(6,2) NOT NULL,
  `AantalAanwezig` mediumint UNSIGNED DEFAULT '0',
  `isActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `ProductId` (`ProductId`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `magazijn`
--

INSERT INTO `magazijn` (`Id`, `ProductId`, `VerpakingsInhoudKilogram`, `AantalAanwezig`, `isActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, '5.00', 453, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(2, 2, '2.50', 400, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(3, 3, '5.00', 1, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(4, 4, '1.00', 800, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(5, 5, '3.00', 234, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(6, 6, '2.00', 345, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(7, 7, '1.00', 795, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(8, 8, '10.00', 233, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(9, 9, '2.50', 123, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(10, 10, '3.00', 0, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(11, 11, '2.00', 367, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(12, 12, '1.00', 467, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508'),
(13, 13, '5.00', 20, b'1', NULL, '2024-12-10 21:18:44.008508', '2024-12-10 21:18:44.008508');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(120) NOT NULL,
  `Barcode` varchar(20) NOT NULL,
  `isActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Id`, `Naam`, `Barcode`, `isActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Mintnopjes', '8719587231278', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(2, 'Schoolkrijt', '8719587326713', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(3, 'Honingdrop', '8719587327836', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(4, 'Zure Beren', '8719587321441', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(5, 'Cola Flesjes', '8719587321237', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(6, 'Turtles', '8719587322245', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(7, 'Witte Muizen', '8719587328256', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(8, 'Reuzen Slangen', '8719587325641', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(9, 'Zoute Rijen', '8719587322739', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(10, 'Winegums', '8719587327527', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(11, 'Drop Munten', '8719587322345', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(12, 'Kruis Drop', '8719587322265', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288'),
(13, 'Zoute Ruitjes', '8719587323256', b'1', NULL, '2024-12-10 21:18:43.985288', '2024-12-10 21:18:43.985288');

-- --------------------------------------------------------

--
-- Table structure for table `productperallergeen`
--

DROP TABLE IF EXISTS `productperallergeen`;
CREATE TABLE IF NOT EXISTS `productperallergeen` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` int UNSIGNED NOT NULL,
  `AllergeenId` int UNSIGNED NOT NULL,
  `isActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `ProductId` (`ProductId`),
  KEY `AllergeenId` (`AllergeenId`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productperallergeen`
--

INSERT INTO `productperallergeen` (`Id`, `ProductId`, `AllergeenId`, `isActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 2, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(2, 1, 1, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(3, 1, 3, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(4, 3, 4, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(5, 6, 5, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(6, 9, 2, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(7, 9, 5, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(8, 10, 2, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(9, 12, 4, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(10, 13, 1, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(11, 13, 4, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961'),
(12, 13, 5, b'1', NULL, '2024-12-10 21:18:44.102961', '2024-12-10 21:18:44.102961');

-- --------------------------------------------------------

--
-- Table structure for table `productperleverancier`
--

DROP TABLE IF EXISTS `productperleverancier`;
CREATE TABLE IF NOT EXISTS `productperleverancier` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductId` int UNSIGNED NOT NULL,
  `LeverancierId` int UNSIGNED NOT NULL,
  `DatumLevering` date DEFAULT NULL,
  `Aantal` mediumint UNSIGNED NOT NULL,
  `DatumEerstVolgendeLevering` date DEFAULT NULL,
  `isActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `ProductId` (`ProductId`),
  KEY `LeverancierId` (`LeverancierId`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productperleverancier`
--

INSERT INTO `productperleverancier` (`Id`, `ProductId`, `LeverancierId`, `DatumLevering`, `Aantal`, `DatumEerstVolgendeLevering`, `isActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 1, 1, '2025-12-20', 9949489, '2024-11-16', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(2, 1, 1, '2024-11-18', 21, '2024-11-25', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(3, 2, 1, '2024-11-09', 12, '2024-11-16', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(4, 3, 1, '2024-11-10', 11, '2024-11-17', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(5, 4, 2, '2024-11-14', 16, '2024-11-21', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(6, 4, 2, '2024-11-21', 23, '2024-11-28', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(7, 5, 2, '2024-11-14', 45, '2024-11-21', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(8, 6, 2, '2024-11-14', 30, '2024-11-21', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(9, 7, 3, '2024-11-12', 12, '2024-11-19', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(10, 7, 3, '2024-11-19', 23, '2024-11-26', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(11, 8, 3, '2024-11-10', 12, '2024-11-01', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(12, 9, 3, '2024-11-11', 1, '2024-11-18', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(13, 10, 4, '2024-11-16', 24, '2024-11-30', b'0', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(14, 11, 5, '2024-11-10', 47, '2024-11-17', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(15, 11, 5, '2024-11-19', 60, '2024-11-26', b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(16, 12, 5, '2024-11-11', 45, NULL, b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507'),
(17, 13, 5, '2024-11-12', 23, NULL, b'1', NULL, '2024-12-10 21:18:44.082507', '2024-12-10 21:18:44.082507');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
