CREATE OR REPLACE VIEW v_gmv_by_country AS
SELECT
  order_date AS d,
  country,
  sum(revenue) AS gmv,
  count()     AS orders
FROM fact_orders
GROUP BY d, country
ORDER BY d, gmv DESC;
