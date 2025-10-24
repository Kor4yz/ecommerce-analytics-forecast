-- ЦЕЛЬ: RFM-сегментация пользователей
-- ВХОД: orders(user_id, order_ts, revenue, status='paid')
-- ВЫХОД: user_id, R, F, M, r_quant, f_quant, m_quant, segment_label

WITH paid AS (
  SELECT user_id, order_ts::date AS d, revenue
  FROM orders WHERE status='paid'
),
agg AS (
  SELECT
    user_id,
    MAX(d)                      AS last_purchase_date,
    COUNT(*)                    AS frequency,
    SUM(revenue)                AS monetary
  FROM paid
  GROUP BY user_id
),
scores AS (
  SELECT
    user_id,
    (CURRENT_DATE - last_purchase_date) AS recency_days,
    frequency, monetary
  FROM agg
),
quant AS (
  SELECT
    user_id,
    NTILE(5) OVER (ORDER BY -recency_days) AS r_quant,  -- меньше recency = лучше
    NTILE(5) OVER (ORDER BY frequency)     AS f_quant,
    NTILE(5) OVER (ORDER BY monetary)      AS m_quant
  FROM scores
)
SELECT
  q.user_id,
  s.recency_days AS R,
  s.frequency    AS F,
  s.monetary     AS M,
  q.r_quant, q.f_quant, q.m_quant,
  CASE
    WHEN q.r_quant>=4 AND q.f_quant>=4 AND q.m_quant>=4 THEN 'Champion'
    WHEN q.r_quant>=3 AND q.f_quant>=3 AND q.m_quant>=3 THEN 'Loyal'
    WHEN q.r_quant<=2 AND q.f_quant>=3 THEN 'At Risk'
    ELSE 'Other'
  END AS segment_label
FROM quant q
JOIN scores s USING(user_id);
