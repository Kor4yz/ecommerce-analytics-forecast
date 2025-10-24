-- metrics.sql : example product/finance queries

-- 1) DAU / WAU / MAU (assuming orders table has order_date and user_id)
-- DAU
SELECT order_date, COUNT(DISTINCT user_id) AS dau
FROM orders
GROUP BY order_date;

-- WAU (ISO weeks)
SELECT DATE_TRUNC('week', order_date) AS week, COUNT(DISTINCT user_id) AS wau
FROM orders
GROUP BY 1;

-- MAU
SELECT DATE_TRUNC('month', order_date) AS month, COUNT(DISTINCT user_id) AS mau
FROM orders
GROUP BY 1;

-- 2) Retention cohorts (by first purchase month)
WITH first_orders AS (
  SELECT user_id, MIN(DATE_TRUNC('month', order_date)) AS cohort_month
  FROM orders
  GROUP BY user_id
),
orders_by_month AS (
  SELECT o.user_id,
         DATE_TRUNC('month', o.order_date) AS order_month
  FROM orders o
)
SELECT f.cohort_month,
       o.order_month,
       COUNT(DISTINCT o.user_id) AS active_users
FROM first_orders f
JOIN orders_by_month o USING (user_id)
GROUP BY 1,2
ORDER BY 1,2;

-- 3) LTV proxy by cohort (avg revenue per user over N months since cohort)
WITH first_orders AS (
  SELECT user_id, MIN(DATE_TRUNC('month', order_date)) AS cohort_month
  FROM orders
  GROUP BY user_id
),
rev AS (
  SELECT user_id, DATE_TRUNC('month', order_date) AS order_month, SUM(revenue) AS revenue_m
  FROM orders
  GROUP BY 1,2
)
SELECT f.cohort_month,
       AVG(r.revenue_m) AS avg_monthly_rev_per_user
FROM first_orders f
LEFT JOIN rev r USING(user_id)
GROUP BY 1
ORDER BY 1;
