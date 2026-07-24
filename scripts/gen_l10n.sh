#!/usr/bin/env bash
# Regenerate the shared I18n class from the ARB files in packages/mboa_l10n.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/packages/mboa_l10n"

echo "==> generating I18n (intl_utils) from lib/l10n/*.arb"
dart run intl_utils:generate
echo "==> done."
