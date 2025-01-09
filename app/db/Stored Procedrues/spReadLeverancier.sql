USE `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spReadLeverancierLimit;

DELIMITER //

CREATE PROCEDURE spReadLeverancierLimit(
    IN offset INT,
    IN itemsPerPage INT
)
BEGIN
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
END //

DELIMITER ;