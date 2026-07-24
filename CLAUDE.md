# Project: Mboa Flutter — Mobile Applications

> Flutter monorepo for Mboa's mobile apps — App Mboa (general public) + App Mboa Pro (service providers & agents).
> Flutter 3.x / Dart 3.x, BLoC architecture, offline-first.
> Architecture reference: `Doc 12`, technical choices: `Doc 13`, functional spec: `Doc 10`.

Guiding principle: **offline-first, token security, strict BLoC** — the UI never knows the API directly, tokens never leave secure storage, and each feature is a self-contained BLoC.

---

# Tech Stack

| Component | Package | Version | Role |
|-----------|---------|---------|------|
| Framework | Flutter | 3.x (stable) | iOS + Android mobile SDK |
| Language | Dart | 3.x | Null safety, strong typing |
| State management | flutter_bloc | 9.x | Predictable and testable state management |
| Dependency injection | get_it | 8.x | Service locator — repositories/blocs registered per app |
| Navigation | auto_route | 9.x | Declarative typed routes + guards (code-generated) |
| HTTP client | dio | 5.x | JWT interceptor + auto-refresh on 401 |
| Generated API | api_client | (generated) | Typed client from OpenAPI (openapi-generator `dart-dio` + built_value) |
| Secure storage | flutter_secure_storage | 9.x | JWT tokens (Keychain iOS / EncryptedSharedPreferences Android) |
| Offline cache | hive_ce | 2.x | Listings, favorites, pending messages |
| Value equality | equatable | 2.x | Sealed Events/States + domain models |
| Crash reporting | sentry_flutter | 8.x | Error reporting + global `BlocObserver` breadcrumbs |
| Connectivity | connectivity_plus | 6.x | Online/offline detection for the cache strategy |
| Codegen | build_runner | 2.x | Drives auto_route + built_value generators |
| Maps | maplibre_gl | 0.x | OpenStreetMap, MapTiler vector tiles *(planned, Doc 13)* |
| Push notifications | firebase_messaging | 14.x | FCM foreground + background + terminated *(planned)* |
| Media picker | image_picker | 1.x | Gallery + camera *(planned)* |
| Media compression | flutter_image_compress | 2.x | JPEG 85%, max 1920×1080 *(planned)* |
| Geolocation | geolocator | 11.x | GPS position, 500m radius check (agents) *(planned)* |
| Network images | cached_network_image | 3.x | HTTP cache for Cloudflare R2 images |
| Internationalization | intl | 0.19.x | Date / currency formatting (FCFA) |
| Testing | bloc_test + mocktail | — | BLoC state assertions + mock repositories/clients |

> Rows marked *(planned)* are the target stack from Doc 13; they are not wired
> into the scaffold yet — add them to the relevant app's `pubspec.yaml` when the
> module that needs them is built.

---

# Project Structure

## Monorepo

A single **Dart pub workspace** (`resolution: workspace` in every member,
`workspace:` list in the root `pubspec.yaml`) resolves one shared lockfile so
`mboa_core` / `api_client` versions never drift between the two apps.

```
mobile/
├── pubspec.yaml                  # workspace root (workspace: members list)
├── analysis_options.yaml         # strict lints — inherited by every package
├── Makefile                      # bootstrap / gen / analyze / test / run
├── scripts/                      # gen_api_client.sh, gen_code.sh, coverage.sh
├── tools/gac/                    # OpenAPI spec + openapi-generator config
│   ├── mboa.openapi.yaml         # seed spec (replace with backend export)
│   └── api-client-config.yaml
│
├── packages/
│   ├── api_client/               # GENERATED typed client — never edit lib/ by hand
│   │
│   └── mboa_core/                # Shared, hand-written
│       └── lib/src/
│           ├── api/              # DioClient + interceptors/AuthInterceptor
│           ├── storage/          # SecureTokenStorage + HiveCache
│           ├── di/               # get_it locator (registerCoreModule)
│           ├── network/          # NetworkMonitor (connectivity)
│           ├── observability/    # SentryBlocObserver
│           ├── constants/        # Environment (envs), StorageKeys, CacheTtl
│           └── models/           # cross-app domain models (AuthTokens…)
│
└── apps/
    ├── mboa_user/                # App Mboa (general public — tenants, sellers)
    │   ├── lib/
    │   │   ├── main.dart
    │   │   ├── app/              # root widget, router/ (auto_route), theme/, di/
    │   │   └── features/         # See feature structure below
    │   └── pubspec.yaml          # depends on mboa_core (path)
    │
    └── mboa_pro/                 # App Mboa Pro (service providers + agents)
        ├── lib/{main.dart, app/, features/}
        └── pubspec.yaml          # depends on mboa_core (path)
```

