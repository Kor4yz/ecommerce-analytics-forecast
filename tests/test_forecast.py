import pandas as pd

def test_forecast_artifact():
    fc = pd.read_csv("artifacts/forecast.csv", parse_dates=["ds"])
    assert {"ds","yhat","yhat_lower","yhat_upper"}.issubset(fc.columns)
    assert not fc["yhat"].isna().any()
