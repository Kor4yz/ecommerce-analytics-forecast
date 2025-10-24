import pandas as pd
from src.features import daily_sales

def test_daily_sales_basic():
    df = pd.DataFrame({
        "order_date": pd.to_datetime(["2024-01-01","2024-01-01","2024-01-02"]),
        "revenue": [10, 5, 7]
    })
    out = daily_sales(df)
    assert len(out) == 2
    assert out.loc[out["order_date"]==pd.Timestamp("2024-01-01").date(), "revenue"].iloc[0] == 15
