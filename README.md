# Ecommerce-analytics-forecast

Аналитический проект по e-commerce: полная витрина метрик в ClickHouse + интерактивные дашборды в Yandex DataLens.

## 🔍 Что внутри

- **Данные:** Kaggle “Online Retail” (Invoices, StockCode, Quantity, UnitPrice, CustomerID, Country).
- **Хранилище:** ClickHouse (стейджинг → факты → представления/марты).
- **BI:** Yandex DataLens (KPI, тренды GMV/AOV/ARPU, когорты retention, новые vs возвратные, топ SKU).
- **Ядро метрик:**
  - `GMV` = Σ (Quantity × UnitPrice)
  - `Orders` = countDistinct(order_id)
  - `Buyers` = countDistinct(user_id)
  - `AOV` = GMV / Orders
  - `ARPU` = GMV / Buyers
  - `New buyer share` = New buyers / Buyers
  - `Retention` = доля когорты, вернувшаяся в n-й месяц
---
## 🧱 Архитектура
data/ecommerce_full.csv → staging_orders

↳ fact_order_lines (нормализованные строки)

↳ fact_orders (агрегат по заказу)

↳ views/marts (для BI):

v_daily_kpi

v_gmv_by_country

v_orders_enriched

v_cohorts_retention

v_top_products

v_sku_gmv_qty

---

---
## 🗺️ Репозиторий

├─ data/ # описание датасетов

├─ notebooks/ # EDA/подготовка (Jupyter)

├─ sql/ # DDL/DML для ClickHouse (см. ниже)

├─ src/ # утилиты загрузки (при необходимости)

├─ docs/ # скриншоты и картинки для README
---


## 🚀 Быстрый старт (ClickHouse локально)

1) Создай БД и таблицы, загрузи CSV:

```bash
clickhouse-client -n < sql/01_create_database.sql
clickhouse-client -n < sql/02_create_tables.sql
# загрузка CSV (путь поправь на свой):
clickhouse-client --query="INSERT INTO staging_orders FORMAT CSVWithNames" < data/ecommerce_full.csv
# построение фактов/представлений:
clickhouse-client -n < sql/03_build_facts_and_views.sql
```
2)Проверь vitrine:
```bash
SELECT * FROM v_daily_kpi ORDER BY d LIMIT 10;
SELECT * FROM v_cohorts_retention ORDER BY cohort_month, month_n;
```
📊 Дашборды (DataLens)

Верхняя панель KPI: GMV / Orders / Buyers / AOV / New buyer share

Тренды: линия GMV по дням (MA7 + кумулятив), GMV по месяцам

Покупатели: нормированная областная (new vs returning)

Retention: тепловая карта по когортам (месяц регистрации × месяцы жизни)

Товары: GMV vs QTY (комбо), Top SKU by GMV

Дополнительно: AOV & ARPU (линии)

<p align="center">
  <img src="dashboards/KPI.png" alt="Основные KPI по travel" width="475"/>
  <img src="dashboards/Analyze.png" alt="Суммарный анализ" width="400"/>
</p>


📦 Источник данных

Kaggle: Online Retail Data Set (Автор: Dr. Daqing Chen, UCI)

https://www.kaggle.com/datasets/carrie1/ecommerce-data

🧰 Стек

ClickHouse • Yandex DataLens • Python/Jupyter • SQL

