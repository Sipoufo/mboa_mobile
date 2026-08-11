# Mboa Mobile — Project Status (living doc)

> Working tracker for the Flutter monorepo. **Update it at the end of each work
> session.** Architecture rules live in `CLAUDE.md`; functional spec in
> `~/Documents/Claude/Projects/MyHome/Mboa_Doc10_CDC_Fonctionnel.md` (outside the
> repo). Doc 10 is authoritative for module numbers and RM-IDs — the M-numbers in
> `CLAUDE.md` diverge, ignore those.
>
> Last updated: 2026-08-11.

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

**436 tests green, analyze clean.** `mboa_user` 18 · `mboa_pro` 326 ·
`mboa_core` 12 · `mboa_shared` 77.

| Module | State |
|---|---|
| M01 auth (user phone-OTP, pro credential + 2FA) | ✅ |
| M02 profile & settings (language, phone, password, deletion) | ✅ |
| M01bis KYC / certifications (pro) | ✅ |
| Media upload (compress → R2 presigned PUT) | ✅ |
| Locations (cities, districts, pickers) | ✅ |
| M14 Pro home dashboard | ✅ shell real, **views now real, 5 metrics still unsourced** |
| M13 subscriptions (plans, MoMo checkout, receipts) | ✅ |
| M03 push notifications | ✅ **Android both apps** · iOS blocked on APNs key |
| M10 listings + residences | ✅ complete for everything the API supports |
| M04 search · M05 detail · M12 messaging | ❌ not started |
| M15 agent profile, zones, availability | ✅ shell + screens |
| M11 assignments | ✅ both sides — offer, apply, accept, decline, resign |
| M16 agent visits | ❌ endpoints exist, no screens |

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

### Two personas, one entry point
`/app` opens on `RoleGateRoute`, **not** on a shell. The login response carries
tokens and nothing else — only `/me` reports the role — so for a moment after
signing in the app genuinely does not know who it is talking to. Opening on the
prestataire shell and correcting a beat later showed an agent someone else's
dashboard, which was reported from a device.

`SessionSnapshot.role` is **nullable on purpose**: null means "not known yet",
and defaulting it to `user` would route an agent wrongly rather than make the
gate wait. On resume the role is already there (the startup check calls `/me`
anyway) and the gate costs one frame; after a fresh sign-in it waits for the
profile, showing the app's own loader.

Pinned by `app_router_test.dart` — neither shell may be the landing route.

### Route reachability
A route in the table is not proof it is reachable. The profile hub was orphaned
when the tab shell replaced it as the post-auth landing. Pinned by
`pro_menu_page_test.dart`, which greps `lib/` for a navigation source for every
`/app` child.

**That check is role-blind, and a second persona broke it.** It passes as long as
*some* file navigates to a route — the prestataire's slide menu reaches settings,
certifications and logout, so all three looked reachable while an **agent**,
whose shell has no slide menu, could sign in and never sign out. The same test
now has a per-persona group that greps only `lib/features/agent`.

**Rule:** a new shell needs its own reachability group, from its own entry
point. Logout first — it is the only way out of the app.

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
- **Operation ids are now stable and explicit** (2026-08-11 export): every one is
  named for what it does — `listMyAnnonces`, `getMyResidence`,
  `unarchiveResidenceUnits`, `updateMyPrestataireProfile`. The old generated
  names (`listMine2`, `getOne1`, `publishAll`) are gone; adding an endpoint no
  longer renumbers its neighbours. This closed `backend-requests.md` §9.
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
Total listings, the per-status breakdown and **views** are real; views are summed
from `AnnonceResponse.viewCount`, which the 2026-08-11 spec added. Like the
status breakdown, the sum covers **one page** of listings, so a portfolio past
100 undercounts. It stays **null — not 0 — when no listing carries the field**,
so an older backend renders "Bientôt" rather than claiming nobody has looked.

Contacts, conversion, visits, contracts and ranking still **have no source
data**. They land with M12/M05, M08, M16, M04.

`DashboardStats` models them nullable and the UI renders "Bientôt". The backend
explicitly endorsed this over fabricating zeroes. Tier-gated metrics show the
RM-M14-02 blur + upgrade CTA, which *is* real behaviour.

### M02 profile — one identity record per role
**Whose record is authoritative depends on the role, and writing the wrong one
is silent.** `ProProfileRepository` branches three ways:

| Role | Identity lives on | Avatar |
|---|---|---|
| prestataire | `/prestataires/me` | `logoObjectKey` |
| **agent** | **`/agents/me`** — its own name and photo | `photoObjectKey` there |
| user | `/users/me` | `photoObjectKey` |

An agent's record is created **empty** on first read, with nothing copied from
`/users/me`, so the base profile is not secondary for them — it is unrelated.
`profileComplete` and the prestataire-facing `AgentCandidate` card both read the
agent record. Writing `/users/me` showed the agent their new photo while leaving
them unassignable. Pinned by `pro_profile_photo_test.dart`.

