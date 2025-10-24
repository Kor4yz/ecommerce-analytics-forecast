import pandas as pd
import matplotlib.pyplot as plt
from .utils import load_config, ensure_dirs

def export_daily_revenue_plot(daily_df: pd.DataFrame, cfg=None):
    cfg = cfg or load_config()
    ensure_dirs(cfg["paths"]["figs_dir"])
    plt.figure()
    plt.plot(pd.to_datetime(daily_df["order_date"]), daily_df["revenue"])
    plt.title("Daily revenue")
    plt.xlabel("Date")
    plt.ylabel("Revenue")
    plt.tight_layout()
    plt.savefig(f'{cfg["paths"]["figs_dir"]}/daily_revenue.png', dpi=150)
