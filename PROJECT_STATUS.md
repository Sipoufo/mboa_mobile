# Mboa Mobile — Project Status (living doc)

> Working tracker for the Flutter monorepo. Update this at the end of each work
> session. Architecture rules live in `CLAUDE.md`; functional spec in
> `Documents/Claude/Projects/MyHome/Mboa_Doc10_CDC_Fonctionnel.md` (outside repo).
> Last updated: 2026-08-04 (routing rework + Pro homepage M14).

## How to resume
1. Read `CLAUDE.md` (rules) + this file (state).
2. `make bootstrap` if needed; `make analyze` + `make test` must be green.
3. Verify the API: `packages/api_client` is generated (`make gen-api`) — never hand-edit `lib/`.

## Routing architecture (both apps)
Reworked 2026-08-04, modelled on the Zeney project but trimmed to what Mboa needs.

- **Shared plumbing** lives in `mboa_shared/lib/src/routing/`; the *route tables
  stay app-local* because the generated route classes are per-app.
  - `SessionSnapshot` — synchronous `hasSession` boolean the guards read. Holds
    **no token material**; kept warm by the splash (startup) and the app's
    `AuthBloc` (runtime). Guards must never do an async keychain read.
  - `SessionGuard` / `GuestGuard` — take an `onDenied` / `onAuthenticated`
    **callback** so a shared guard never names an app-local route class.
  - `AccessPolicy` — pure `(FeatureKey, AccessContext) -> AccessDecision`. Single
    source of truth for KYC / role / subscription-tier gating (CDC RM-M14-02).
    `AccessContext` uses plain flags, so it doesn't couple to either app's KYC type.
- **Table shape** (both apps): guest routes at the root behind `GuestGuard`;
  everything authenticated nested under `/app` behind `SessionGuard` + the
  `AuthenticatedRouter` wrapper, which owns the session-scoped blocs (profile,
  and KYC on Pro) so the header/gates/settings share one load.
- **Pro tab shell** `ProShellRoute` → Accueil / Gestionnaire / Finance. The
  4th nav slot ("Menu") **pushes `ProMenuRoute` as a modal over the active tab**
  — it is deliberately not a tab. Android back: pop within tab → walk tab
  history → double-press to exit.
- **Transitions are still listener-driven.** The guards make the table correct
  for deep links and back navigation; the `AuthBloc` listener in each app root
  still does the `replaceAll` on login/logout and keeps `SessionSnapshot` and
  `SessionExpiryWatcher` in step. Both mechanisms are needed — don't delete one.
- **`SessionExpiryWatcher`** (`mboa_core`) refreshes the access token *ahead* of
  expiry and forces a clean logout once the refresh token is dead — closing the
  idle-app and resumed-app gaps the interceptor's reactive 401 path can't see.
  Timer-driven; `start()` is idempotent. **No inactivity/PIN lock** (deliberate:
  Zeney needs one because it moves money, Mboa Pro manages listings). The shell
  leaves room to add one as a wrapper later.

## Apps & packages
- `apps/mboa_user` — App Mboa (public; phone-OTP auth).
- `apps/mboa_pro` — App Mboa Pro (prestataires + agents; email/password auth).
- `packages/mboa_core` — DioClient, SecureTokenStorage, HiveCache, Environment, DI locator.
- `packages/mboa_shared` — features shared by both apps (login, session, **profile base**, **media**, **locations**, **settings**).
- `packages/mboa_ui` — design system (theme, Input, Button, cards, AuthScaffold, MboaAvatar, toast, segmented control…).
- `packages/mboa_l10n` — FR/EN ARB → generated `I18n` (`make gen-l10n`).
- `packages/api_client` — generated OpenAPI client.

## API / environment quirks (IMPORTANT)
- **Base URL is origin-only** (`Environment.apiBaseUrl` = `http://localhost:8080`, no `/api/v1`) because the generated paths already include `/api/v1`. If the spec's paths ever drop `/api/v1`, put it back on the base URL.
- **City fields are IDs on update**: profile updates send `searchCityId`/`mainCityId` (not names); responses return both id + display name. Location picker uses `LocationsApi`.
- **KYC status is a free-form string** — parsed defensively by `KycStatusX.parse` (approved/pending/rejected/notSubmitted).
- **Two delete endpoints exist**: we use `DELETE /account` (AccountApi). (`DELETE /users/me` also exists.)
- **KYC submit is atomic**: `{selfieKey, idDocumentFrontKey, idDocumentBackKey}` in one call; selfie is de-facto mandatory (non-nullable).
- **R2 uploads** = presigned PUT (`/media/uploads` → PUT to `uploadUrl`). App needs no R2 write creds; needs `Environment.r2PublicBaseUrl` (placeholder + TODO) to *display* images.

## Auth model
- **User**: phone OTP — `otp/request` → `otp/verify`. Register = login (new number auto-created).
- **Pro**: email/password — login `login` → `login/verify` (email OTP 2FA); register `register/professional` (role+email+password+phone) → phone `otp/verify`.
- OTP resend uses `otp/resend` (phone flows); pro credential-login resend replays `login`.
- Logout revokes refresh server-side (`/auth/logout`, best-effort) then clears local tokens.

## Done
- **M01 auth** — user (phone OTP login/register) + pro (credential login + professional registration). Shared login flow in `mboa_shared`.
- **M02 profile** — Settings hub + Edit Profile, both apps. Base profile unified in `mboa_shared` (generic `ProfileBloc<D,E>`, `BaseProfile`, `BaseProfileRepository`); pro extends with business fields + `ProfileData`/`ProProfileRepository`.
- **M14 Pro home** — header (greeting/location/menu), the three CTA cards
  (Mes biens / Portefeuille / Mes agents), and the "Statistiques Globales" card.
  `HomeBloc` + `ProDashboardRepository`, offline-first over a 5-min Hive cache
  (`dashboardBox`). See the M14 data caveat below.
