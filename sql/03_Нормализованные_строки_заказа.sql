CREATE TABLE IF NOT EXISTS fact_order_lines
(
    order_id     String,
    user_id      UInt32,
    order_ts     DateTime,
    order_date   Date,
    country      LowCardinality(String),
    stock_code   String,
    description  String,
    quantity     Int32,
    unit_price   Decimal(12,2),
    line_revenue Decimal(14,2)
)
ENGINE = MergeTree
ORDER BY (order_date, order_id, stock_code);

INSERT INTO fact_order_lines
SELECT
    InvoiceNo                                AS order_id,
    toUInt32(CustomerID)                     AS user_id,
    InvoiceDate                              AS order_ts,
    toDate(InvoiceDate)                      AS order_date,
    Country                                  AS country,
    StockCode                                AS stock_code,
    Description                              AS description,
    Quantity                                 AS quantity,
    UnitPrice                                AS unit_price,
    CAST(Quantity, 'Decimal(14,2)') * UnitPrice AS line_revenue
FROM staging_orders
WHERE CustomerID IS NOT NULL
  AND Quantity > 0
  AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%';      -- убираем возвраты
