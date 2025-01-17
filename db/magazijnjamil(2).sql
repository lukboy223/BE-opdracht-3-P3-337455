-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 17, 2025 at 01:13 PM
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
DROP PROCEDURE IF EXISTS `spReadContactById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadContactById` (`GivenLevId` INT UNSIGNED)   BEGIN
    SELECT
       Id,
       Straat,
       Huisnummer,
       Postcode,
       Stad
    
    FROM Contact
    WHERE Id = GivenLevId;
END$$

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
       ContactId,
       Naam AS LeverancierNaam,
       ContactPersoon,
       LeverancierNummer,
       Mobiel
    
    FROM Leverancier
    WHERE Id = GivenLevId;
END$$

DROP PROCEDURE IF EXISTS `spReadLeverancierLimit`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spReadLeverancierLimit` (IN `offset` INT, IN `itemsPerPage` INT)   BEGIN
    SELECT
       LEV.id as LeverancierId,
       ContactId,
       LEV.Naam AS LeverancierNaam,
       ContactPersoon,
       LeverancierNummer,
       Mobiel,
       COUNT(DISTINCT PRO.Naam) AS VerProducten

    FROM Leverancier AS LEV
    LEFT JOIN ProductPerLeverancier AS PROLev
    ON LEV.id = PROLev.LeverancierId
    LEFT JOIN Product AS PRO
    ON PROLev.ProductId = PRO.Id
    GROUP BY LEV.id, LeverancierNaam
    ORDER BY VerProducten DESC
    LIMIT offset, itemsPerPage;
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

DROP PROCEDURE IF EXISTS `spUpdateLeverancier`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spUpdateLeverancier` (IN `GivenLevId` INT UNSIGNED, IN `GivenNaam` VARCHAR(120), IN `GivenContactPersoon` VARCHAR(120), IN `GivenLeverancierNummer` VARCHAR(20), IN `GivenMobiel` VARCHAR(20), IN `GivenContactId` INT UNSIGNED, IN `GivenStraat` VARCHAR(120), IN `GivenHuisnummer` VARCHAR(10), IN `GivenPostcode` VARCHAR(6), IN `GivenStad` VARCHAR(120))   BEGIN

    UPDATE Leverancier
    SET 
        Naam = GivenNaam,
        ContactPersoon = GivenContactPersoon,
        LeverancierNummer = GivenLeverancierNummer,
        Mobiel = GivenMobiel
    WHERE Id = GivenLevId;

    UPDATE Contact
    SET 
        Straat = GivenStraat,
        Huisnummer = GivenHuisnummer,
        Postcode = GivenPostcode,
        Stad = GivenStad
    WHERE Id = GivenContactId;

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
(1, 'Gluten', 'Dit product bevat gluten', b'1', NULL, '2025-01-16 13:19:54.399420', '2025-01-16 13:19:54.399420'),
(2, 'Gelatine', 'Dit product bevat gelatine ', b'1', NULL, '2025-01-16 13:19:54.399420', '2025-01-16 13:19:54.399420'),
(3, 'AZO-Kleurstof', 'Dit product bevat AZO-kleurstoffen ', b'1', NULL, '2025-01-16 13:19:54.399420', '2025-01-16 13:19:54.399420'),
(4, 'Lactose', 'Dit product bevat lactose ', b'1', NULL, '2025-01-16 13:19:54.399420', '2025-01-16 13:19:54.399420'),
(5, 'Soja', 'Dit product bevat soja ', b'1', NULL, '2025-01-16 13:19:54.399420', '2025-01-16 13:19:54.399420');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Straat` varchar(120) NOT NULL,
  `Huisnummer` varchar(10) NOT NULL,
  `Postcode` varchar(6) NOT NULL,
  `Stad` varchar(50) NOT NULL,
  `isActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`Id`, `Straat`, `Huisnummer`, `Postcode`, `Stad`, `isActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Van Gilslaan', '34', '1045CB', 'Hilvarenbeek', b'1', NULL, '2025-01-16 13:19:54.492784', '2025-01-16 13:19:54.492784'),
(2, 'Den Dolderpad', '2', '1067RC', 'Utrecht', b'1', NULL, '2025-01-16 13:19:54.492784', '2025-01-16 13:19:54.492784'),
(3, 'Fredo Raalteweg', '257', '1236OP', 'Nijmegen', b'1', NULL, '2025-01-16 13:19:54.492784', '2025-01-16 13:19:54.492784'),
(4, 'Bertrand Russellhof', '21', '2034AP', 'Den Haag', b'1', NULL, '2025-01-16 13:19:54.492784', '2025-01-16 13:19:54.492784'),
(5, 'Leon van Bonstraat', '213', '145XC', 'Lunteren', b'1', NULL, '2025-01-16 13:19:54.492784', '2025-01-16 13:19:54.492784'),
(6, 'Bea van Lingenlaan', '234', '2197FG', 'Sint Pancras', b'1', NULL, '2025-01-16 13:19:54.492784', '2025-01-16 13:19:54.492784');

-- --------------------------------------------------------

--
-- Table structure for table `leverancier`
--

DROP TABLE IF EXISTS `leverancier`;
CREATE TABLE IF NOT EXISTS `leverancier` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Naam` varchar(50) NOT NULL,
  `ContactId` int UNSIGNED NOT NULL,
  `ContactPersoon` varchar(120) NOT NULL,
  `LeverancierNummer` varchar(50) NOT NULL,
  `Mobiel` varchar(15) NOT NULL,
  `isActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `DatumAangemaakt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `DatumGewijzigd` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  UNIQUE KEY `LeverancierNummer` (`LeverancierNummer`),
  KEY `ConatactId` (`ContactId`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `leverancier`
--

INSERT INTO `leverancier` (`Id`, `Naam`, `ContactId`, `ContactPersoon`, `LeverancierNummer`, `Mobiel`, `isActief`, `Opmerking`, `DatumAangemaakt`, `DatumGewijzigd`) VALUES
(1, 'Venco', 1, 'john', 'L1029384719', '06-28491234', b'1', NULL, '2025-01-16 13:19:54.421788', '2025-01-16 13:19:54.421788'),
(2, 'Astra Sweets', 2, 'Jasper del Monte', 'L1029284315', '06-39398734', b'1', NULL, '2025-01-16 13:19:54.421788', '2025-01-16 13:19:54.421788'),
(3, 'Haribo', 3, 'Sven Stalman', 'L1029324748', '06-24383291', b'1', NULL, '2025-01-16 13:19:54.421788', '2025-01-16 13:19:54.421788'),
(4, 'Basset', 4, 'Joyce Stelterberg', 'L1023845773', '06-48293823', b'1', NULL, '2025-01-16 13:19:54.421788', '2025-01-16 13:19:54.421788'),
(5, 'De Bron', 5, 'Remco Veenstra', 'L1023857736', '06-34291234', b'1', NULL, '2025-01-16 13:19:54.421788', '2025-01-16 13:19:54.421788'),
(6, 'Quality Street', 6, 'Jogan Nooij', 'L1029234586', '06-23458456', b'1', NULL, '2025-01-16 13:19:54.421788', '2025-01-16 13:19:54.421788');

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
(1, 1, '5.00', 453, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(2, 2, '2.50', 400, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(3, 3, '5.00', 1, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(4, 4, '1.00', 800, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(5, 5, '3.00', 234, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(6, 6, '2.00', 345, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(7, 7, '1.00', 795, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(8, 8, '10.00', 233, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(9, 9, '2.50', 123, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(10, 10, '3.00', 0, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(11, 11, '2.00', 367, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(12, 12, '1.00', 467, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111'),
(13, 13, '5.00', 20, b'1', NULL, '2025-01-16 13:19:54.379111', '2025-01-16 13:19:54.379111');

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
(1, 'Mintnopjes', '8719587231278', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(2, 'Schoolkrijt', '8719587326713', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(3, 'Honingdrop', '8719587327836', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(4, 'Zure Beren', '8719587321441', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(5, 'Cola Flesjes', '8719587321237', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(6, 'Turtles', '8719587322245', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(7, 'Witte Muizen', '8719587328256', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(8, 'Reuzen Slangen', '8719587325641', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(9, 'Zoute Rijen', '8719587322739', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(10, 'Winegums', '8719587327527', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(11, 'Drop Munten', '8719587322345', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(12, 'Kruis Drop', '8719587322265', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323'),
(13, 'Zoute Ruitjes', '8719587323256', b'1', NULL, '2025-01-16 13:19:54.356323', '2025-01-16 13:19:54.356323');

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
(1, 1, 2, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(2, 1, 1, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(3, 1, 3, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(4, 3, 4, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(5, 6, 5, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(6, 9, 2, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(7, 9, 5, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(8, 10, 2, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(9, 12, 4, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(10, 13, 1, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(11, 13, 4, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523'),
(12, 13, 5, b'1', NULL, '2025-01-16 13:19:54.471523', '2025-01-16 13:19:54.471523');

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
(1, 1, 1, '2024-11-09', 23, '2024-11-16', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(2, 1, 1, '2024-11-18', 21, '2024-11-25', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(3, 2, 1, '2024-11-09', 12, '2024-11-16', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(4, 3, 1, '2024-11-10', 11, '2024-11-17', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(5, 4, 2, '2024-11-14', 16, '2024-11-21', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(6, 4, 2, '2024-11-21', 23, '2024-11-28', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(7, 5, 2, '2024-11-14', 45, '2024-11-21', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(8, 6, 2, '2024-11-14', 30, '2024-11-21', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(9, 7, 3, '2024-11-12', 12, '2024-11-19', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(10, 7, 3, '2024-11-19', 23, '2024-11-26', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(11, 8, 3, '2024-11-10', 12, '2024-11-01', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(12, 9, 3, '2024-11-11', 1, '2024-11-18', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(13, 10, 4, '2024-11-16', 24, '2024-11-30', b'0', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(14, 11, 5, '2024-11-10', 47, '2024-11-17', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(15, 11, 5, '2024-11-19', 60, '2024-11-26', b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(16, 12, 5, '2024-11-11', 45, NULL, b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898'),
(17, 13, 5, '2024-11-12', 23, NULL, b'1', NULL, '2025-01-16 13:19:54.450898', '2025-01-16 13:19:54.450898');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
