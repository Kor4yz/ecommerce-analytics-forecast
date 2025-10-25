CREATE OR REPLACE VIEW v_daily_kpi AS
SELECT
  order_date                                   AS d,
  sum(revenue)                                 AS gmv,
  count()                                      AS orders,
  uniqExact(user_id)                           AS buyers,
  round(gmv / NULLIF(orders,0), 2)             AS aov,
  round(sumIf(revenue, is_returning = 0) / NULLIF(sum(revenue),0), 4) AS new_buyer_share
FROM v_orders_enriched
GROUP BY d
ORDER BY d;
