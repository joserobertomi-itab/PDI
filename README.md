# PDI - Processamento Digital de Imagens

Resumos para prova de PDI organizados por seção, servidos via MkDocs com o tema Material.

## Requisitos

- Python 3.12+
- Docker + Docker Compose (opcional)

## Início Rápido

### Local

```bash
make install   # cria .venv e instala dependências
make serve     # sobe o servidor em http://localhost:8000
```

### Docker

```bash
make up        # build + start em http://localhost:8000
make down      # para o container
make logs      # acompanha os logs
make restart   # reinicia o container
```

## Comandos Disponíveis

| Comando | Descrição |
|---|---|
| `make install` | Cria o venv e instala deps do `requirements.txt` |
| `make serve` | Dev server local em `http://127.0.0.1:8000` |
| `make build` | Gera o site estático em `./site` |
| `make up` | Sobe via Docker Compose |
| `make down` | Para o container |
| `make logs` | Tail dos logs do container |
| `make restart` | Reinicia o container |

## Estrutura

```
PDI/
├── docs/
│   ├── index.md
│   ├── section-2/
│   ├── section-3/
│   ├── section-4/
│   ├── section-5/
│   └── section-9/
├── mkdocs.yml
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
└── Makefile
```

## Seções Cobertas

- **Seção 2:** 2.4
- **Seção 3:** 3 até 3.7
- **Seção 4:** 4.1, 4.7, 4.8, 4.9, 4.10
- **Seção 5:** 5.3, 5.4
- **Seção 9:** 9 até 9.3
