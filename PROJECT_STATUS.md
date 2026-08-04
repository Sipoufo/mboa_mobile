# Mboa Mobile — Project Status (living doc)

> Working tracker for the Flutter monorepo. Update this at the end of each work
> session. Architecture rules live in `CLAUDE.md`; functional spec in
> `Documents/Claude/Projects/MyHome/Mboa_Doc10_CDC_Fonctionnel.md` (outside repo).
> Last updated: 2026-07 (settings section complete).

## How to resume
1. Read `CLAUDE.md` (rules) + this file (state).
2. `make bootstrap` if needed; `make analyze` + `make test` must be green.
3. Verify the API: `packages/api_client` is generated (`make gen-api`) — never hand-edit `lib/`.

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
- **M01bis KYC** (pro) — Certifications (Statut + Identification tabs, status-adaptive), capture→compress→R2 upload→submit; ID-document type picker + front/back.
- **Media** — shared `MediaUploader` (image_picker + flutter_image_compress + presigned PUT) + capture sheet. Profile photo upload wired (both apps).
- **Locations** — shared `LocationRepository` + `showCityPicker`; city pickers in both edit forms.
- **Settings** — language (LocaleController, FR/EN, persisted in Hive `appSettings` box + synced to `/users/me/settings`), change phone (dual-OTP), change password (pro-only), delete account (type-to-confirm, `DELETE /account`). Grouped in `SettingsMenuView` ("Paramètres"); delete tucked at bottom.
- iOS camera/photo Info.plist permissions in **both** apps.
- Role-aware account (`AccountRole`) surfaced in KYC Statut label.

## Pending / next (no blockers unless noted)
- **Core product modules** — M04 search, M05 listing detail, M10 annonces (new `AnnoncesApi`, `AnnonceResponse`, `CreateAnnonceRequest` exist).
- **Agent side (M15 availability, M16 assigned visits/reports)** — BLOCKED: no agent endpoints in `api_client` yet.
- **Password reset** (`auth/password/forgot` + `/reset`) — endpoints exist, not wired.
- **Notifications** — FCM + `NotificationDevicesApi` exist; not wired.
- **Settings extras** — searchable toggle + per-type notification prefs (`user_settings` supports them).
- Messaging (M12), favorites (M06), visits (M07), contract (M08), Mboa Score (M09).

## Tech debt / optimizations to revisit
- **Pre-existing analyze info**: `packages/mboa_ui/.../stacked_loader_view.dart` imports `mboa_l10n` without declaring the dep. Harmless; declare the dep or inject the string to clear it.
- **No device smoke-test yet** for camera capture, R2 PUT (Content-Type/Length must match presigned signature), city fetch, and the settings round-trips — all need a real device + backend + `R2_PUBLIC_BASE_URL`.
- `updatePhoto` and profile save assume **partial-update** semantics (all-nullable DTOs). If the backend does full-replace, send the full current profile.
- `MboaActionCard` is fixed-height (180) with a hardcoded illustration background (intentional per design).
- Change-phone success doesn't reload the profile (phone isn't shown on the hub) — reload if it becomes visible.
- `dio` is a dev-dep in the apps (test Response fakes); the shared `MediaUploader` uses it as a regular dep.

## Test/analyze status (last run)
- Analyze: clean except the one pre-existing `stacked_loader_view` info.
- Tests: `mboa_shared` 34, `mboa_user` 14, `mboa_pro` 29, `mboa_core` 6 — all passing.
- Convention: every bloc/cubit + repository has tests (`bloc_test` + `mocktail`); shared doubles in `test/_helpers/mocks`.
