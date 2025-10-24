.PHONY: setup lint test report

setup:
\tpython -m venv .venv && . .venv/bin/activate && pip install -U pip && pip install -r requirements.txt

lint:
\truff check src && black --check src

fix:
\tblack src && ruff check --fix src

test:
\tpytest -q

report:
\tpython -m src.io --build && python -m src.viz --export
