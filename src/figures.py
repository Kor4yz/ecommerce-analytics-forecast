from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

def make_figures(orders_pq: Path, out_dir: Path):
    out_dir.mkdir(parents=True, exist_ok=True)
    df = pd.read_parquet(orders_pq)
    df["d"] = df["order_ts"].dt.date

    daily = (df.groupby("d")
               .agg(gmv=("revenue","sum"),
                    orders=("order_id","nunique"),
                    buyers=("user_id","nunique"))
               .reset_index())
    daily["aov"] = daily["gmv"] / daily["orders"]

    plt.figure()
    plt.plot(daily["d"], daily["gmv"])
    plt.title("GMV by day")
    plt.savefig(out_dir/"gmv_daily.png", bbox_inches="tight")
    plt.close()

    top_cat = (df.groupby("category")["revenue"]
                 .sum().sort_values(ascending=False).head(10))
    plt.figure()
    top_cat.plot(kind="bar")
    plt.title("GMV by category (Top 10)")
    plt.savefig(out_dir/"gmv_by_category.png", bbox_inches="tight")
    plt.close()
