# E-commerce Analytics & Forecast (light)
## 🚀 Задача
Прогноз GMV и KPI e-commerce, когортный анализ и воронка.

## 🧰 Стек
Python, Pandas, Statsmodels/Prophet, SQL (CTE), Jupyter, GitHub Actions, Datalens.

## 🧪 Как запустить
python -m venv .venv && source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
python -m src.main --build-data --make-figures --forecast

<p align="center">
  <img src="dashboards/kpi_board.png" alt="KPI board: GMV, AOV, Conversion, New buyer share" width="45%">
  <img src="dashboards/cohorts_retention.png" alt="Cohort retention heatmap" width="45%">
</p>


## Структура
```
ecommerce-analytics-forecast/
├── data/       # сырьё/семплы
│   └── transactions_sample_head.csv  
├── notebooks/  # 01_eda.ipynb, 02_modeling_forecast.ipynb
│   └── ecommerce_analysis.ipynb      
├── sql/        # метрики и витрины
│   └── metrics.sql  
├── src/        # функциональные скрипты/cli
│   └── prepare_data.py
├─ dashboards/  # png/pdf скрины BI
├─ docs/        # gh-pages (index.html + картинки)
└── README.md
```
