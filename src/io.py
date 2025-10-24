import pandas as pd
from .utils import load_config, ensure_dirs

def load_transactions(cfg=None) -> pd.DataFrame:
    cfg = cfg or load_config()
    df = pd.read_csv(cfg["paths"]["data_raw"])
    # минимальная валидация
    expected = {"order_id","order_date","customer_id","sku","qty","price"}
    missing = expected - set(df.columns)
    if missing:
        raise ValueError(f"Missing columns: {missing}")
    df["order_date"] = pd.to_datetime(df["order_date"])
    df["revenue"] = df["qty"] * df["price"]
    return df

def save_table(df: pd.DataFrame, name: str, cfg=None):
    cfg = cfg or load_config()
    ensure_dirs(cfg["paths"]["tables_dir"])
    df.to_csv(f'{cfg["paths"]["tables_dir"]}/{name}.csv', index=False)

if __name__ == "__main__":
    df = load_transactions()
    save_table(df.head(100), "sample")