## BLoC Feature Structure

Every feature strictly follows this folder layout:

```
features/
└── auth/
    ├── bloc/
    │   ├── auth_bloc.dart        # BLoC — handles Events, emits States
    │   ├── auth_event.dart       # Events (sealed class, part of auth_bloc.dart)
    │   └── auth_state.dart       # States (sealed class, part of auth_bloc.dart)
    ├── data/
    │   └── auth_repository.dart   # Drives the generated api_client via DioClient
    ├── models/
    │   └── otp_session.dart      # Domain model (maps from generated DTOs)
    └── ui/
        ├── auth_page.dart        # BlocBuilder / BlocConsumer, @RoutePage()
        └── widgets/              # Page sub-components
```

> **Absolute rule:** `ui/` files **never** make direct API calls. They dispatch
> Events to the BLoC. The Repository is the only layer that speaks to the API
> (`DioClient` → generated `api_client`).
>
> `apps/mboa_user/lib/features/auth/` is the **reference vertical slice** — clone
> its shape for every new module (M01, M05…).

---

# Architecture — Mandatory Patterns

## BLoC Pattern

```
UI (Page/Widget)
  │   dispatch(Event)
  ▼
BLoC
  │   calls Repository (injected via get_it)
  ▼
Repository
  │   calls DioClient.api  (generated api_client, mboa_core)
  ▼
REST API  (com.mboa.api)
```

- **Events**: user actions or system triggers (e.g. `AuthOtpRequested`, `AuthOtpSubmitted`).
- **States**: observable page states (e.g. `AuthInProgress`, `AuthAuthenticated`, `AuthFailure`).
- Use **sealed classes** for Events and States (with `equatable`) — guarantees exhaustive `switch` coverage.
- One BLoC per feature — do not share a BLoC across unrelated features (except the global `AuthBloc`).

## Dependency Injection (get_it)

- The shared locator lives in `mboa_core` (`getIt`, `registerCoreModule`).
- Startup order in each app's `main.dart`: `HiveCache.init()` → `registerCoreModule(onSessionExpired: …)` → app-specific `registerAppModule()`.
- `registerCoreModule` registers `SecureTokenStorage`, `HiveCache`, `NetworkMonitor`, `DioClient`.
- Repositories are `registerLazySingleton`; the global `AuthBloc` is a singleton. Feature Blocs are created via `BlocProvider(create: (_) => getIt<XBloc>())`.

## Generated API Client (api_client)

- `packages/api_client` is generated by `openapi-generator` (`dart-dio`, built_value) from `tools/gac/mboa.openapi.yaml`.
- Regenerate with `make gen-api`. **Never hand-edit `packages/api_client/lib/`** — changes belong in the OpenAPI spec.
- Its `pubspec.yaml` and `analysis_options.yaml` are protected from regeneration via `.openapi-generator-ignore`.
- Repositories reach it through `DioClient.api.getXApi()` — never construct `ApiClient`/`Dio` in a repository.

## JWT Interceptor (mboa_core)

`AuthInterceptor` (a `QueuedInterceptor` in `mboa_core/src/api/interceptors/`) centralizes all auth:

1. Injects `Authorization: Bearer <access>` into every request.
2. On 401 (non-auth endpoint, not already retried) → calls the refresher (`/auth/refresh`) via a bare Dio.
   - **Success** → persists new tokens to `SecureTokenStorage` + replays the original request.
   - **Failure** → clears tokens + invokes the app's `onSessionExpired` hook (dispatches `AuthLogoutRequested` on the global `AuthBloc` → root listener routes back to login).

Never handle 401 manually in Repositories — the interceptor centralizes everything. Refresh replays go through a separate bare Dio to avoid recursing through the interceptor.

## Navigation (auto_route)

- Each app owns an `AppRouter` (`@AutoRouterConfig()`) in `lib/app/router/`; routes are generated into `app_router.gr.dart` (`make gen-code`).
- Screens are annotated with `@RoutePage()`.
- Session-based redirection is driven by the root `AuthBloc` listener (replaces the stack on authenticate/logout) — the route table stays declarative and guard-free.
- Side effects (navigation, snackbars) happen in `BlocListener`/`BlocConsumer`, never in a builder.