### M02 profile — three routes, and the Pro avatar is the logo
The Pro profile loads `GET /me` (account: phone, email, role), `GET /users/me`
(the *person*: names, searchCity, `photoObjectKey`) and `GET /prestataires/me`
(the *business*: displayName, `logoObjectKey`, type, mainCity, `profileComplete`).
All three are needed — a prestataire account **is** a user account with a
business profile attached, and the Pro edit form writes names back to
`/users/me`. The three calls are sequential; `Future.wait` would save a round
trip.

- **The avatar is `logoObjectKey`, falling back to `photoObjectKey`** — read it
  through `ProfileData.avatarUrl`, never `photoUrl`. `logoObjectKey` was loaded
  and never displayed or written for a while, so the logo could not be set at
  all. Agents have no business profile and keep the personal photo.
- **`updatePhoto` re-sends displayName / type / mainCityId** with the key.
  Partial-update semantics on `/prestataires/me` are an *assumption*; omitting
  them would wipe the business profile to set an avatar. Pinned by
  `pro_profile_photo_test.dart`.
- **RM-M10-01 completeness is the server's** `profileComplete`, via
  `ProfileData.isProfileComplete` — it is what `publish` enforces. A **null**
  flag falls back to the local three-part check on purpose: treating it as
  `false` would block every publish in the app.

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
- **Un-archiving is its own endpoint** (`POST /annonces/{id}/unarchive` → DRAFT,
  and `POST /residences/{id}/unarchive` → `unarchiveAll` for a residence).
  `publish` rejects anything but DRAFT with a 409 — an earlier "Republier" button
  calling `publish` was broken in a shipped build. The residence side then
  reported *"Action impossible pour le moment."* for a second reason: the
  repository still threw `UnsupportedError`, written when `ResidencesApi` really
  had only the four bulk transitions. Pinned by `residence_repository_test.dart`.
- **A bulk transition answers with the aggregate shape** — counts, `units`
  empty by design (backend-requests §2). Writing that response straight into the
  list empties the detail screen's unit list, so `ResidencesBloc` refetches with
  `getOne` when it was holding units. Carrying the old units forward instead
  would show pre-transition status chips. Pinned by
  `residences_transition_test.dart`.
- `PublishGate` is a pure function over (profile complete, photo count, active
  count, tier limit). It reports the profile blocker first — the one the
  prestataire can act on.
- **Per-field help** (`FieldHelp`, mboa_ui): an info icon by the label opens a
  bottom sheet — not a tooltip, which needs a long-press on touch and advertises
  nothing. Copy comes from Doc 10 and each ARB entry cites its source in
  `@description`; keep that when editing. It is deliberately **not** on every
  field — an icon everywhere becomes wallpaper. The 44×44 tap target makes a
  helped label row ~24px taller, which is enough to push later fields out of a
  default 800×600 test viewport (see `screens_provider_scope_test.dart`).
- **Amenities are single-listing only.** `Amenity` is Doc 10's "Équipements"
  checklist as a closed enum of six. `CreateResidenceRequest` and `UnitGroup`
  have **no** amenities field, so the form hides the checklist for a Bien
  Multiple — a residence cannot declare equipment at all. Worth raising: Doc 10
  §M10bis says units share the residence's characteristics, so equipment is a
  natural shared attribute. Unticking everything sends an **empty set**, not
  null, or clearing the checklist would silently be a no-op.
  **Search still cannot filter on amenities**, which was the whole reason for
  making it a closed enum (`backend-requests.md` §8) — chase this.
- **Residence detail filters units client-side.** `getMyResidence` takes no
  status or search parameter, and `ResidenceResponse.units` already carries each
  unit's status — so the tabs and the search box are pure view state in the page,
  not bloc state and not a request. Deliberate: RM-M10bis-01 caps a residence at
  200 units, small enough that filtering in the widget is correct and paging via
  `GET /annonces?residenceId=` would be more requests for data already held.
  Tabs reuse `AnnonceFilter` (available = published + draft · occupied =
  reserved + rented · archived), so the residence and the Biens Uniques list
  cannot drift apart. The search box only appears above 6 units.
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

### M15 agents — a second persona in the same app
An agent gets **their own shell** (`AgentShellRoute`: Visites / Missions /
Profil), not role checks inside the prestataire one — Accueil, Gestionnaire and
Finance are about listings and subscriptions an agent does not have. A signed-in
agent is redirected there by the role listener in `AuthenticatedWrapper`, because
the role only arrives with the profile, after the first frame. Visites and
Missions have endpoints but no screens; they show the coming-soon page.

- **`/agents/me` is a separate record from `/users/me`**, with its own name and
  photo. The server's `profileComplete` is firstName && lastName &&
  photoObjectKey && ≥1 zone, all read from the *agent* record, and the
  prestataire's `AgentCandidate` card reads the agent photo too. Write the base
  profile instead and the agent looks complete in the app while being
  unassignable on the server.
- **A zone is either a whole city or one district, never a pair** — the backend
  builds them with `ofCity`/`ofDistrict`, leaving the other id null. Modelled as
  a sealed pair so "both set" cannot exist. An update with both lists empty is
  rejected, so the picker keeps the save button disabled until something is
  chosen.
