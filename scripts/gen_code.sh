#!/usr/bin/env bash
# Run build_runner (auto_route routes + json_serializable) for a given app.
# Usage: scripts/gen_code.sh [mboa_user|mboa_pro]   (defaults to both)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

apps=("${1:-mboa_user mboa_pro}")
for app in ${apps[@]}; do
  echo "==> build_runner: apps/$app"
  ( cd "apps/$app" && dart run build_runner build --delete-conflicting-outputs )
done
