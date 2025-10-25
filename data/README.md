# 📊 Data Folder

Здесь находятся все данные, используемые в проекте **E-commerce Analytics & Forecast**.

## 📁 Структура
---

data/
├── raw/ # Сырые данные (исходные транзакции)

│ └── ecommerce-analytics-forecast.csv

├── processed/ # Обработанные данные (agregations, parquet)

│ └── transactions_sample_head.csv

---

---

## 📘 Data Dictionary (описание полей)

| Колонка | Тип | Описание |
|----------|------|----------|
| `order_id` | int | ID заказа |
| `user_id` | int | ID пользователя |
| `order_ts` | datetime | Время оформления заказа |
| `status` | str | Статус (`paid`, `cancelled`, `refunded`) |
| `revenue` | float | Сумма заказа (руб.) |
| `category` | str | Категория товара |
| `channel` | str | Канал привлечения (`direct`, `organic`, `ads`) |
| `region` | str | Регион покупателя |
| `device` | str | Тип устройства (`desktop`, `mobile`) |

---

## ⚙️ Использование в пайплайне

- 📥 Исходные данные (`raw/ecommerce-analytics-forecast.csv`) читаются функцией `build_dataset()` из [`src/pipeline.py`](../src/pipeline.py).  
- 🧹 После очистки и агрегации создаются:
  - `processed/orders.parquet` — очищенные заказы,
  - `processed/events.parquet` — события для воронки (сгенерированные при необходимости).

---

## 📎 Пример загрузки в Python

```python
import pandas as pd

df = pd.read_csv("data/raw/ecommerce-analytics-forecast.csv", parse_dates=["order_ts"])
print(df.head())
