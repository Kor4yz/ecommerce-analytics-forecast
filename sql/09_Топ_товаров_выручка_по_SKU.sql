CREATE OR REPLACE VIEW v_top_products AS
SELECT
  toStartOfMonth(order_date) AS m,
  stock_code,
  any(description)           AS description,
  sum(line_revenue)          AS gmv,
  sum(quantity)              AS qty
FROM fact_order_lines
GROUP BY m, stock_code
ORDER BY m, gmv DESC;
    
