USE `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spReadLeverancierById;

DELIMITER //

CREATE PROCEDURE spReadLeverancierById(
    GivenLevId      INT UNSIGNED
)
BEGIN
    SELECT
       Id,
       Naam AS LeverancierNaam,
       ContactPersoon,
       LeverancierNummer,
       Mobiel
    
    FROM Leverancier
    WHERE Id = GivenLevId;
END //

DELIMITER ;
