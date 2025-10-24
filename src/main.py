import argparse
from pathlib import Path
from prepare_data import build_dataset
from figures import make_figures
from forecast import train_and_save

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--build-data", action="store_true")
    ap.add_argument("--make-figures", action="store_true")
    ap.add_argument("--forecast", action="store_true")
    args = ap.parse_args()

    if args.build_data:
        build_dataset(Path("data/raw.csv"), Path("data/clean.parquet"))
    if args.make_figures:
        make_figures(Path("data/clean.parquet"), Path("docs/png"))
    if args.forecast:
        train_and_save(Path("data/clean.parquet"), Path("artifacts/forecast.csv"))

if __name__ == "__main__":
    main()
