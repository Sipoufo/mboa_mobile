# Mboa Mobile — Flutter Monorepo

Offline-first Flutter monorepo for Mboa's two mobile products, built on a strict
BLoC architecture with secure token handling. See `CLAUDE.md` for the full
engineering rulebook.

## Layout

```
mobile/
├── packages/
│   ├── mboa_core/     Shared: DioClient + AuthInterceptor, secure storage,
│   │                  Hive cache, get_it locator, env constants, Sentry observer
│   └── api_client/    GENERATED typed API (openapi-generator, dart-dio)
├── apps/
│   ├── mboa_user/     App Mboa — general public. Reference Auth/OTP feature.
│   └── mboa_pro/      App Mboa Pro — providers & agents (skeleton shell)
├── tools/gac/         OpenAPI spec + generator config for api_client
└── scripts/           gen / coverage helpers (wrapped by the Makefile)
```

A single **Dart pub workspace** (`resolution: workspace`) shares one lockfile so
`mboa_core` / `api_client` versions never drift between apps.

## Tech decisions

| Concern      | Choice                                             |
|--------------|----------------------------------------------------|
| State        | flutter_bloc 9 (sealed events/states)              |
| Navigation   | auto_route (codegen)                               |
| DI           | get_it service locator                            |
| API          | generated `api_client` from OpenAPI (dart-dio)     |
| Auth/security| JWT in `flutter_secure_storage` only; 401 auto-refresh in `AuthInterceptor` |
| Offline      | `hive_ce` cache (TTL policy in `StorageKeys`)      |
| Feature shape| `feature/{bloc,data,models,ui}` per CLAUDE.md      |

## Getting started

```bash
make bootstrap     # flutter pub get (whole workspace)
make gen           # regenerate api_client + auto_route/json
make analyze       # static analysis (must be clean)
make test          # unit/bloc tests
make run-user      # run App Mboa (dev)
make run-pro       # run App Mboa Pro (dev)
```

Run `make help` for the full command list.

## The Auth/OTP reference feature

`apps/mboa_user/lib/features/auth/` is the copy-paste template for new modules.
It demonstrates every mandated pattern: sealed BLoC, a repository as the sole
network layer, tokens written only to secure storage, side-effects in
`BlocListener`, and full BLoC + repository tests. Clone its shape (`bloc/ data/
models/ ui/`) for M01, M05, and the rest.

## Regenerating the API client

The typed client is generated from `tools/gac/mboa.openapi.yaml`. Replace that
seed spec with the canonical export from the Spring Boot backend, then:

```bash
make gen-api
```
