-- ЦЕЛЬ: Когоры по месяцу первой покупки и удержание
-- ВХОД: orders(user_id, order_ts, status='paid')
-- ВЫХОД: cohort_month, month_n, buyers, retained_share

WITH paid AS (
  SELECT user_id, DATE_TRUNC('month', order_ts) AS m
  FROM orders WHERE status='paid'
),
first_buy AS (
  SELECT user_id, MIN(m) AS cohort_month
  FROM paid GROUP BY user_id
),
activity AS (
  SELECT p.user_id, fb.cohort_month, p.m AS active_month
  FROM paid p JOIN first_buy fb USING(user_id)
),
cohort_size AS (
  SELECT cohort_month, COUNT(DISTINCT user_id) AS buyers
  FROM first_buy GROUP BY cohort_month
),
retention AS (
  SELECT
    cohort_month,
    EXTRACT(MONTH FROM age(active_month, cohort_month))::int AS month_n,
    COUNT(DISTINCT user_id)                                  AS active_buyers
  FROM activity
  GROUP BY cohort_month, month_n
)
SELECT
  r.cohort_month,
  r.month_n,
  r.active_buyers,
  ROUND(r.active_buyers::numeric / NULLIF(c.buyers,0), 4) AS retained_share
FROM retention r
JOIN cohort_size c USING(cohort_month)
ORDER BY cohort_month, month_n;
