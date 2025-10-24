from pathlib import Path
import pandas as pd

def test_orders_schema():
    df = pd.read_parquet("artifacts/orders.parquet")
    expected = {"order_id","user_id","order_ts","revenue","status","is_new_user"}
    assert expected.issubset(df.columns)
    assert df["revenue"].ge(0).all()
