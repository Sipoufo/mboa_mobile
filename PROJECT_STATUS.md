# Mboa Mobile — Project Status (living doc)

> Working tracker for the Flutter monorepo. **Update it at the end of each work
> session.** Architecture rules live in `CLAUDE.md`; functional spec in
> `~/Documents/Claude/Projects/MyHome/Mboa_Doc10_CDC_Fonctionnel.md` (outside the
> repo). Doc 10 is authoritative for module numbers and RM-IDs — the M-numbers in
> `CLAUDE.md` diverge, ignore those.
>
> Last updated: 2026-08-06.

## How to resume

1. Read `CLAUDE.md` (rules), then this file (state), then
   `docs/backend-requests.md` (API gaps and what is agreed).
2. `make analyze` and `make test` must both be green **before** changing
   anything. `make bootstrap` first if dependencies moved.
3. Native builds are **not** covered by either. After any dependency, Gradle,
   Podfile or plugin change, run a real build — see *Verification* below.
4. `packages/api_client` is generated (`make gen-api`) — never hand-edit `lib/`.

---

## Where things stand

**290 tests green, analyze clean.** `mboa_user` 18 · `mboa_pro` 183 ·
`mboa_core` 12 · `mboa_shared` 77.

| Module | State |
|---|---|
| M01 auth (user phone-OTP, pro credential + 2FA) | ✅ |
| M02 profile & settings (language, phone, password, deletion) | ✅ |
| M01bis KYC / certifications (pro) | ✅ |
| Media upload (compress → R2 presigned PUT) | ✅ |
| Locations (cities, districts, pickers) | ✅ |
| M14 Pro home dashboard | ✅ shell real, **metrics mostly unavailable** |
| M13 subscriptions (plans, MoMo checkout, receipts) | ✅ |
| M03 push notifications | ✅ **Android both apps** · iOS blocked on APNs key |
| M10 listings + residences | ✅ complete for everything the API supports |
| M04 search · M05 detail · M12 messaging | ❌ not started |
| M15/M16 agents | ❌ no endpoints |

**Apps & packages.** `apps/mboa_user` (public) · `apps/mboa_pro` (prestataires +
agents) · `packages/`: `mboa_core` (DioClient, secure storage, Hive, env, DI),
`mboa_shared` (login, session, profile base, media, locations, settings,
notifications, routing guards, `ApiError`), `mboa_ui` (design system),
`mboa_l10n` (FR/EN ARB → generated `I18n`), `api_client` (generated).

---

## Invariants — the things that broke before

Each cost a bug that `flutter analyze` and the bloc tests could not see. They are
pinned by tests; do not "simplify" them away.

### Bloc scoping
`AuthenticatedWrapper` provides the **session-scoped** blocs: `ProProfileBloc`,
`KycCubit`, `SubscriptionBloc`, `HomeBloc`, `AnnoncesBloc`, `ResidencesBloc`.
Anything read by more than one route belongs there. A bloc provided in a single
page's `wrappedRoute` is visible **only to that route and its children** — not to
siblings. This threw `ProviderNotFoundException` twice (Mes biens hub, then
listing detail).

**Rule:** a screen reading a bloc it does not provide itself needs a widget test
pumping it with *only* the blocs its route inherits. See
`screens_provider_scope_test.dart`.

### Route reachability
A route in the table is not proof it is reachable. The profile hub was orphaned
when the tab shell replaced it as the post-auth landing. Pinned by
`pro_menu_page_test.dart`, which greps `lib/` for a navigation source for every
`/app` child.

### Native permissions
A plugin needing a runtime permission fails **only on device**. `geolocator`
shipped without `NSLocationWhenInUseUsageDescription`, and the Android manifests
had no `uses-permission` entries at all. Pinned by
`platform_permissions_test.dart` in both apps, which reads the real `Info.plist`
and `AndroidManifest.xml`.

**Adding a plugin that touches camera, photos, location, notifications or
background execution: add the declaration *and* a line in that test.**

