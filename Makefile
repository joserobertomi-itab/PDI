serve:
	.venv/bin/mkdocs serve

build:
	.venv/bin/mkdocs build

install:
	python3 -m venv .venv
	.venv/bin/pip install -r requirements.txt
