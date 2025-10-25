CREATE TABLE IF NOT EXISTS fact_orders
(
    order_id     String,
    user_id      UInt32,
    order_ts     DateTime,
    order_date   Date,
    country      LowCardinality(String),
    revenue      Decimal(14,2)
)
ENGINE = MergeTree
ORDER BY (order_date, user_id);

INSERT INTO fact_orders
SELECT
    order_id,
    any(user_id)                          AS user_id,
    min(order_ts)                         AS order_ts,
    min(order_date)                       AS order_date,
    any(country)                          AS country,
    sum(line_revenue)                     AS revenue
FROM fact_order_lines
GROUP BY order_id;
