PUBLIC_DIR := public
DEV_BRANCH := dotfiles-dev
MAIN_BRANCH := main
GENERATED_BRANCH := generated-main

.DEFAULT_GOAL := help

.PHONY: help publish-main .generate-main .verify-main .check-clean .check-dev-branch

help:
	@echo "Available targets:"
	@echo "  publish-main  public/ から main を生成して fast-forward する"

.check-clean:
	@test -z "$$(git status --porcelain)" || { \
		git status --short; \
		echo "作業ツリーが clean ではありません"; \
		exit 1; \
	}

.check-dev-branch:
	@test "$$(git branch --show-current)" = "$(DEV_BRANCH)" || { \
		echo "$(DEV_BRANCH) ブランチで実行してください"; \
		exit 1; \
	}

.generate-main: .check-clean .check-dev-branch
	@commit=$$(git subtree split --prefix=$(PUBLIC_DIR) $(DEV_BRANCH)); \
	git branch -f $(GENERATED_BRANCH) $$commit; \
	echo "$(GENERATED_BRANCH) -> $$commit"

.verify-main: .generate-main
	@git diff --stat $(MAIN_BRANCH) $(GENERATED_BRANCH); \
	if git merge-base --is-ancestor $(MAIN_BRANCH) $(GENERATED_BRANCH); then \
		echo "$(MAIN_BRANCH) は $(GENERATED_BRANCH) へ fast-forward 可能です"; \
	else \
		echo "$(MAIN_BRANCH) は $(GENERATED_BRANCH) へ fast-forward できません"; \
		exit 1; \
	fi

publish-main: .verify-main
	@current=$$(git branch --show-current); \
	git switch $(MAIN_BRANCH); \
	git merge --ff-only $(GENERATED_BRANCH); \
	git switch $$current; \
	echo "必要に応じて git push origin $(MAIN_BRANCH) $(DEV_BRANCH) を実行してください"
