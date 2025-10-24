import pandas as pd

def daily_sales(df: pd.DataFrame) -> pd.DataFrame:
    return (df.groupby(df["order_date"].dt.date)["revenue"]
              .sum()
              .reset_index(name="revenue"))
