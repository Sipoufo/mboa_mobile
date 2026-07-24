#!/usr/bin/env bash
# Regenerate packages/api_client from the OpenAPI spec (tools/gac).
# Requires: openapi-generator-cli on PATH (npm i -g @openapitools/openapi-generator-cli).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v openapi-generator-cli >/dev/null 2>&1; then
  echo "error: openapi-generator-cli not found on PATH." >&2
  echo "install with: npm install -g @openapitools/openapi-generator-cli" >&2
  exit 1
fi

# openapi-generator overwrites/adds but never prunes files for schemas/ops that
# were removed from the spec. Wipe the generated output first so stale DTOs/APIs
# don't linger. pubspec.yaml / analysis_options.yaml are preserved (they live in
# .openapi-generator-ignore and are not deleted here).
echo "==> cleaning previous generated output"
rm -rf packages/api_client/lib packages/api_client/doc \
       packages/api_client/test packages/api_client/.openapi-generator

echo "==> generating packages/api_client from tools/gac/mboa.openapi.yaml"
openapi-generator-cli generate -c tools/gac/api-client-config.yaml

echo "==> running build_runner inside api_client (built_value serializers)"
( cd packages/api_client && dart pub get && dart run build_runner build --delete-conflicting-outputs )

echo "==> done."
