# Mboa mobile monorepo — common developer & CI commands.
# `make help` lists everything.

.DEFAULT_GOAL := help
SHELL := /bin/bash
APPS := mboa_user mboa_pro

.PHONY: help bootstrap gen gen-api gen-code analyze format test coverage clean run-user run-pro

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

bootstrap: ## Resolve workspace dependencies (single shared lockfile)
	flutter pub get

gen: gen-api gen-code ## Regenerate everything (api_client + routes/json)

gen-api: ## Regenerate packages/api_client from the OpenAPI spec
	./scripts/gen_api_client.sh

gen-code: ## Run build_runner (auto_route + json) for both apps
	./scripts/gen_code.sh

analyze: ## Static analysis across the whole workspace
	flutter analyze

format: ## Auto-format all Dart sources
	dart format --line-length 120 packages apps

test: ## Run unit/bloc tests for both apps
	@for app in $(APPS); do echo "==> test: apps/$$app"; (cd apps/$$app && flutter test); done

coverage: ## Run tests with coverage + HTML report
	./scripts/coverage.sh

clean: ## Remove build artifacts
	@for app in $(APPS); do (cd apps/$$app && flutter clean); done

run-user: ## Run App Mboa (public) in dev
	cd apps/mboa_user && flutter run --dart-define=ENV=dev

run-pro: ## Run App Mboa Pro in dev
	cd apps/mboa_pro && flutter run --dart-define=ENV=dev
