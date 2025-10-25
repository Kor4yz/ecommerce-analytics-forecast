# SQL для ClickHouse

Порядок выполнения:
1. `01_create_database.sql`
2. `02_create_tables.sql`
3. `03_build_facts_and_views.sql` — зальёт данные из `staging_orders` в факты и создаст представления под DataLens.

Загрузка CSV:

```bash
clickhouse-client --query="INSERT INTO ecommerce.staging_orders FORMAT CSVWithNames" < ../data/ecommerce_full.csv
```
Ключевые представления:

v_daily_kpi — ежедневные метрики (gmv, orders, buyers, aov, arpu, new_buyer_share)

v_gmv_by_country — GMV/заказы по странам и датам

v_orders_enriched — таблица для сегментации покупателей (first_order_date, is_returning)

v_cohorts_retention — когортная таблица (cohort_month × month_n × retained_share)

v_top_products — топ SKU по GMV/Qty по месяцам

v_sku_gmv_qty — срез для графика «GMV vs QTY»
