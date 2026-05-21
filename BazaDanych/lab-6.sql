-- =============================================
-- Zohrab
-- Asatryan
-- 240140
-- =============================================

-- =============================================
-- Zadanie 1

BEGIN TRAN;

SELECT * FROM SalesLT.Product WITH (HOLDLOCK);


GO

-- jest to niebezpiczne gdy¿ blokada trwa przez ca³y czas, a¿ siê go nie 'wy³¹czy', 
-- przez co w sytuacji gdy inni bêd¹ chceli coœ wykonaæ w tabeli 
-- to niê bed¹ w stanie 

-- =============================================


-- =============================================
-- Zadanie 2
CREATE TABLE tabela_zadanie2_insert (ID INT, Nazwa NVARCHAR(20), Suffix NVARCHAR(20));
CREATE TABLE tabela_zadanie2_truncate (ID INT, Nazwa NVARCHAR(20), Suffix NVARCHAR(20));


INSERT INTO tabela_zadanie2_truncate (Nazwa) VALUES
('q'),('w'),('e'),('r'),('t'),('y'),('u'),('i'),('o'),('v');

BEGIN TRAN;



UPDATE TOP (10) [240140].[Customer]
SET Suffix = 'Zohrab'
WHERE Suffix IS NULL;


INSERT INTO tabela_zadanie2_truncate (Nazwa)
VALUES
('Zoro1'),('Zoro2'),('Zoro3'),('Zoro4'),('Zoro5'),
('Zoro6'),('Zoro7'),('Zoro8'),('Zoro9'),('Zoro10');

truncate table tabela_zadanie2_truncate;

PRINT 'w trakcie';
SELECT COUNT(*) AS [nowy_customer] FROM [240140].[Customer] WHERE Suffix = 'Zohrab';
SELECT COUNT(*) AS [nowy_kategorie] FROM tabela_zadanie2_insert WHERE Nazwa LIKE 'Zoro%';
SELECT COUNT(*) AS [nowy_tabela2] FROM tabela_zadanie2_truncate;

ROLLBACK TRAN;

PRINT 'po rollbacku';
SELECT COUNT(*) AS [rollback_customer] FROM [240140].[Customer] WHERE Suffix = 'Zohrab';
SELECT COUNT(*) AS [rollback_kategorie] FROM tabela_zadanie2_insert WHERE Nazwa LIKE 'Zoro%';
SELECT COUNT(*) AS [rollback_tabela2] FROM tabela_zadanie2_truncate;


DROP TABLE tabela_zadanie2_insert;
DROP TABLE tabela_zadanie2_truncate;
GO


-- poo rollback cofne³o nam wszystkie zmiany jakie robiliœy. Baza wróæi³a do pocz¹tkowego stanu
-- select pokazuje nam wprowadzone a po rollbuck tylko same zera, do stany pierwotnego
-- dzieje sie tak gdyz rollback wycofuje nam wszystko
-- =============================================


-- =============================================
-- Zadanie 3
CREATE TABLE zadanie3 (ID INT, Nazwa NVARCHAR(20));
INSERT INTO zadanie3 VALUES (1,'Z');
GO


BEGIN TRAN;

UPDATE TOP (10) [240140].[Customer]
SET Suffix = 'Zohrab-2'
WHERE Suffix IS NULL;


WAITFOR DELAY '00:05:00';

ROLLBACK TRAN;
DROP TABLE zadanie3
GO


-- takie polecenie w niezale¿nej sesji: SELECT * FROM [240140].[Customer] WITH (NOLOCK);
GO
-- =============================================


-- =============================================
-- Zadanie 4

BEGIN TRY

	DECLARE @zle INT;
	SET @zle = CAST('240140' AS INT);
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS NumerBledu,
		ERROR_MESSAGE() AS TrescBledu,
		ERROR_SEVERITY() AS Powage;
END CATCH;
GO
-- =============================================


-- =============================================
-- Zadanie 5

-- za³o¿enie: tworze mechanizm dodawania produktu do magazynu
-- operacje: 
-- - sprawdzamy czy podana cena jest ujemna czy zerowa, jeœli zerowa to wyskoczy b³¹d
-- - probojemy wstawiæ produkt do SalesLT.Product. Potencjalne b³êdy to z³e dane podane oraz konflikt klucza obcego np gdy dana kategoria nie bedzie istnieæ


DECLARE @ProductName NVARCHAR(20) = 'hulajnoga Zohraba';
DECLARE @ProductNumber NVARCHAR(20) = '67';
DECLARE @Cena MONEY = -10.00;
DECLARE @CategoryID INT = 99999;
-- bledy w @cena oraz @categoryid sa specjalne do testu

BEGIN TRY

	IF @Cena <= 0
	BEGIN;
		THROW 50001, 'b³¹d: cena produktu nie mo¿e byæ ujemna lub równa zera', 1;
	END

	INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
	VALUES (@ProductName, @ProductNumber, 35.00, @Cena, @CategoryID, GETDATE());

	PRINT 'Pomyœlnie dodano';
END TRY

BEGIN CATCH

	PRINT 'Wyst¹pi³ b³¹d';
	PRINT ERROR_MESSAGE();
END CATCH;

GO






-- =============================================



-- =============================================
-- Zadanie 6

DECLARE @ProductName NVARCHAR(20) = 'hulajnoga Zohraba';
DECLARE @ProductNumber NVARCHAR(20) = '67';
DECLARE @Cena MONEY = -10.00;
DECLARE @CategoryID INT = 99999;


BEGIN TRY
	BEGIN TRAN;


	IF @Cena <= 0
	BEGIN;
		THROW 50001, 'b³¹d: cena produktu nie mo¿e byæ ujemna lub równa zera', 1;
	END

	INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
	VALUES (@ProductName, @ProductNumber, 35.00, @Cena, @CategoryID, GETDATE());



	COMMIT TRAN;
	PRINT 'Pomyœlnie dodano';
END TRY

BEGIN CATCH
	IF @@TRANCOUNT > 0
	BEGIN
		ROLLBACK TRAN;
		PRINT 'Wycofano'
	END

	PRINT 'Wystapil b³ad:';
	PRINT ERROR_MESSAGE();

END CATCH;

GO




-- =============================================