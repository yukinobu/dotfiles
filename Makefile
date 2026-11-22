PUBLIC_DIR := public
DEV_BRANCH := dotfiles-dev
MAIN_BRANCH := main
GENERATED_BRANCH := generated-main

.DEFAULT_GOAL := help

.PHONY: help publish-main .generate-main .verify-main .check-clean .check-dev-branch

help:
	@echo "Available targets:"
	@echo "  publish-main  public/ から main を生成する（必要なら履歴を巻き戻す）"

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
	@commit=$$(git subtree split --prefix=$(PUBLIC_DIR) $(DEV_BRANCH)) && \
	git branch -f $(GENERATED_BRANCH) "$$commit" && \
	echo "$(GENERATED_BRANCH) -> $$commit"

.verify-main: .generate-main
	@git diff --stat $(MAIN_BRANCH) $(GENERATED_BRANCH)

publish-main: .verify-main
	@push_command="git push origin $(MAIN_BRANCH)"; \
	if ! git merge-base --is-ancestor $(MAIN_BRANCH) $(GENERATED_BRANCH); then \
		push_command="git push --force-with-lease origin $(MAIN_BRANCH)"; \
	fi; \
	git branch -f $(MAIN_BRANCH) $(GENERATED_BRANCH) || exit $$?; \
	echo "必要に応じて $$push_command を実行してください"; \
	echo "必要に応じて git push origin $(DEV_BRANCH) を実行してください"