### Design tokens
`colors.background` = page canvas (#FBFBFB) · `colors.surface` = card (#FFFFFF) ·
`colors.surfaceWarm` = card/input **fill only**. Using `surfaceWarm` as a page
background reads visibly grey; it was wrong on every Pro screen once.

### Equatable props must be complete
`bloc` drops an emission whose state compares equal to the current one. A model
with a partial `props` list therefore makes the screen silently not update.

`Residence.props` omitted `units`, so a residence fetched *with* its units
compared equal to the unit-less one from the list and the detail never showed a
unit — a bug that survived two other fixes because the page code was correct
throughout. `Annonce.props` had the same hole. Both now list every field.
Pinned by `residences_detail_test.dart`.

### Listings vs units
`AnnoncesReady.standalone` filters `residenceId == null`. A residence unit can
sit in `items` (fetched for its detail) without appearing in Biens Uniques.
**Read `visible`/`standalone`, never `items`, when showing the list.** A unit
also does **not** consume the active-listing quota — the allowance is enforced at
residence creation, so `PublishGate` gets a null limit for a unit.

---

## API / environment quirks

- **Base URL is origin-only** (`http://localhost:8080`) — generated paths already
  include `/api/v1`.
- **City fields are IDs on update**: `searchCityId` / `mainCityId`.
- **Listings are filed against a district**, not a city
  (`CreateAnnonceRequest.districtId`), and `latitude`/`longitude` are required.
- **Error codes live in `error`**, not `code`. All 63 are in
  `api/docs/api-error-codes.md`. `message` is prose and gets reworded — never
  branch on it. `VALIDATION_ERROR` carries a `fields` array.
- **Timestamps are ISO-8601 UTC.** Pagination envelope is
  `{content, page, size, totalElements, totalPages, last}` — do not read
  `pageable.pageNumber` or `numberOfElements`.
- **Send `Idempotency-Key`** on `POST /subscriptions`. The server generates a
  random one when absent, so a double-tap creates two payments. `SubscribeBloc`
  mints one per purchase and reuses it on retry.
- **Generated operation ids are unstable** — `listMine1` → `listMine2` once broke
  the build. The backend agreed to pin explicit `operationId`s; until then expect
  churn on every regen.
- **R2 needs `Environment.r2PublicBaseUrl`** to display images (placeholder + TODO).

## Auth model
- **User**: phone OTP — `otp/request` → `otp/verify`. Register = login.
- **Pro**: email/password — `login` → `login/verify` (email OTP 2FA); register
  `register/professional` → phone `otp/verify`.
- Logout revokes the refresh token server-side and **deregisters the push device
  first** — both are authenticated calls, so the order is load-bearing and tested.
- `SessionExpiryWatcher` (mboa_core) refreshes ahead of expiry and forces a clean
  logout when the refresh token dies. No inactivity/PIN lock (deliberate).

---

## Module notes worth reading before touching

### M14 dashboard — mostly empty by necessity
Only the total-listings count and per-status breakdown are real (derived from the
listings page). Views, contacts, conversion, visits, contracts and ranking **have
no source data** — the backend confirmed the events are not captured anywhere.
They land with M05 (views/contacts), M08, M16, M04.

`DashboardStats` models them nullable and the UI renders "Bientôt". The backend
explicitly endorsed this over fabricating zeroes. Tier-gated metrics show the
RM-M14-02 blur + upgrade CTA, which *is* real behaviour.

### M13 payments
- Confirmation is webhook-driven. `SubscribeBloc` polls
  `GET /subscriptions/payments/{id}` — **not** the plan, because the tier cannot
  distinguish `FAILED` from "not yet". Gives up after 90s into a
  "you'll be notified" state rather than the 15 minutes RM-M13-05 allows.
- Push fires on settlement (confirmed *and* failed), ending the wait when the app
  is backgrounded.
- Receipts come from `GET /subscriptions/payments`; `hasReceipt` decides whether
  the download affordance is drawn at all.
- An unknown or failed plan read resolves **down** to Gratuit, never up.

### M10 listings
- Photos: **min 3, max 15** (Doc 10). The mockup's "5 photos" is wrong.
  `INSUFFICIENT_PHOTOS` is enforced server-side at publish too.
- **Enregistrer saves a draft.** Publishing is separate, because only publishing
  hits the tier limit and the photo minimum.
- Drafts appear under *Disponibles* with a badge; archived have their own tab.
- **Un-archiving is its own endpoint** (`POST /annonces/{id}/unarchive` → DRAFT).
  `publish` rejects anything but DRAFT with a 409 — an earlier "Republier" button
  calling `publish` was broken in a shipped build.
- `PublishGate` is a pure function over (profile complete, photo count, active
  count, tier limit). It reports the profile blocker first — the one the
  prestataire can act on.
- **Location flow:** GPS fix → reverse geocode to a city → preselect it → load
  *that city's* districts → pick one. `matchCity` is deliberately loose (accents,
  casing, "Douala 5e") and **may return null**; the city is always confirmable by
  hand. It records where the *phone* is, not the property — a MapLibre picker is
  the real fix and replaces only `LocationCapture`.
- A unit id **is** an annonce id, so unit rows open the ordinary detail and edit
  form.
