

-- v1
-- 18-10-2024
-- Luka

-- requests all rows out of table Countries

use `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spReadMagazijnProduct;

 DELIMITER //

 CREATE PROCEDURE spReadMagazijnProduct()
  BEGIN
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


 END //  

DELIMITER ;



-- call the sql routine

-- call spReadMagazijnProduct();

