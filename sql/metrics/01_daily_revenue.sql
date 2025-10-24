WITH orders AS (
  SELECT
    CAST(order_date AS DATE) AS order_date,
    qty * price AS revenue
  FROM {{ source_table }}  -- поясни в README, как подставлять
)
SELECT order_date, SUM(revenue) AS revenue
FROM orders
GROUP BY 1
ORDER BY 1;
