-- v1
-- 25-09-2024
-- Luka
-- creates row in country

use `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spUpdateLeverancierPerProduct;

DELIMITER // 

CREATE PROCEDURE spUpdateLeverancierPerProduct
(
    IN PPLId           int unsigned
    ,IN DatumLev        date
    ,IN AantalLev       mediumint UNSIGNED
) 

BEGIN

update productperleverancier
SET 
    DatumLevering = DatumLev
    ,Aantal = AantalLev

WHERE Id = PPLId;

END // 

DELIMITER ;

-- call the sql routine
-- call spCreateCountry();