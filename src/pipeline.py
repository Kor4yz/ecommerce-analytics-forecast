from pathlib import Path
import pandas as pd
import yaml

def build_dataset(raw_csv: Path, out_orders: Path, out_events: Path|None=None, cfg_path: Path=Path("config.yaml")):
    df = pd.read_csv(raw_csv, parse_dates=["order_ts"])
    df = df[df["status"].eq("paid")]  
    df["is_new_user"] = ~df.sort_values("order_ts").duplicated(subset=["user_id"])

    out_orders.parent.mkdir(parents=True, exist_ok=True)
    df.to_parquet(out_orders, index=False)

    with open(cfg_path, "r", encoding="utf-8") as f:
        cfg = yaml.safe_load(f)

    if out_events:
        ratio = cfg.get("events_ratio", {"session_per_order": 12, "view_per_session": 3, "atc_rate": 0.25, "checkout_rate": 0.7})
        events = []
        for _, row in df.iterrows():
            d = row["order_ts"].normalize()
            channel = row.get("channel", "direct")
            sessions = int(max(1, ratio["session_per_order"]))
            product_views = sessions * ratio["view_per_session"]
            add_to_cart = int(product_views * ratio["atc_rate"])
            checkout = int(add_to_cart * ratio["checkout_rate"])
            events += [
                {"ts": d, "event_type": "session", "channel": channel}       for _ in range(sessions)
            ] + [
                {"ts": d, "event_type": "product_view", "channel": channel}  for _ in range(int(product_views))
            ] + [
                {"ts": d, "event_type": "add_to_cart", "channel": channel}   for _ in range(int(add_to_cart))
            ] + [
                {"ts": d, "event_type": "checkout", "channel": channel}      for _ in range(int(checkout))
            ] + [
                {"ts": row["order_ts"], "event_type": "paid", "channel": channel}
            ]
        ev = pd.DataFrame(events)
        out_events.parent.mkdir(parents=True, exist_ok=True)
        ev.to_parquet(out_events, index=False)
