-- =============================================
-- Zohrab
-- Asatryan
-- 240140
-- =============================================



-- =============================================
-- Zadanie 1

--https://github.com/Zohrab-A/BazaDanych_SQL
GO
-- =============================================


-- =============================================
-- Zadanie 2
ALTER TABLE [240140].[Customer]
ADD 
	SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START
	HIDDEN NOT NULL DEFAULT SYSUTCDATETIME(),
	SysEndTime DATETIME2 GENERATED ALWAYS AS
	ROW END HIDDEN NOT NULL DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
	PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

GO

ALTER TABLE [240140].[Customer]
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [240140].[CustomerHistory]));
GO
-- =============================================




-- =============================================
-- Zadanie 3
UPDATE TOP (10) [240140].[Customer]
SET ModifiedDate = GETDATE();
GO


DECLARE @TargetID INT = (SELECT TOP 1 CustomerID FROM [240140].[Customer] 
ORDER BY CustomerID);

UPDATE [240140].[Customer] SET Suffix = 'Jr.' WHERE CustomerID = @TargetID;
UPDATE [240140].[Customer] SET Suffix = 'Ms.' WHERE CustomerID = @TargetID;
UPDATE [240140].[Customer] SET Suffix = 'Mr.' WHERE CustomerID = @TargetID;

GO

INSERT INTO [240140].[Customer]
	(NameStyle, FirstName, LastName, EmailAddress, PasswordHash, PasswordSalt, rowguid, ModifiedDate)
	VALUES
	(0, 'Edek', 'Zielinski', 'edek@mail.com', 'hasz1', 'salt1' , NEWID(), GETDATE()),
	(0, 'Franek', 'Alanski', 'franek@mail.com', 'hasz2', 'salt2' , NEWID(), GETDATE()),
	(0, 'Menek', 'Belanski', 'menek@mail.com', 'hasz3', 'salt3' , NEWID(), GETDATE()),
	(0, 'Zedek', 'Cieliñski', 'zedek@mail.com', 'hasz4', 'salt4' , NEWID(), GETDATE()),
	(0, 'Janek', 'Derecki', 'derecki@mail.com', 'hasz5', 'salt5' , NEWID(), GETDATE());
	GO



-- =============================================


-- =============================================
-- Zadanie 4
DECLARE @TargetID INT = (SELECT TOP 1 CustomerID FROM [240140].[Customer] ORDER BY CustomerID);
SELECT * FROM [240140].[Customer] FOR SYSTEM_TIME ALL
WHERE CustomerID = @TargetID
ORDER BY SysStartTime ASC;

GO
-- =============================================


-- =============================================
-- Zadanie 5
SELECT * FROM [240140].[Customer]
FOR SYSTEM_TIME AS OF '2026-05-15 16:00';
GO
-- =============================================


-- =============================================
-- Zadanie 6
create XML SCHEMA COLLECTION [SalesLT].[ProductAttrSchema_240140] AS N'
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="Product" type="ProductType"/>
  <xs:complexType name="ProductType">
    <xs:sequence>
      <xs:element name="Kolor" type="xs:string"/>
      <xs:element name="Rozmiar" type="xs:decimal"/>
	  <xs:element name="Kraj" type="xs:string"/>
	  <xs:element name="Material" type="xs:string"/>
	  <xs:element name="Cena" type="xs:decimal"/>
    </xs:sequence>
  </xs:complexType>
</xs:schema>'; 
GO

CREATE TABLE [SalesLT].[ProductAttribute] (
	AttributeID INT IDENTITY(1,1) PRIMARY KEY,
	ProductID INT FOREIGN KEY REFERENCES [SalesLT].[Product](ProductID),
	ProductData XML ([SalesLT].[ProductAttrSchema_240140]) );

	GO

	
-- =============================================



-- =============================================
-- Zadanie 7
INSERT INTO [SalesLT].[ProductAttribute] (ProductID, ProductData)
values
(710, N'<Product><Kolor>Czerwony</Kolor><Rozmiar>12</Rozmiar><Kraj>Polska</Kraj><Material>Zloto</Material><Cena>24</Cena></Product>'),
(711, N'<Product><Kolor>Bialy</Kolor><Rozmiar>11</Rozmiar><Kraj>USA</Kraj><Material>Srebro</Material><Cena>12</Cena></Product>'),
(712, N'<Product><Kolor>Czarny</Kolor><Rozmiar>2</Rozmiar><Kraj>Niemcy</Kraj><Material>Plastik</Material><Cena>26</Cena></Product>'),
(713, N'<Product><Kolor>Zielony</Kolor><Rozmiar>15</Rozmiar><Kraj>Polska</Kraj><Material>Zloto</Material><Cena>38</Cena></Product>'),
(714, N'<Product><Kolor>Czerwony</Kolor><Rozmiar>21</Rozmiar><Kraj>USA</Kraj><Material>Zloto</Material><Cena>240</Cena></Product>');

GO
-- =============================================



-- =============================================
-- Zadanie 8

UPDATE [SalesLT].[ProductAttribute]
SET ProductData.modify('replace value of (/Product/Kolor)[1] with "Zielony"');

GO
-- =============================================



-- =============================================
-- Zadanie 9
DECLARE @json NVARCHAR(MAX) = N'{
	"Imie": "Dawid",
	"Nazwisko": "Podsiad³o",
	"NumerKonta": 210100
}'

SET @json = JSON_MODIFY(@json, '$.NumerKonta', 240140);

SELECT @json AS json_nowy;
GO
-- =============================================