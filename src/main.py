import argparse
from pathlib import Path
from src.pipeline import build_dataset
from src.figures import make_figures
from src.forecast import train_and_export

def parse_args():
    ap = argparse.ArgumentParser()
    ap.add_argument("--build-data", action="store_true")
    ap.add_argument("--make-figures", action="store_true")
    ap.add_argument("--forecast", action="store_true")
    return ap.parse_args()

def main():
    args = parse_args()
    data_raw = Path("data/transactions_sample_head.csv")
    data_clean = Path("artifacts/clean.parquet")
    out_dir = Path("docs/png")
    out_dir.mkdir(parents=True, exist_ok=True)

    if args.build_data:
        build_dataset(data_raw, data_clean)
    if args.make_figures:
        make_figures(data_clean, out_dir)
    if args.forecast:
        train_and_export(data_clean, Path("artifacts/forecast.csv"))

if __name__ == "__main__":
    main()
