-- =============================================
-- Zohrab
-- Asatryan
-- 240140
-- =============================================


-- =============================================
-- Zadanie 1
CREATE TYPE dbo.Z0_surname FROM NVARCHAR(40) NOT NULL;

GO
ALTER TABLE [240140].[Customer] ALTER COLUMN LastName dbo.Z0_surname;
GO
-- =============================================



-- =============================================
-- Zadanie 2
CREATE TABLE dbo.tabela_json (ProductID INT, NewPrice DECIMAL (12,2));
go
create view dbo.v_ProductPriceDIff AS
SELECT 
	p.ProductID,
	P.Name,
	p.ListPrice AS AktualnaCena,
	j.NewPrice AS PlanowanaCena,
	(.j.NewPrice - p.ListPrice) AS roznica
FROM SalesLT.Product p
INNER JOIN dbo.tabela_json j ON p.ProductID = j.ProductID;
GO
SELECT * FROM SalesLT.Product

DECLARE @ProductInfo NVARCHAR(MAX) = N'[
	{"ProductID":712, "NewPrice": 200},
	{"ProductID":713, "NewPrice": 310},
	{"ProductID":714, "NewPrice": 530},
	{"ProductID":715, "NewPrice": 120},
	{"ProductID":716, "NewPrice": 321}
]';


INSERT INTO dbo.tabela_json (ProductID, NewPrice)
SELECT ProductID, NewPrice
FROM OPENJSON(@ProductINFO)
WITH (
	ProductID INT '$.ProductID'.
	NewPrice DECIMAL(12,2) '$.NewPrice');


SELECT * FROM dbo.v_ProductPriceDiff;

drop table dbo.tabela_json;
go
-- =============================================


-- =============================================
-- Zadanie 3

create view dbo.[240140_order] AS 
SELECT TOP 20
	VendorID,
	Name,
	AccountNumber,
	CreditRating,
	ActiveFlag
FROM SalesLT.Vendor
Order by CreditRating DESC;
GO
-- =============================================


-- =============================================
-- Zadanie 4



create view Student_0.MyLogicView AS
SELECT
	ProductID,
	Name AS ProductName,
	ProductNumber,
	ListPrice,
	DiscontinuedDate
FROM SalesLT.Product
WHERE DiscontinuedDate IS NOT NULL;
GO

--potrzeb¹ biznesow¹ tutaj jest aby frima mia³a wgl¹d na produkty wycofane ze sprzeda¿y
-- i np mog³a je daæ na promocjê


-- =============================================

-- =============================================
-- Zadanie 5


CREATE VIEW dbo.drogie_produkty AS
SELECT 
	ProductName,
	ProductNumber,
	ListPrice
from Student_0.MyLogicView
where ListPrice > 200;
go
-- =============================================

