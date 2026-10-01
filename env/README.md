# Build-time secrets

Nothing in here with a real value is committed. `--dart-define-from-file`
reads one of these JSON files at build time and the values land in
`Environment` (`mboa_core`), which is the only place the app reads them from
— never a constant in the source (CLAUDE.md).

```bash
cp env/dev.example.json env/dev.json   # then fill it in; dev.json is ignored
make run-user                          # picks up env/dev.json when it exists
```

| Key | Where it comes from | Without it |
|-----|--------------------|-----------|
| `MAPTILER_KEY` | MapTiler Cloud → **Keys** → the default key, or a new one | The map view says the key is missing and offers the list |
| `MAP_STYLE_URL` | A whole style URL that replaces the MapTiler one — the route to self-hosted PMTiles (Doc 13 §8). Leave empty unless you mean it. | MapTiler's `streets-v2` is used |
| `SENTRY_DSN` | Sentry project settings → Client Keys (DSN) | Crash reporting stays off |

To see the map without a key at all, MapLibre's public demo style works — a
plain world map, enough to check the markers land where they should:

```bash
cd apps/mboa_user && flutter run --dart-define=ENV=dev \
  --dart-define=MAP_STYLE_URL=https://demotiles.maplibre.org/style.json
```

`ENV` picks the API base URL (`dev` / `staging` / `production`) and is also
passed on the command line, so the file can leave it out.

Staging and production builds pass their own file (`env/staging.json`,
`env/production.json`) or plain `--dart-define` flags from CI — the same keys,
never checked in.