- **M01bis KYC** (pro) — Certifications (Statut + Identification tabs, status-adaptive), capture→compress→R2 upload→submit; ID-document type picker + front/back.
- **Media** — shared `MediaUploader` (image_picker + flutter_image_compress + presigned PUT) + capture sheet. Profile photo upload wired (both apps).
- **Locations** — shared `LocationRepository` + `showCityPicker`; city pickers in both edit forms.
- **Settings** — language (LocaleController, FR/EN, persisted in Hive `appSettings` box + synced to `/users/me/settings`), change phone (dual-OTP), change password (pro-only), delete account (type-to-confirm, `DELETE /account`). Grouped in `SettingsMenuView` ("Paramètres"); delete tucked at bottom.
- iOS camera/photo Info.plist permissions in **both** apps.
- Role-aware account (`AccountRole`) surfaced in KYC Statut label.

## M14 dashboard — what is real and what is not (IMPORTANT)
The CDC M14 metrics table has **almost no backing API**. Verified against the
generated client: `AnnonceResponse` has no view/contact field, there is no stats
endpoint, and `MeResponse` carries no subscription tier.

| M14 metric | Status |
|---|---|
| Total biens + per-status breakdown | ✅ real — derived from `AnnoncesApi.listMine1` (`totalElements` + page content) |
| Vues, Contacts, Contrats | ❌ no endpoint — render as "Bientôt" (null, never a fabricated 0) |
| Conversion, Visites | ❌ no endpoint **and** tier-gated (Basic+) |
| Position moyenne | ❌ no endpoint **and** tier-gated (Pro+) |
| Subscription tier | ❌ no endpoint — `AccessContext.tier` is hardcoded `gratuit` (TODO in `home_page.dart`) |

Locked metrics get the RM-M14-02 treatment (blurred value + lock + a single
"Passer à Basic+" CTA); unavailable ones say so. When the backend ships the
endpoints, fill `DashboardStats`' nullable fields — the bloc and UI don't change.

**Decided (2026-08-04):** Portefeuille/Finances ships as a placeholder; the stats
card is built against Doc 10's M14 metrics, not the mockup's "Entrées/Sorties".
Not built from the mockup: "Explorez de nouveaux horizons" (no CDC module).

## Pending / next (no blockers unless noted)
- **M10 annonces — next up.** Pro-first: the prestataire must be able to create
  listings before M04/M05 (which are user-app consumption). M10 is also what
  fills "Mes biens" behind the home CTA, which currently dead-ends in
  `AccessRestrictedRoute(comingSoon)`.
- **M04 search, M05 listing detail** — after M10.
- **Agent side (M15 availability, M16 assigned visits/reports)** — BLOCKED: no agent endpoints in `api_client` yet.
- **Password reset** (`auth/password/forgot` + `/reset`) — endpoints exist, not wired.
- **Notifications** — FCM + `NotificationDevicesApi` exist; not wired.
- **Settings extras** — searchable toggle + per-type notification prefs (`user_settings` supports them).
- Messaging (M12), favorites (M06), visits (M07), contract (M08), Mboa Score (M09).

## Tech debt / optimizations to revisit
- **Subscription tier has no API.** `AccessPolicy` gates M14 metrics on
  `SubscriptionTier`, but `MeResponse` carries no tier — `AccessContext.tier`
  defaults to `gratuit` until an endpoint exists. Wire it when M13 lands.
- **The Pro home golden is macOS-rendered.** `test/features/home/ui/goldens/pro_home.png`
  is a real visual check (it caught a grid overflow), but goldens are
  platform-dependent — a Linux CI will need it regenerated or excluded.
  Fonts are loaded via `test/_helpers/load_brand_fonts.dart`; note package fonts
  must be requested as `packages/mboa_ui/<Family>`.
- **Shell integration isn't widget-tested end-to-end** (it needs the full router
  + get_it harness). Covered instead by: route-table assertions
  (`test/app/router/app_router_test.dart`), `ProBottomNav` widget tests, and the
  guard/policy unit tests in `mboa_shared`.
- **No device smoke-test yet** for camera capture, R2 PUT (Content-Type/Length must match presigned signature), city fetch, and the settings round-trips — all need a real device + backend + `R2_PUBLIC_BASE_URL`.
- `updatePhoto` and profile save assume **partial-update** semantics (all-nullable DTOs). If the backend does full-replace, send the full current profile.
- `MboaActionCard` is fixed-height (180) with a hardcoded illustration background (intentional per design).
- Change-phone success doesn't reload the profile (phone isn't shown on the hub) — reload if it becomes visible.
- `dio` is a dev-dep in the apps (test Response fakes); the shared `MediaUploader` uses it as a regular dep.

## Test/analyze status (last run)
- Analyze: **fully clean** (the `stacked_loader_view` info is fixed — `mboa_ui`
  now declares `mboa_l10n`). `make analyze` exits 0.
- Tests: 143 passing — `mboa_user` 14, `mboa_pro` 66, `mboa_core` 12, `mboa_shared` 51.
- `make test` now runs the **package** suites too, not just the two apps, and
  fails the target on the first failing suite.
- Convention: every bloc/cubit + repository has tests (`bloc_test` + `mocktail`); shared doubles in `test/_helpers/mocks`.
