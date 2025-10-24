import pandas as pd
from datetime import timedelta

def build_rfm(df: pd.DataFrame, as_of=None) -> pd.DataFrame:
    as_of = pd.to_datetime(as_of) if as_of else df["order_date"].max()
    pivot = (df.groupby("customer_id")
               .agg(last_date=("order_date","max"),
                    frequency=("order_id","nunique"),
                    monetary=("revenue","sum"))
               .reset_index())
    pivot["recency"] = (as_of - pivot["last_date"]).dt.days
    return pivot[["customer_id","recency","frequency","monetary"]]
