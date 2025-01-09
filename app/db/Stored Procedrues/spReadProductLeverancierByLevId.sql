-- v1
-- 18-10-2024
-- Luka
-- get product and leverancier information

use `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spReadProductLeverancierByLevId;

DELIMITER // 

CREATE PROCEDURE spReadProductLeverancierByLevId(
    IN GivenLevId INT UNSIGNED
) 

BEGIN
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


END // 

DELIMITER ;

-- call the sql routine
-- call spReadProductLeverancierById(2);