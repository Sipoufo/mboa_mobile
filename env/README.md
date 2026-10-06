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
| `MAP_STYLE_URL` | A whole style URL that replaces the MapTiler one — the route to self-hosted PMTiles (Doc 13 §8). **Leave it empty unless you mean it**; the key alone is enough. | MapTiler's `streets-v2` is used |

A style URL copied from MapTiler's catalogue carries no `key=` (the key is on
another page) and is answered with 403, so `MAPTILER_KEY` is appended to a
MapTiler override that has none. A style served from anywhere else is used
exactly as written — a self-hosted one has no MapTiler key to add.
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

## Build flavours

`dev`, `staging` and `production` are real build flavours, not just a
`--dart-define`: each has its own bundle id, name and app icon, so the three
builds live side by side on one phone.

| Flavour | Name (tenant / pro) | Icon ground | Bundle id suffix |
|---------|--------------------|-------------|------------------|
| `dev` | Mboa Dev / Mboa Pro Dev | Quasi-Noir `#1A1A1A` | `.dev` |
| `staging` | Mboa Staging / Mboa Pro Stg | Corail `#E8735A` | `.staging` |
| `production` | Mboa / Mboa Pro | Vert Forêt `#1A5C45` | — |

```bash
make run-user                    # dev, the default
make run-user FLAVOR=staging
cd apps/mboa_user && flutter build ipa --flavor production --dart-define=ENV=production
```

The ground colour is what tells them apart, rather than a "DEV" ribbon: at
60pt a ribbon's text is about eight pixels tall and unreadable, and rendering
type would mean carrying a font rasteriser for six letters. The word itself
lives in the app's name, where it is always legible.

**Android needs one thing from you first.** The flavours suffix the
application id, and `google-services.json` only knows the two production ids:

```
cm.mboa.mboa_user      cm.mboa.mboa_pro
```

Register these four in the Firebase console and re-download the file into
`apps/<app>/android/app/`, or `dev` and `staging` Android builds fail with
"No matching client found for package name":

```
cm.mboa.mboa_user.dev       cm.mboa.mboa_user.staging
cm.mboa.mboa_pro.dev        cm.mboa.mboa_pro.staging
```

iOS has no equivalent constraint — it is already building and running.
