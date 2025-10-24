import pandas as pd
from statsmodels.tsa.holtwinters import ExponentialSmoothing

def ets_forecast(series: pd.Series, horizon: int = 30, seasonal: str = "add") -> pd.DataFrame:
    model = ExponentialSmoothing(series, trend="add", seasonal=seasonal, seasonal_periods=7)
    fit = model.fit()
    fc = fit.forecast(horizon)
    return fc.reset_index(drop=False).rename(columns={"index":"date", 0:"forecast"})
