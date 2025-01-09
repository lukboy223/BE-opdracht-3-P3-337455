drop database if exists Magazijnjamil;
create database Magazijnjamil;
use Magazijnjamil;

create table Product (
Id                          int             unsigned    not null    auto_increment
,Naam                       varchar(120)                not null
,Barcode                    varchar(20)                 not null    
,isActief                   bit                         not null    default 1
,Opmerking                  varchar(250)                null        default null
,DatumAangemaakt            Datetime(6)                 not null    default NOW(6)
,DatumGewijzigd             Datetime(6)                 not null    default NOW(6)
,primary key                (Id)
);

Create table Magazijn (
Id                          int             unsigned    not null    auto_increment
,ProductId                  int             unsigned    not null
,VerpakingsInhoudKilogram   decimal(6,2)                not null
,AantalAanwezig             mediumint       unsigned    null        default 0
,isActief                   bit                         not null    default 1
,Opmerking                  varchar(250)                null        default null
,DatumAangemaakt            Datetime(6)                 not null    default NOW(6)
,DatumGewijzigd             Datetime(6)                 not null    default NOW(6)
,primary key                (Id)
,foreign key                (ProductId) references product(Id)
);

create table ProductPerAllergeen (
Id                          int             unsigned    not null    auto_increment
,ProductId                  int             unsigned    not null
,AllergeenId                int             unsigned    not null
,isActief                   bit                         not null    default 1
,Opmerking                  varchar(250)                null        default null
,DatumAangemaakt            Datetime(6)                 not null    default NOW(6)
,DatumGewijzigd             Datetime(6)                 not null    default NOW(6)
,primary key                (Id)
,foreign key                (ProductId) references product(Id)
,foreign key                (AllergeenId) references Allergeen(Id)
);

create table Allergeen (
Id                          int             unsigned    not null    auto_increment
,Naam                       Varchar(50)                 not null
,Omschrijving               varchar(250)                not null
,isActief                   bit                         not null    default 1
,Opmerking                  varchar(250)                null        default null
,DatumAangemaakt            Datetime(6)                 not null    default NOW(6)
,DatumGewijzigd             Datetime(6)                 not null    default NOW(6)
,primary key (Id)
);

Create table ProductPerLeverAncier (
Id                          int             unsigned    not null    auto_increment
,ProductId                  int             unsigned    not null
,LeverancierId              int             unsigned    not null
,DatumLevering              date                        null
,Aantal                     mediumint       unsigned    not null
,DatumEerstVolgendeLevering date                        null
,isActief                   bit                         not null    default 1
,Opmerking                  varchar(250)                null        default null
,DatumAangemaakt            Datetime(6)                 not null    default NOW(6)
,DatumGewijzigd             Datetime(6)                 not null    default NOW(6)
,primary key                (Id)
,foreign key                (ProductId) references product(Id)
,foreign key                (LeverancierId) references Leverancier(Id)
);

create table Leverancier (
Id                          int             unsigned    not null    auto_increment
,Naam                       varchar(50)                 not null
,ContactPersoon             varchar(120)                not null
,LeverancierNummer          varchar(50)                 not null    unique
,Mobiel                     varchar(15)                 not null
,isActief                   bit                         not null    default 1
,Opmerking                  varchar(250)                null        default null
,DatumAangemaakt            Datetime(6)                 not null    default NOW(6)
,DatumGewijzigd             Datetime(6)                 not null    default NOW(6)
,primary key                (Id)
);