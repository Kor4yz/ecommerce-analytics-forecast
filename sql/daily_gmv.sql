WITH paid AS (
  SELECT
    order_id,
    user_id,
    order_ts::date AS d,
    revenue,
    is_new_user::int AS is_new
  FROM orders
  WHERE status = 'paid'
)
SELECT
  d,
  SUM(revenue) AS gmv,
  COUNT(DISTINCT order_id) AS orders,
  COUNT(DISTINCT user_id) AS buyers,
  ROUND(SUM(revenue) / NULLIF(COUNT(DISTINCT order_id),0), 2) AS aov,
  ROUND(SUM(CASE WHEN is_new=1 THEN revenue END) / NULLIF(SUM(revenue),0), 4) AS new_buyer_gmv_share
FROM paid
GROUP BY d
ORDER BY d;
