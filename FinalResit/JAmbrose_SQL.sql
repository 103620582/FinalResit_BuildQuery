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

USE FinalResit;

*/

