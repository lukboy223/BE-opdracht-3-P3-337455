USE `Magazijnjamil`;

DROP PROCEDURE IF EXISTS spReadLeverancier;

DELIMITER //

CREATE PROCEDURE spReadLeverancier()
BEGIN
        SELECT
       LEV.id as LeverancierId,
       LEV.Naam AS LeverancierNaam,
       ContactPersoon,
       LeverancierNummer,
       Mobiel,
       COUNT(DISTINCT PRO.Naam) AS VerProducten
    FROM Leverancier AS LEV
    LEFT JOIN ProductPerLeverancier AS PROLev
    ON LEV.id = PROLev.LeverancierId
    left join Product as PRO
    on PROLev.ProductId = PRO.Id
    GROUP BY LEV.id, LeverancierNaam
    ORDER BY VerProducten DESC;
END //

DELIMITER ;
