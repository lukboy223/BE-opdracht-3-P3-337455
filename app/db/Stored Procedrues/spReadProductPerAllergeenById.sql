

-- v1
-- 18-10-2024
-- Luka

-- requests all rows out of table Countries

use `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spReadProductPerAllergeenById;

 DELIMITER //

 CREATE PROCEDURE spReadProductPerAllergeenById(
  IN GivenProductId     INT
 )
  BEGIN
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

 END //  

DELIMITER ;



-- call the sql routine

-- call spReadProductPerAllergeenById(1);

