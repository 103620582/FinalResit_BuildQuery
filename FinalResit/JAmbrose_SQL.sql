/* 

Joy Ambrose
103620582

ORGANISATION (OrgID, OrganisationName)
PK - (OrgID)

CLIENT (ClientID, Name, Phone, OrgID)
PK - (ClientID)
FK - (OrgID) Ref ORGANISATION

MENUITEM (ItemID, Description, ServesPerUnit, UnitPrice)
PK - (ItemID)

ORDER - (ClientID, OrderDate, DeliveryAddress)
PK - (ClientID, OrderDate)
FK - (ClientID) Ref CLIENT

ORDERLINE (ItemID, ClientID, OrderDate, Qty)
PK - (ItemID, ClientID, OrderDate)
FK - (ItemID) Ref MENUITEM
FK - (ClientID, OrderDate) Ref ORDER




*/

-- USE FinalResit;

-- SELECT name, database_id, create_date  
-- FROM sys.databases; 

DROP TABLE IF EXISTS ORGANISATION;

GO

CREATE TABLE ORGANISATION (
    OrgID               NVARCHAR(4)
,   OrganisationName    NVARCHAR(200) NOT NULL
,   PRIMARY KEY (OrgID)
);

GO

DROP TABLE IF EXISTS CLIENT;

GO

CREATE TABLE CLIENT (
    ClientID    INT
,   Name        NVARCHAR(100) NOT NULL
,   Phone       NVARCHAR(15) NOT NULL
,   OrgID       NVARCHAR(4)
,   PRIMARY KEY (ClientID)
);

GO

DROP TABLE IF EXISTS MENUITEM;

GO

CREATE TABLE MENUITEM (
    ItemID          INT
,   Desceription    NVARCHAR(100) NOT NULL
,   ServesPerUnit   INT NOT NULL
,   UnitPrice       MONEY NOT NULL
,   PRIMARY KEY (ItemID)
);

GO

DROP TABLE IF EXISTS [ORDER];

GO

CREATE TABLE [ORDER] (
    ClientID        INT
,   OrderDate       DATE
,   DeliveryAddress NVARCHAR(MAX)
,   PRIMARY KEY (ClientID, OrderDate)
,   FOREIGN KEY (ClientID) REFERENCES CLIENT
);

GO

DROP TABLE IF EXISTS ORDERLINE;

GO

CREATE TABLE ORDERLINE (
    ItemID          INT
,   ClientID        INT
,   OrderDate       DATE
,   Qty             INT
, PRIMARY KEY (ItemID, ClientID, OrderDate)
, FOREIGN KEY (ItemID) References MENUITEM
, FOREIGN KEY (ClientID, OrderDate) References [ORDER]
);

GO

-- SELECT * FROM ORGANISATION;
-- GO
-- SELECT * FROM CLIENT;
-- GO
-- SELECT * FROM MENUITEM;
-- GO
-- SELECT * FROM [ORDER];
-- GO
-- SELECT * FROM ORDERLINE;
-- GO

