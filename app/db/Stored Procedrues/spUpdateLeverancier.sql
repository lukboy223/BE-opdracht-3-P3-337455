use `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spUpdateLeverancier;

DELIMITER //

CREATE PROCEDURE spUpdateLeverancier(
    IN GivenLevId      INT UNSIGNED,
    IN GivenNaam       VARCHAR(120),
    IN GivenContactPersoon VARCHAR(120),
    IN GivenLeverancierNummer VARCHAR(20),
    IN GivenMobiel     VARCHAR(20),
    IN GivenContactId  INT UNSIGNED,
    IN GivenStraat     VARCHAR(120),
    IN GivenHuisnummer VARCHAR(10),
    IN GivenPostcode   VARCHAR(6),
    IN GivenStad       VARCHAR(120)
)
BEGIN

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

END //

DELIMITER ;