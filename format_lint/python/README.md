## Ruff

- install

```bash
source format_lint/python/setup.sh
# or
source format_lint/python/venv/bin/activate
```

- execution

```bash
ruff check
ruff check --fix
ruff format
ruff check --select E501 --add-noqa .
```


## pre-commit

- install

```bash
pip install pre-commit
pre-commit install
```

- execution

```bash
pre-commit run --all-files
```
