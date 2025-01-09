
use Magazijnjamil;

TRUNCATE TABLE Product;
TRUNCATE TABLE Magazijn;
TRUNCATE TABLE Allergeen;
TRUNCATE TABLE Leverancier;
TRUNCATE TABLE ProductPerLeverancier;
TRUNCATE TABLE ProductPerAllergeen;

INSERT INTO Product (Naam, Barcode) VALUES
('Mintnopjes',      '8719587231278'), 
('Schoolkrijt',     '8719587326713'), 
('Honingdrop',      '8719587327836'), 
('Zure Beren',      '8719587321441'), 
('Cola Flesjes',    '8719587321237'), 
('Turtles',         '8719587322245'), 
('Witte Muizen',    '8719587328256'), 
('Reuzen Slangen',  '8719587325641'), 
('Zoute Rijen',     '8719587322739'), 
('Winegums',        '8719587327527'), 
('Drop Munten',     '8719587322345'), 
('Kruis Drop',      '8719587322265'),
('Zoute Ruitjes',   '8719587323256');
  


INSERT INTO Magazijn (ProductId, VerpakingsInhoudKilogram, AantalAanwezig) VALUES
(1,     5,   453 ),
(2,     2.5, 400 ),
(3,     5,   1 ),
(4,     1,   800 ),
(5,     3,   234 ),
(6,     2,   345 ),
(7,     1,   795 ),
(8,     10,  233 ),
(9,     2.5, 123 ),
(10,    3,   0 ),
(11,    2,   367 ),
(12,    1,   467 ),
(13,    5,   20 );
  


INSERT INTO Allergeen (Naam, Omschrijving) VALUES
('Gluten',          'Dit product bevat gluten'),
('Gelatine',        'Dit product bevat gelatine '),
('AZO-Kleurstof',   'Dit product bevat AZO-kleurstoffen '),
('Lactose',         'Dit product bevat lactose '),
('Soja',            'Dit product bevat soja ');
  


INSERT INTO Leverancier (Naam, ContactPersoon, LeverancierNummer, Mobiel) VALUES
('Venco',           'Bert van Linge',       'L1029384719', '06-28493827'),
('Astra Sweets',    'Jasper del Monte',     'L1029284315', '06-39398734 '),
('Haribo',          'Sven Stalman',         'L1029324748', '06-24383291'),
('Basset',          'Joyce Stelterberg',    'L1023845773', '06-48293823'), 
('De Bron',         'Remco Veenstra',       'L1023857736', '06-34291234'),
('Quality Street',  'Jogan Nooij',          'L1029234586', '06-23458456');

INSERT INTO ProductPerLeverancier (LeverancierId, ProductId, DatumLevering, Aantal, DatumEerstVolgendeLevering, isActief) VALUES
(1, 1, '2024-11-09', 23, '2024-11-16',1), 
(1, 1, '2024-11-18', 21, '2024-11-25',1), 
(1, 2, '2024-11-09', 12, '2024-11-16',1), 
(1, 3, '2024-11-10', 11, '2024-11-17',1), 
(2, 4, '2024-11-14', 16, '2024-11-21',1), 
(2, 4, '2024-11-21', 23, '2024-11-28',1), 
(2, 5, '2024-11-14', 45, '2024-11-21',1), 
(2, 6, '2024-11-14', 30, '2024-11-21',1), 
(3, 7, '2024-11-12', 12, '2024-11-19',1), 
(3, 7, '2024-11-19', 23, '2024-11-26',1 ),
(3, 8, '2024-11-10', 12, '2024-11-1', 1), 
(3, 9, '2024-11-11', 1, '2024-11-18', 1), 
(4, 10, '2024-11-16', 24, '2024-11-30',0), 
(5, 11, '2024-11-10', 47, '2024-11-17',1), 
(5, 11, '2024-11-19', 60, '2024-11-26',1), 
(5, 12, '2024-11-11', 45, NULL,1 ),
(5, 13, '2024-11-12', 23, NULL,1);
  


INSERT INTO ProductPerAllergeen (ProductId, AllergeenId) VALUES
(1, 2), 
(1, 1), 
(1, 3), 
(3, 4), 
(6, 5), 
(9, 2), 
(9, 5), 
(10, 2), 
(12, 4), 
(13, 1), 
(13, 4), 
(13, 5);