## Observability

- `SentryBlocObserver` (`mboa_core`) is set as the global `Bloc.observer` in `main.dart`, leaving breadcrumbs on every state transition and reporting uncaught BLoC errors.
- Sentry only initializes when `SENTRY_DSN` is provided via `--dart-define`.

## Offline Strategy (Hive cache)

| Data | Cache duration | Hive box |
|------|---------------|----------|
| Last 20 viewed listings | 24 hours | `viewedBox` |
| Last 20 search results | 1 hour | `searchBox` |
| Favorites | Permanent (until deleted) | `favoritesBox` |
| Unsent messages | Until confirmed sent | `pendingMessagesBox` |

Box names and TTLs are centralized in `mboa_core` (`StorageKeys`, `CacheTtl`). The app checks the cache first, fires the network request in the background, then updates the cache and UI upon response. In offline mode (via `NetworkMonitor`), it shows cached data with an "Offline data" banner.

---

# Conventions

## Dart / Flutter Naming

| Element | Convention | Example |
|---------|-----------|---------|
| Classes | `PascalCase` | `AuthBloc`, `AuthPage` |
| Variables / methods | `camelCase` | `isLoading`, `requestOtp()` |
| Files | `snake_case` | `auth_bloc.dart`, `auth_page.dart` |
| Constants | `camelCase` / `kPrefix` | `sentryDsn`, `viewedBox` |
| BLoC Events | `PascalCase` + `Event` suffix | `AuthOtpRequested`, `AuthLogoutRequested` |
| BLoC States | `PascalCase` + `State` suffix | `AuthAuthenticated`, `AuthFailure` |

## Media

- Compression is mandatory before any upload: **JPEG 85%, max resolution 1920×1080**, target 200–500 KB.
- Video: **MP4 H.264, 720p**.
- Upload via **Cloudflare R2 pre-signed URL** — never through the Spring Boot API as a transit layer.

## Maps

- **MapLibre GL + MapTiler** (OpenStreetMap) — never Google Maps.
- Vector tiles: free up to 100,000 requests/month.

## Authentication

- Supported methods: **SMS OTP** + **Google** + **Apple** + **Facebook Login**.
- Apple Login is **mandatory** for any iOS app with social login (App Store rules).
- Tokens stored **exclusively** via `flutter_secure_storage` — no other method.

## Geolocation

- Agents can only submit a visit report if their GPS position is within a **500m radius** of the visited property — client-side check via `geolocator`, confirmed server-side.

---

# Environments

| Env | API URL | Usage |
|-----|---------|-------|
| `dev` | `http://localhost:8080/api/v1` | Local development (local backend) |
| `staging` | `https://staging.api.mboa.cm/api/v1` | Integration tests + QA |
| `production` | `https://api.mboa.cm/api/v1` | Real users |

Environment selection is handled by `Environment` in `mboa_core/lib/src/constants/environment.dart`, resolved once from `--dart-define=ENV=<env>` (defaults to `dev`). Never use `if (kDebugMode)` conditionals in Repositories.

No API key, URL, or secret may be hardcoded in the source code — use `mboa_core` constants (`Environment`) only. Secrets (Sentry DSN, etc.) are injected via `--dart-define`.

---

# Commands

Most workflows are wrapped in the root `Makefile` (`make help` lists all).

## Setup & Codegen

```bash
make bootstrap          # flutter pub get for the whole workspace
make gen                # regenerate everything (api_client + auto_route/json)
make gen-api            # regenerate packages/api_client from the OpenAPI spec
make gen-code           # build_runner (auto_route + json) for both apps
```

## Run

```bash
make run-user           # App Mboa (public) — dev
make run-pro            # App Mboa Pro — dev

# Or directly:
cd apps/mboa_user && flutter run --dart-define=ENV=dev
cd apps/mboa_pro  && flutter run --dart-define=ENV=dev

# On a specific device
flutter run -d <device_id> --dart-define=ENV=dev
```

## Build

```bash
# Android APK (staging)
flutter build apk --dart-define=ENV=staging --release

# Android App Bundle (production — Google Play)
flutter build appbundle --dart-define=ENV=production --release

# iOS IPA (production — App Store)
flutter build ipa --dart-define=ENV=production --release
```

Run build/run commands from inside the target app directory (`apps/mboa_user` or `apps/mboa_pro`).

## Tests

