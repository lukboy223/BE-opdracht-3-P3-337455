USE `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spReadLeverancierById;

DELIMITER //

CREATE PROCEDURE spReadContactById(
    GivenLevId      INT UNSIGNED
)
BEGIN
    SELECT
       Id,
       Straat,
       Huisnummer,
       Postcode,
       Stad
    
    FROM Contact
    WHERE Id = GivenLevId;
END //

DELIMITER ;
