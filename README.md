# E-commerce Analytics & Forecast (light)

Лёгкая версия репозитория: без больших данных и изображений.
Скрипт в ноутбуке сгенерирует синтетические данные и построит графики при запуске.

## Структура
```
ecommerce-analytics-forecast/
├── data/
│   └── transactions_sample_head.csv  # маленький пример (10 строк)
├── notebooks/
│   └── ecommerce_analysis.ipynb      # ноутбук с генерацией данных и анализом
├── sql/
│   └── metrics.sql
├── src/
│   └── prepare_data.py
└── README.md
```

## Как воспроизвести
1) Откройте `notebooks/ecommerce_analysis.ipynb` и выполните все ячейки.
   - Ноутбук создаст `data/transactions_sample.csv` (~50-60k строк) и картинки в `reports/figures/`.
2) Запросы SQL лежат в `sql/metrics.sql`.

## Зачем так
Репозиторий лёгкий для загрузки на GitHub, а данные и отчёты генерируются автоматически.
