CREATE TABLE IF NOT EXISTS staging_orders
(
    InvoiceNo     String,
    StockCode     String,
    Description   String,
    Quantity      Int32,
    InvoiceDate   String,   
    UnitPrice     Float64,
    CustomerID    String,
    Country       String
)
ENGINE = MergeTree
ORDER BY (InvoiceNo, StockCode);
