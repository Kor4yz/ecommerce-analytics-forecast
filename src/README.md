python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
python -m src.main --build-data --make-figures --forecast
