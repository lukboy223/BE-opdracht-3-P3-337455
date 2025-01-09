-- v1
-- 18-10-2024
-- Luka
-- get product and leverancier information

use `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spReadProductLeverancierByProId;

DELIMITER // 

CREATE PROCEDURE spReadProductLeverancierByProId(
    IN GivenProductId INT UNSIGNED
) 

BEGIN
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


END // 

DELIMITER ;

-- call the sql routine
-- call spReadProductLeverancierByProId(2);