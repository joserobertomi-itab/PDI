# Local dev
serve:
	.venv/bin/mkdocs serve

build:
	.venv/bin/mkdocs build

install:
	python3 -m venv .venv
	.venv/bin/pip install -r requirements.txt

# Docker
up:
	docker compose up --build -d

down:
	docker compose down

logs:
	docker compose logs -f

restart:
	docker compose restart