- Surfaces with no endpoint (Attributions, Réservations, Prospections, En attente
  de validation, Historique, Occupant) route to `AccessRestrictedPage(comingSoon)`
  rather than being hidden — the hub is the product's map.

---

## Open decisions (product, not code)

1. **Doc 10 has no Bien Multiple section.** Residences are fully shipped — bulk
   lifecycle, per-residence quota, `residenceUnitAllowance` — against a CDC that
   describes single listings only. No RM-IDs to cite, nothing to validate
   against. The backend flagged this as the most consequential item on either
   list.
2. **`residenceUnitAllowance` is not in Doc 10** — the name was invented in the
   backend. Shown on the plans screen as "N unités de résidence".
3. **Water/electricity metering** — the designs show "Compteur Prépayé" on a
   listing card, but Doc 10 does not define it. The backend will add it once it
   is in the CDC. See `docs/openapi-proposal-m10-fields.md`.
4. **Photos: 3 vs 5** — Doc 10 says 3, the mockup says 5. Built as 3.
5. **French wording for residences** — English says "Residences", French keeps the
   design's "Biens Multiples".

---

## Pending / next

- **`expiresAt` countdown** — mapped onto `Annonce`, unused in the UI. Free-tier
  listings expire at J+30 (RM-M10-04); the field gives the countdown for free.
  Smallest useful next task.
- **M12 messaging** — live on the backend, entirely unbuilt. Constraints from
  their handover: `ConversationResponse.readOnly` must disable the composer;
  phone numbers are masked server-side both directions (RM-M12-03) so **no call
  affordance anywhere**; attachments are **object keys, not URLs**, max 3, images
  only, via the `MESSAGE_ATTACHMENT` upload category; `POST /conversations` is
  **USER role only** (a prestataire gets 403); a double-tapped "Contact" returns
  409 `CONSTRAINT_VIOLATION` — retry to get the existing thread.
- **M04 search / M05 listing detail** — the user-app side.
- **iOS push** — blocked only on the APNs key. Everything else is done.
- Password reset (`auth/password/forgot` + `/reset`) — endpoints exist, unwired.
- Settings extras: searchable toggle, per-type notification preferences.
- Agent side (M15/M16), favourites (M06), visits (M07), contract (M08),
  Mboa Score (M09).

---

## Tech debt

- **Nothing has been run on a device or simulator.** Every claim here is from
  tests, analyze and native builds — not from the app running. Simulator install
  kept failing with CoreSimulator 405; a physical device may be easier. The
  broken "Republier" button is exactly the class of bug this misses.
- **Deep-link routing** handles `PAYMENT_CONFIRMED` and `KYC`;
  `MESSAGE`/`ANNONCE`/`VISIT` land on the shell until those modules exist.
- **Goldens are macOS-rendered** (`home/ui/goldens/`, `subscription/ui/goldens/`,
  `annonces/ui/goldens/`). They have caught real bugs — an overflowing metric
  grid, unformatted prices, a `1 annonces` plural — but a Linux CI will need them
  regenerated or excluded.
- `url_launcher` is unwired: tapping a receipt surfaces the URL in a toast.
- `sentry_flutter` had to go 8.x → 9.x to unbreak the Android build (Kotlin 1.6
  vs the 2.x compiler). Nothing caught it because nothing ran an Android build.
- **CocoaPods on this Mac needs a UTF-8 locale**: prefix `pod` with
  `LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8` or it dies on ASCII-8BIT normalisation.
- A stale `ios/Podfile.lock` reports as a *deployment-target* error. It is not —
  delete the lock and `pod install --repo-update`.
- The CocoaPods "base configuration … Pods-Runner.profile" warning is **benign**;
  Flutter points Profile at `Release.xcconfig`. Verified. Don't "fix" it.
- `updatePhoto` and profile save assume partial-update semantics.
- `MboaActionCard` is fixed-height (180) with a hardcoded illustration background.

---

## Verification

| Check | Command | Catches |
|---|---|---|
| Static | `make analyze` | types, lints, unused |
| Unit/widget | `make test` | logic, bloc states, provider scoping, layout overflow |
| Android | `flutter build apk --debug` (per app) | Gradle, manifest, plugin conflicts |
| iOS | `flutter build ios --debug --simulator` (per app) | Podfile, plist, target membership |

**Analyze and test cannot see native breakage.** Three separate failures reached
the user that way: the Kotlin/Sentry build break, the missing location
permission, and `POST_NOTIFICATIONS` missing (a green build that would never have
prompted on Android 13+).

Last run: all four green, 290 tests, both APKs and both iOS simulator builds OK,
`mboa_pro` also builds `--profile`.
