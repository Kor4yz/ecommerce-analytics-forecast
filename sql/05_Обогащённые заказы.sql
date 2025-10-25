CREATE OR REPLACE VIEW v_orders_enriched AS
WITH first_buy AS (
  SELECT user_id, min(order_date) AS first_order_date
  FROM fact_orders
  GROUP BY user_id
)
SELECT
  f.order_id,
  f.user_id,
  f.order_ts,
  f.order_date,
  f.country,
  f.revenue,
  fb.first_order_date,
  toStartOfMonth(fb.first_order_date)                  AS cohort_month,
  if(f.order_date > fb.first_order_date, 1, 0)         AS is_returning
FROM fact_orders AS f
INNER JOIN first_buy AS fb USING (user_id);
