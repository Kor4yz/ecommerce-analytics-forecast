CREATE OR REPLACE VIEW v_cohorts_retention AS
WITH base AS (
  SELECT
    user_id,
    cohort_month,
    toStartOfMonth(order_date) AS active_month
  FROM v_orders_enriched
),
cohort_size AS (
  SELECT cohort_month, uniqExact(user_id) AS buyers
  FROM v_orders_enriched
  WHERE order_date = first_order_date
  GROUP BY cohort_month
),
ret AS (
  SELECT
    cohort_month,
    dateDiff('month', cohort_month, active_month) AS month_n,
    uniqExact(user_id) AS active_buyers
  FROM base
  GROUP BY cohort_month, month_n
)
SELECT
  r.cohort_month,
  r.month_n,
  r.active_buyers,
  round(r.active_buyers / NULLIF(c.buyers,0), 4) AS retained_share
FROM ret r
JOIN cohort_size c USING (cohort_month)
ORDER BY cohort_month, month_n;