```bash
make test               # unit/bloc tests for both apps
make coverage           # tests with coverage + HTML report

# A specific BLoC
cd apps/mboa_user && flutter test test/features/auth/bloc/auth_bloc_test.dart
```

## Quality & Analysis

```bash
make analyze            # flutter analyze across the workspace (must be clean)
make format             # dart format (line length 120)
flutter pub outdated    # check for outdated dependencies
```

## Cache & Cleanup

```bash
make clean              # flutter clean for both apps
make bootstrap          # reinstall dependencies
# Clear Hive cache in dev → uninstall and reinstall the app on the emulator
```

---

# Project Rules

## 1. Plan Before Coding

- Before any new feature, identify: the functional module (M01, M05…), the target app (`mboa_user` / `mboa_pro` / both), the API endpoints called, and the required offline states.
- Present the BLoC structure (Events + States + Repository calls) and **wait for explicit approval** before writing code.
- If the feature calls new endpoints, add them to `tools/gac/mboa.openapi.yaml` and run `make gen-api` before writing the repository.

## 2. BLoC Discipline

- **One BLoC per feature**, no exceptions — no business logic in a Widget.
- Any Widget that displays data must be a `BlocBuilder` or `BlocConsumer`. Zero `setState` for API-sourced data.
- Side effects (navigation, snackbar, dialog) are handled in `BlocListener`, never in the builder.
- BLoCs communicate via their respective Events, never by direct reference.

## 3. Offline-First is Mandatory

- Every feature that consumes network data must implement its Hive cache policy per the table in the Architecture section.
- The app must be usable (even partially) without a connection — show cache with a visual indicator, never a blank screen or crash.

## 4. Token Security

- JWT tokens (access + refresh) live **only** in `flutter_secure_storage` (via `SecureTokenStorage`).
- The `AuthInterceptor` (mboa_core) is the only entity that reads and writes tokens after login.
- On refresh token failure, the interceptor triggers a clean logout via the app's `onSessionExpired` hook and redirects to login via `AuthBloc`.

## 5. Always Test

- Each BLoC is covered by unit tests (states emitted in response to events, with a mock Repository via `bloc_test` + `mocktail`).
- Repositories are tested with a mock `DioClient` / generated API.
- Shared test doubles live in `test/_helpers/{mocks,builders,fixtures}`.
- Convention: `features/auth/bloc/auth_bloc_test.dart` mirroring the source structure.
- No feature shipped without a BLoC test.

## 6. Media — Always Compress

- `flutter_image_compress` is called **before** any pre-signed URL request.
- Never upload an uncompressed image, regardless of source (gallery or camera).

## 7. Autonomous Bug Fixing

- When facing an error (crash, assertion, incorrect render), identify which layer it originates from (UI, BLoC, Repository, DioClient) before fixing.
- Fix autonomously, write a regression test, document cause + fix in the commit message.

## 8. Self-Improvement

- After each feature, identify opportunities: widget extractions, missing golden tests, list performance (ListView.builder vs Column).
- Suggest updates to this file — never modify it autonomously.

---

# Prohibitions

- **NEVER** store JWT tokens anywhere other than `flutter_secure_storage` (not SharedPreferences, not Hive, not a global variable).
- **NEVER** call `DioClient` or the generated `api_client` directly from a Widget or BLoC — go through the Repository.
- **NEVER** hand-edit `packages/api_client/lib/` — change the OpenAPI spec and run `make gen-api`.
- **NEVER** write business logic in a Widget (even a `StatefulWidget`) — that's the BLoC's job.
- **NEVER** hardcode an API URL or API key in the source code — `mboa_core` `Environment` + `--dart-define` only.
- **NEVER** upload an image without compressing it via `flutter_image_compress` (JPEG 85%, max 1920×1080).
- **NEVER** use Google Maps — MapLibre GL + MapTiler only (OpenStreetMap, per Doc 13).
- **NEVER** disable `flutter analyze` to pass a build — fix the warnings. Do not add a per-app `analysis_options.yaml` that weakens the strict root config.
- **NEVER** use `setState` for API-sourced data — BLoC only.
- **NEVER** create a BLoC that manages multiple unrelated features.
- **NEVER** access `BuildContext` outside the widget tree (except inside a `BlocListener` callback).
- **NEVER** ignore a refresh token failure — always trigger a clean logout.
- **NEVER** commit member-package lockfiles — the workspace commits only the root `pubspec.lock`.
