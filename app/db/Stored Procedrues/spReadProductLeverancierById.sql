-- v1
-- 18-10-2024
-- Luka
-- get product and leverancier information

use `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spReadProductLeverancierById;

DELIMITER // 

CREATE PROCEDURE spReadProductLeverancierById(
    IN GivenProductId INT UNSIGNED
) 

BEGIN
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


END // 

DELIMITER ;

-- call the sql routine
-- call spReadProductLeverancierById(2);