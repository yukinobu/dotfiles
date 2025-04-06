PYTHON_MANIFESTS := $(shell find . -type f -iname 'requirements*.txt')

.venv:
	python3 -m venv .venv
	touch .venv

.PHONY: devenv
devenv: .venv
	@for mfile in $(PYTHON_MANIFESTS); do \
		.venv/bin/pip install -r $$mfile; \
	done
