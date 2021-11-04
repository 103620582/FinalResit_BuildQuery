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
,   Description    NVARCHAR(100) NOT NULL
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

INSERT INTO ORGANISATION (OrgID, OrganisationName) VALUES ('DODG', 'Dod & Gy Widget Importers');
INSERT INTO ORGANISATION (OrgID, OrganisationName) VALUES ('SWUT', 'Swinburne University of Technology');

INSERT INTO CLIENT (ClientID, Name, Phone, OrgID) VALUES (12, 'Fred Flintstone', '(03)5555-1234', 'SWUT');
INSERT INTO CLIENT (ClientID, Name, Phone, OrgID) VALUES (15, 'Barney Rubble', '(03)5555-2345', 'DODG');
INSERT INTO CLIENT (ClientID, Name, Phone, OrgID) VALUES (18, 'Wilma Flinstone', '(03)5555-3456', 'SWUT');
INSERT INTO CLIENT (ClientID, Name, Phone, OrgID) VALUES (21, 'Betty Rubble', '(03)5555-4567', 'DODG');
INSERT INTO CLIENT (ClientID, Name, Phone, OrgID) VALUES (33, 'Joy Ambrose', '103620582', 'JOYA');

INSERT INTO MENUITEM (ItemID, Description, ServesPerUnit, UnitPrice) VALUES (3214, 'Tropical Pizza - Large', 2, 16.00);
INSERT INTO MENUITEM (ItemID, Description, ServesPerUnit, UnitPrice) VALUES (3216, 'Tropical Pizza - Small', 1, 12.00);
INSERT INTO MENUITEM (ItemID, Description, ServesPerUnit, UnitPrice) VALUES (3218, 'Tropical Pizza - Family', 4, 23.00);
INSERT INTO MENUITEM (ItemID, Description, ServesPerUnit, UnitPrice) VALUES (4325, 'Can - Coke Zero', 1, 2.50);
INSERT INTO MENUITEM (ItemID, Description, ServesPerUnit, UnitPrice) VALUES (4326, 'Can - Lemonade', 1, 2.50);
INSERT INTO MENUITEM (ItemID, Description, ServesPerUnit, UnitPrice) VALUES (4327, 'Can - Harden Up', 1, 7.50);

INSERT INTO [ORDER] (ClientID, OrderDate, DeliveryAddress) VALUES (12, '2021-10-20', 'Room TB225 - SUT - 1 John Street, Hawthorn, 3122');
INSERT INTO [ORDER] (ClientID, OrderDate, DeliveryAddress) VALUES (21, '2021-10-14', 'Room ATC009 - SUT - 1 John Street, Hawthorn, 3122');
INSERT INTO [ORDER] (ClientID, OrderDate, DeliveryAddress) VALUES (21, '2021-10-27', 'Room TB225 - SUT - 1 John Street, Hawthorn, 3122');
INSERT INTO [ORDER] (ClientID, OrderDate, DeliveryAddress) VALUES (15,	'2021-10-20',	'The George - 1 John Street, Hawthorn, 3122');
INSERT INTO [ORDER] (ClientID, OrderDate, DeliveryAddress) VALUES (18,	'2021-10-30',	'Room TB225 - SUT - 1 John Street, Hawthorn, 3122');

INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (3216, 12, '2021-10-20',	2);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (4326,	12,	'2021-10-20',	1);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (3218,	21,	'2021-10-14',	1);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (3214,	21,	'2021-10-14',	1);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (4325,	21,	'2021-10-14',	4);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (4327,	21,	'2021-10-14',	2);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (3216,	21,	'2021-10-27',	1);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (4327,	21,	'2021-10-27',	1);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (3218,	21,	'2021-10-27',	2);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (3216,	15,	'2021-10-20',	2);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (4326,	15,	'2021-10-20',	1);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (3216,	18,	'2021-10-30',	1);
INSERT INTO ORDERLINE (ItemID, ClientID, OrderDate, Qty) VALUES (4327,	18,	'2021-10-30',	1);

------ QUERY 1

SELECT OG.OrganisationName, C.Name, OL.OrderDate, OD.DeliveryAddress, M.Description, OL.Qty
FROM [ORDER] OD
INNER JOIN CLIENT C ON C.ClientID = OD.ClientID
INNER JOIN ORGANISATION OG ON OG.OrgID = C.OrgID
INNER JOIN ORDERLINE OL ON OL.ClientID = OD.ClientID AND OD.OrderDate = OL.OrderDate
INNER JOIN MENUITEM M ON M.ItemID = OL.ItemID;

------ QUERY 2

SELECT OG.OrgID, M.Description, SUM(Qty) as 'Total Quantity Ordered'
FROM MENUITEM M
INNER JOIN ORDERLINE OL ON OL.ItemID = M.ItemID
INNER JOIN CLIENT C ON OL.ClientID = C.ClientID
INNER JOIN ORGANISATION OG ON C.OrgID = OG.OrgID
GROUP BY OG.OrgID, M.Description
ORDER BY OrgID ASC

------ QUERY 3

SELECT OL.ItemID, OL.ClientID, OL.OrderDate, OL.Qty, M.Description, M.UnitPrice
FROM ORDERLINE OL
INNER JOIN MENUITEM M ON OL.ItemID = M.ItemID
WHERE (UnitPrice = (
    SELECT MAX(UnitPrice)
    FROM MENUITEM M)
    )



/* ------------- Task 5 -------------- */

CREATE VIEW [TASK_5] AS
SELECT OG.OrganisationName, C.Name, OL.OrderDate, OD.DeliveryAddress, M.Description, OL.Qty
FROM [ORDER] OD
INNER JOIN CLIENT C ON C.ClientID = OD.ClientID
INNER JOIN ORGANISATION OG ON OG.OrgID = C.OrgID
INNER JOIN ORDERLINE OL ON OL.ClientID = OD.ClientID AND OD.OrderDate = OL.OrderDate
INNER JOIN MENUITEM M ON M.ItemID = OL.ItemID;

