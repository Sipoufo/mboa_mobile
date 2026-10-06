# Mboa mobile monorepo — common developer & CI commands.
# `make help` lists everything.

.DEFAULT_GOAL := help
SHELL := /bin/bash
APPS := mboa_user mboa_pro
# Packages that carry their own test suites.
TEST_PACKAGES := mboa_core mboa_shared mboa_ui

.PHONY: help bootstrap gen gen-api gen-code gen-l10n analyze format test coverage clean run-user run-pro

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

bootstrap: ## Resolve workspace dependencies (single shared lockfile)
	flutter pub get

gen: gen-api gen-l10n gen-code ## Regenerate everything (api_client + i18n + routes/json)

gen-api: ## Regenerate packages/api_client from the OpenAPI spec
	./scripts/gen_api_client.sh

gen-code: ## Run build_runner (auto_route + json) for both apps
	./scripts/gen_code.sh

gen-l10n: ## Regenerate the shared I18n class from ARB files
	./scripts/gen_l10n.sh

analyze: ## Static analysis across the whole workspace
	flutter analyze

format: ## Auto-format all Dart sources
	dart format --line-length 120 packages apps

test: ## Run unit/bloc tests for both apps and the shared packages
	@set -e; \
	for app in $(APPS); do echo "==> test: apps/$$app"; (cd apps/$$app && flutter test); done; \
	for pkg in $(TEST_PACKAGES); do echo "==> test: packages/$$pkg"; (cd packages/$$pkg && flutter test); done

coverage: ## Run tests with coverage + HTML report
	./scripts/coverage.sh

clean: ## Remove build artifacts
	@for app in $(APPS); do (cd apps/$$app && flutter clean); done

# Build-time secrets (MapTiler, Sentry). Copy env/dev.example.json to
# env/dev.json and fill it in; the file is git-ignored and optional, so a
# checkout with no secrets still runs — the features that need one say so.
ENV_FILE ?= $(CURDIR)/env/dev.json
DEFINES := --dart-define=ENV=dev
ifneq ($(wildcard $(ENV_FILE)),)
DEFINES += --dart-define-from-file=$(ENV_FILE)
endif

# Each environment is a build flavour: its own bundle id, name and icon, so
# dev, staging and production sit side by side on one phone.
FLAVOR ?= dev

run-user: ## Run App Mboa (public) in dev
	cd apps/mboa_user && flutter run --flavor $(FLAVOR) $(DEFINES)

run-pro: ## Run App Mboa Pro in dev
	cd apps/mboa_pro && flutter run --flavor $(FLAVOR) $(DEFINES)
