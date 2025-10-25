CREATE OR REPLACE VIEW v_orders_enriched AS
WITH first_buy AS (
    SELECT user_id, min(order_date) AS first_order_date
    FROM fact_orders
    GROUP BY user_id
)
SELECT
    f.*,
    fb.first_order_date,
    toStartOfMonth(fb.first_order_date)           AS cohort_month,
    (f.order_date > fb.first_order_date) ? 1 : 0  AS is_returning
FROM fact_orders f
LEFT JOIN first_buy fb USING (user_id);
