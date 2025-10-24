-- ЦЕЛЬ: Ежедневная воронка от сессий до оплаты с разрезами по каналу
-- ВХОД: events(session_id, user_id, ts, event_type, channel)
-- ВЫХОД: d, channel, sessions, product_views, add_to_cart, checkout, paid, conv_total

WITH base AS (
  SELECT DATE(ts) AS d, channel, event_type
  FROM events
),
agg AS (
  SELECT
    d, channel,
    COUNTIF(event_type='session')       AS sessions,
    COUNTIF(event_type='product_view')  AS product_views,
    COUNTIF(event_type='add_to_cart')   AS add_to_cart,
    COUNTIF(event_type='checkout')      AS checkout,
    COUNTIF(event_type='paid')          AS paid
  FROM base
  GROUP BY d, channel
)
SELECT
  *,
  ROUND(paid / NULLIF(sessions,0)::numeric, 4) AS conv_total
FROM agg
ORDER BY d, channel;
