ifdef OS
	ifeq ($(OS),Windows_NT)
		PYTHON := .venv/Scripts/python.exe
	else
		PYTHON := .venv/bin/python3
	endif
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		PYTHON := .venv/bin/python3
	else ifeq ($(UNAME_S),Darwin)
		PYTHON := .venv/bin/python3
	else
		PYTHON := .venv/Scripts/python.exe
	endif
endif

PYTHON_MANIFESTS := $(shell find . -type f -iname 'requirements*.txt')

.venv:
	python3 -m venv .venv
	touch .venv

.PHONY: devenv
devenv: .venv
	@for mfile in $(PYTHON_MANIFESTS); do \
		$(PYTHON) -m pip install -U -r $$mfile; \
	done
