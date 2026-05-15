CREATE TABLE [SalesLT].[VendorPriceHistory] (
    [QuoteID]   BIGINT   NULL,
    [VendorID]  INT      NOT NULL,
    [ProductID] INT      NOT NULL,
    [Price]     MONEY    NOT NULL,
    [QuoteDate] DATETIME NOT NULL
);


GO
CREATE CLUSTERED INDEX [index_dwa]
    ON [SalesLT].[VendorPriceHistory]([VendorID] ASC, [ProductID] ASC, [QuoteDate] ASC) WITH (FILLFACTOR = 25);