- **Availability times had no documented format.** The field is a Java
  `LocalTime`, so it emits `"08:00"` or `"08:00:30"` and accepts any ISO local
  time. `TimeCodec` parses leniently and always writes `HH:mm:ss`. Pinned by
  `availability_test.dart` — a wrong format means no agent can be booked.
- **Days off save on tap**, not behind the form: blocking one cancels the visits
  already booked that day (RM-M15-03). The weekly pattern is a draft PUT as a
  whole, since a rule left out is a rule deleted.
- `AgentProfileBloc` is provided by `AuthenticatedWrapper`, not the agent shell —
  the zones screen is a *sibling* of the shell, and a bloc provided by one route
  is invisible to its siblings.

### M11 — the designs describe a different feature
`screenshots/pro/agents/` shows **staff with permissions**: job titles, a Droits
tab (Finance / Agents / Locataires), invitation by affiliation link, a global
directory, and agent contact details. Doc 10 §M11 is **assigning a certified
agent to one listing so a tenant can book a visit** (RM-M07-01). The app builds
M11; the visual language is reused, the absent concepts are not invented. Logged
in `docs/backend-requests.md` §11.

- **One active agent per property** (RM-M11-01), so the candidate picker hides
  while somebody holds the property *or* is being waited on — two people
  believing they have it is the failure to avoid.
- **Accepting an application auto-declines the others** server-side (RM-M11-07),
  so every mutation reloads rather than patching state locally.
- **A residence offer reports what it skipped** (RM-M10bis-06). Swallowing
  `skipped[]` would claim the whole residence was offered when part was not.
- **Origin is recorded, never a filter** (RM-M11-09): an agent's accepted
  application and a prestataire's accepted offer are the same thing afterwards.
- Mes agents lists **people**, not assignments — an agent on four properties is
  one row.
- **The agent's Missions tab keys off status, not origin.** `offers` is
  `pending` (the prestataire is waiting on *them*); an `applied` row is the
  agent's own application, which belongs under their own missions with a
  withdraw action. Confusing the two would ask the agent to accept something
  they already asked for.
- **The listing endpoints key on the assignment id, the residence ones on the
  residence id.** `AgentMissionRepository` picks; no screen or bloc branches on
  it.

## Open decisions (product, not code)

> **Doc 10 moved on 2026-08-09** and closed the first three. Re-read §M10bis
> before assuming anything below is still open.

1. ~~Doc 10 has no Bien Multiple section~~ — **§M10bis now exists**, explicitly
   documenting "une fonctionnalité déjà construite avant d'être spécifiée".
   RM-M10bis-01…11 cover the 200-unit cap, the quota model, the bulk lifecycle
   (including *désarchiver*) and residence-level agent assignment.
2. ~~`residenceUnitAllowance` is not in Doc 10~~ — **specified in RM-M10bis-02**:
   a residence counts as one active listing, and the tier caps units per
   residence separately.
3. **Water/electricity metering** — still undefined in Doc 10; the designs show
   "Compteur Prépayé". See `docs/openapi-proposal-m10-fields.md`.
4. ~~Photos: 3 vs 5~~ — **Doc 10 confirms min 3, max 15**. Built correctly.
5. **French wording for residences** — English says "Residences", French keeps the
   design's "Biens Multiples".

### RM-M10-09 — rent and its period ✅

A listing carries a **`price`** and a **`rentalPeriod`**, wired through the form,
the models and the repositories.

**The enum is `DAY`/`WEEK`/`MONTH`/`QUARTER`/`YEAR` — and Doc 10 says otherwise.**
RM-M10-09 states in as many words that there is *no* weekly or nightly period
because short-term letting is a distinct product. The API added `DAY` and `WEEK`
regardless and the app supports both, but the CDC has not been updated: short-term
letting has no rules of its own there — no contract terms, no tier treatment, no
search brackets. **Product decision outstanding.**

Every wire value is mapped explicitly and the fallback is reserved for a value a
build predates. Mapping an unrecognised value onto month is not harmless: a
listing at 5 000 F/day would read "5 000 XAF / Mois". Pinned by
`rental_period_test.dart`.

**`monthlyRent` is the server's derived comparison figure — never display it and
never send it.** It exists so listings can be filtered and sorted against each
other (900 000 F/year and 75 000 F/month fall in the same bracket); it is not
what anyone pays and never reaches the Contrat Mboa. It stayed on the model only
because listings created before the rule have nothing else, which is what
`Annonce.displayPrice` (`price ?? monthlyRent`) is for — and those really were
monthly, so `RentalPeriod.fallback` reads correctly for them.

Sending `monthlyRent` on create still *compiles* — the field is still in the
request DTO — it just records a figure nobody pays and leaves the real price
null. Pinned by `annonce_price_test.dart`, which asserts what reaches the wire.

Each residence unit **group** carries its own period: a hotel room may be let
monthly while a shop in the same building is let yearly.

Doc 10's RM-M10-01 still words the profile requirement as "photo + type + ville";
the API models a prestataire's image as `logoObjectKey`, and the app treats those
as the same thing.

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
