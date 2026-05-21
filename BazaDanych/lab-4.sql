-- =============================================
-- Zohrab
-- Asatryan
-- 240140
-- =============================================


-- =============================================
-- Zadanie 1
DECLARE @Litera CHAR(1) = 'Z';
DECLARE @Cyfra INT = 0;

SELECT
	CustomerID,
	FirstName,
	LastName
FROM SalesLT.Customer 
WHERE LastName LIKE @Litera + '%'
AND CustomerID % 10 = @Cyfra;

GO

-- =============================================



-- =============================================
-- Zadanie 2
DECLARE @Produkty TABLE (
	ProductID INT,
	Name NVARCHAR(50),
	ListPrice MONEY
);

INSERT INTO @Produkty (ProductID, Name, ListPrice)
SELECT
	ProductID,
	Name,
	ListPrice
FROM SalesLT.Product
WHERE Name LIKE '%Z%';

SELECT * FROM @Produkty;


GO
-- =============================================


-- =============================================
-- Zadanie 3
SELECT
	c.CustomerID,
	c.FirstName,
	c.LastName,
	a.City
INTO #KlienciMiasta
FROM SalesLT.Customer c
JOIN SalesLT.CustomerAddress ca ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address a ON ca.AddressID = a.AddressID
WHERE a.City LIKE 'Z%'



SELECT * FROM #KlienciMiasta;

DROP TABLE #KlienciMiasta;

GO
-- =============================================



-- =============================================
-- Zadanie 4
GO

CREATE SCHEMA Student_0;

GO

CREATE TABLE Student_0.ProduktyZ (
	ProductID INT,
	Name NVARCHAR(100),
	Category NVARCHAR(100),
	ListPrice MONEY
);
GO

INSERT INTO Student_0.ProuktyZ (ProductID, Name, Category, ListPrice)
SELECT
	p.ProductID,
	p.Name,
	pc.Name,
	p.ListPrice
FROM SalesLT.Product p
JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name LIKE '%Z%';

GO
-- =============================================



-- =============================================
-- Zadanie 5

DECLARE @Podsumowanie TABLE (
	Category NVARCHAR(100),
	SredniaCena MONEY
);



INSERT INTO @Podsumowanie (Category, SredniaCena)
SELECT
	pc.Name, AVG(p.ListPrice)
FROM SalesLT.Product p
JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
WHERE pc.ProductCategoryID % 10 = 0
GROUP BY pc.Name;



SELECT * FROM @Podsumowanie;


GO
-- =============================================


-- =============================================
-- Zadanie 6
GO

CREATE SCHEMA [240140];
GO

ALTER SCHEMA [240140] TRANSFER SalesLT.Customer;
ALTER SCHEMA [240140] TRANSFER SalesLT.CustomerAddress;
GO
-- =============================================