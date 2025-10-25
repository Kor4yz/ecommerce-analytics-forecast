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
