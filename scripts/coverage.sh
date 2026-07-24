#!/usr/bin/env bash
# Run tests with coverage for every app and render an HTML report.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

for app in mboa_user mboa_pro; do
  echo "==> coverage: apps/$app"
  ( cd "apps/$app" && flutter test --coverage )
  if command -v genhtml >/dev/null 2>&1; then
    genhtml "apps/$app/coverage/lcov.info" -o "apps/$app/coverage/html" >/dev/null
    echo "    report: apps/$app/coverage/html/index.html"
  else
    echo "    (install lcov/genhtml for the HTML report)"
  fi
done
