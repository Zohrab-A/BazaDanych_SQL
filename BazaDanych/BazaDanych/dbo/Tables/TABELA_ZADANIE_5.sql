CREATE TABLE [dbo].[TABELA_ZADANIE_5] (
    [ID]         INT NOT NULL,
    [CustomerID] INT NULL,
    [ProductID]  INT NULL,
    [Ilosc]      INT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    FOREIGN KEY ([CustomerID]) REFERENCES [240140].[Customer] ([CustomerID]),
    FOREIGN KEY ([ProductID]) REFERENCES [SalesLT].[Product] ([ProductID])
);


GO
CREATE NONCLUSTERED INDEX [index_jeden_zad5]
    ON [dbo].[TABELA_ZADANIE_5]([CustomerID] ASC)
    INCLUDE([ProductID], [Ilosc]);


GO
CREATE NONCLUSTERED INDEX [index_dwa_zad5]
    ON [dbo].[TABELA_ZADANIE_5]([ProductID] ASC) WHERE ([Ilosc]>(0));

