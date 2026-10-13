# Backend requests — mobile

> **Answered 2026-08-05** — see `api/backend-response.md`. Status per item is
> marked inline below. Items 1–5 and 7 are resolved on the backend; the mobile
> side of 2 and 3 is **waiting on an updated `mboa.openapi.yaml` export**, which
> has not arrived in this repo yet (`tools/gac/mboa.openapi.yaml` still predates
> the change: no `residenceId`, no `ErrorResponse`).

Everything the Flutter apps need from the Spring Boot API, with the symptom each
one causes today and the workaround currently shipped.

Nothing here blocks the apps — every item has a workaround in place. But each
workaround costs something: an extra request, a guessed contract, or a feature
that stays disabled. They are ordered by that cost.

> Written 2026-08-05 against the `api_client` generated from
> `tools/gac/mboa.openapi.yaml`. All file paths are in the mobile repo.

---

## 1. Document the error responses — ✅ DONE

**Outcome:** `api/docs/api-error-codes.md` lists all 63 codes. The machine code
is in **`error`**, not `code`. Our parser already read `error` (it was last in
the fallback list), but **the guessed code *names* were wrong on three rows of
four** — now corrected against the real list. Never invent these again.

The spec declares **no error schema at all**, only success responses. So the app
cannot know what a failure means.

The only code we have seen in the wild is `RESIDENCE_UNIT_LIMIT`, reported from
a device. Everything else is inferred.

**Symptom:** a failed save said *"Enregistrement impossible. Réessayez."*
regardless of cause — including when the real reason was "your plan doesn't
allow that many units", which the prestataire could have acted on.

**Workaround:** `ApiError.from` (`packages/mboa_shared/lib/src/api/api_error.dart`)
parses defensively across the plausible shapes — `code` / `errorCode` /
`error_code`, `message` / `detail`, and bare strings — and never throws. Known
codes are mapped to written messages in `annonce_form_page.dart`. The mapping is
**a guess**:

| Code the app looks for | Guessed meaning |
|---|---|
| `RESIDENCE_UNIT_LIMIT` | tier does not allow that many units *(confirmed)* |
| `LISTING_LIMIT` / `ANNONCE_LIMIT` / `ACTIVE_LISTING_LIMIT` | active-listing cap reached |
| `PROFILE_INCOMPLETE` | RM-M10-01 not satisfied |
| `KYC_REQUIRED` | certifications not approved |

**Ask:** add an error schema to the spec and list the codes. Something like:

```yaml
ApiErrorResponse:
  type: object
  properties:
    code: { type: string }      # stable, machine-readable
    message: { type: string }   # human-readable, already localised or not
    field: { type: string }     # optional, for validation failures
  required: [code]
```

…referenced from the `4xx` responses of at least `POST /annonces`,
`POST /residences`, `POST /subscriptions` and the lifecycle transitions.

**Note:** the app deliberately ignores Spring's default `{"error": "Bad Request"}`
because the reason phrase is not a machine code. If the default handler is left
in place for some routes, those failures stay generic.

---

## 2. Link a listing to its residence — ✅ DONE, mobile blocked on the spec export

**Outcome:** `AnnonceResponse.residenceId` shipped (null = standalone), plus
`expiresAt` for the RM-M10-04 countdown. The empty `units` on the residences
list is deliberate (aggregate count query), not a bug.
**To do here once the spec lands:** regenerate, filter on `residenceId == null`,
and delete the N+1 subtraction in `AnnonceRepository`.

`GET /api/v1/annonces` returns **every** listing the prestataire owns, including
the units a residence expanded into. `AnnonceResponse` carries no residence
reference, so there is no way to tell a standalone listing from a unit.

**Symptom:** the "Biens Uniques" screen listed residence units alongside
standalone properties.

**Workaround:** `AnnonceRepository.list()` collects unit ids from
`GET /residences` and subtracts them. Worse, the residences *list* payload does
not reliably populate `units`, so any residence reporting `unitCount > 0` with
an empty `units` array is fetched individually — **N+1 requests, bounded by the
residence count**. If the whole lookup fails, the unfiltered list is returned:
extra rows beat an empty screen.

**Ask — either would do:**
- add `residenceId: string | null` to `AnnonceResponse`; or
- add a query parameter, e.g. `GET /annonces?standalone=true`.

The first is more useful — it also lets a listing screen link back to its parent.

---

## 3. Is a residence unit id also an annonce id? — ✅ YES

**Outcome:** confirmed end to end; `getOne`/`update`/`publish` work on a unit
today, no API change. Per-unit view/edit is unblocked. Two caveats: publishing a
unit **skips** the active-listing quota (enforced at residence creation), and
`DELETE /annonces/{unitId}` removes a unit from its residence unguarded.

`ResidenceResponse.units` returns `UnitSummary { id, title, propertyType,
status, monthlyRent }`. There is no `GET /residences/{id}/units/{unitId}`, no
per-unit update, and `ResidencesApi` exposes only the **bulk** transitions
(`publishAll`, `reserveAll`, `rentAll`, `archiveAll`).

**Symptom:** a prestataire can create a residence and then never change one of
its units — not the rent, not the status.

**Workaround:** the residence detail lists units **read-only** and says
*"La modification d'une unité arrivera prochainement."*

**Ask:** just tell us whether `UnitSummary.id` is an annonce id.
- **If yes:** `AnnoncesApi.getOne1` / `update1` / `publish` already work on it,
  and per-unit view/edit is roughly half a day of client work. No API change.
- **If no:** we need `GET`/`PATCH /residences/{id}/units/{unitId}` and per-unit
  lifecycle transitions.

---

## 4. List a prestataire's payments — ✅ DONE

**Outcome:** `GET /subscriptions/payments`, paginated, with `hasReceipt` so the
download can be shown or hidden without a probe call.
**To do here:** delete the Hive `subscriptionBox` cache and the device-local
caveat once the spec lands.

`POST /subscriptions` returns `paymentId` **once**. `GET /subscriptions/payments/{id}/receipt`
needs that id, and there is no endpoint listing past payments.

**Symptom:** RM-M13-07 says receipts are accessible from the profile. They are —
but only on the device and in the install that made the payment.

**Workaround:** payments are cached in Hive (`subscriptionBox`). Lost on
reinstall, invisible on a second device, and the UI says so
(*"Les reçus sont liés à cet appareil pour le moment."*).

**Ask:** `GET /api/v1/subscriptions/payments` returning at least
`{ paymentId, tier, amount, status, paidAt }`, paginated. The local cache is
then deleted.

---

## 5. Payment status, or push on confirmation — ✅ BOTH DONE

**Outcome:** `GET /subscriptions/payments/{id}` is the source of truth — poll it
instead of `mySubscription()`, since it distinguishes `FAILED` from "not yet".
Push now fires on settlement (confirmed *and* failed) with
`{type: PAYMENT_CONFIRMED, entityId: <paymentId>}`.

**Their correction, and it matters:** `POST /subscriptions` has always accepted
`Idempotency-Key`, but **the server generates a random one when the header is
absent** — so a double-tap without it creates two payments. We do send it
(`SubscribeBloc` mints one per purchase and reuses it on retry), so we are safe.

`POST /subscriptions` returns `PENDING`. Confirmation arrives by webhook, and
there is no endpoint to ask about a payment's status. The only observable is
`GET /subscriptions/me` eventually reporting a different tier.

**Symptom:** after paying, the app can only poll and hope.

**Workaround:** `SubscribeBloc` polls `mySubscription()` every 3s for 90s, then
hands off to *"you'll receive a notification once your plan is active"* —
rather than spinning for the 15 minutes RM-M13-05 allows.

**Ask — either:**
- `GET /api/v1/subscriptions/payments/{id}` returning the current status; or
- a push notification on confirmation (see §7 — the payload contract).

The second is better: it closes the loop even if the app was backgrounded.

---

## 6. Dashboard metrics (M14) — ❌ NOT POSSIBLE YET

**Outcome:** an aggregate endpoint would not help — the events are not captured.
Contacts are available now (M12 shipped); views need RM-M05-06 (M05), and the
rest arrive with M08/M16/M04. They explicitly endorsed keeping the nullable
model with "Bientôt" rather than fabricating zeroes.

Doc 10 §M14 specifies views, contacts, conversion rate, agent visits, signed
contracts and average ranking. **None of them exist in the API.**
`AnnonceResponse` has no view or contact field and there is no stats endpoint.

**Symptom:** the Pro home dashboard shows one real figure (total properties,
derived from the listings page) and five reading *"Bientôt"*.

**Workaround:** `DashboardStats` models them as nullable, and the UI renders
*"Bientôt"* rather than a fabricated `0`. Tier-gated metrics show the
RM-M14-02 blur + upgrade CTA, which is real behaviour.

**Ask:** an aggregate endpoint, e.g.
`GET /api/v1/prestataires/me/stats?period=7d` returning views, contacts,
conversion, visits, contracts and ranking. Filling the nullable fields needs no
UI change.

---

## 7. Notification payload contract — ✅ DONE

**Outcome:** every push previously carried *only* `deepLink` — no `type`, no
`entityId` — which is exactly why taps landed on the shell. Now fixed, with the
five type names we proposed, and a test pinning the wire keys.

FCM works end to end on Android in both apps. What is missing is agreement on
what a notification *says*.

**Symptom:** CA-M03-02 requires a tap to open the screen the notification is
about. Without a known payload, every tap lands on the home shell.

**Workaround:** `PushMessage.fromData` parses leniently — it accepts `entityId`,
`entity_id` or `id`, matches type substrings, and degrades unknown types to the
shell instead of dropping the notification.

**Ask:** fix the data payload, and keep it stable:

```json
{ "type": "PAYMENT_CONFIRMED", "entityId": "<uuid>" }
```

Types the apps can already route: `PAYMENT_CONFIRMED`, `MESSAGE`, `ANNONCE`,
`VISIT`, `KYC`.

---

## 8. M10 listing fields

**Priority: low — see the dedicated proposal.**

Full detail with YAML in [`openapi-proposal-m10-fields.md`](openapi-proposal-m10-fields.md).
Summary:

- **`amenities`** ✅ — shipped in the 2026-08-11 export as a closed enum of six
  (`AIR_CONDITIONING`, `HOT_WATER`, `GENERATOR`, `SECURITY_GUARD`, `PARKING`,
  `WIFI`), wired into the listing form and detail. **Two gaps remain:**
  `GET /search` does not accept an amenities filter, which was the entire
  argument for the closed enum; and neither `CreateResidenceRequest` nor
  `UnitGroup` carries the field, so a residence cannot declare equipment.
- **`waterMetering` / `electricityMetering`** — not in Doc 10, but the Biens
  Uniques card in the designs displays "Compteur Prépayé", so it is real data.

Two further mockup fields are **recommended against**: a property title deed
belongs with KYC rather than a public listing, and a price period contradicts
Doc 10's monthly-rent model.

Also flagged there: `photoKeys.minItems` is `0` while Doc 10 and CE-M10-03
require 3. If the intent is "drafts may have none, publish requires 3", that
rule should live in `POST /annonces/{id}/publish` and be enforced server-side —
the app cannot be the only thing checking.

---

## 9. Smaller things

| Item | Why |
|---|---|
| **Operation ids are unstable** ✅ | **Resolved in the 2026-08-11 export.** Every operation now carries an explicit, descriptive `operationId` (`listMyAnnonces`, `unarchiveResidenceUnits`, `updateMyPrestataireProfile`…). Adding an endpoint no longer renumbers its neighbours. The one-off cost was renaming 69 call sites across 21 files. |
| **Un-archiving** ✅ | **Resolved.** `POST /annonces/{id}/unarchive` and `POST /residences/{id}/unarchive` (`unarchiveAll`, RM-M10-08) both ship and both are wired; they return the item to `DRAFT` so re-publishing re-checks the tier quota and the 3-photo rule. The residence path lagged the listing one — the repository still threw client-side after the endpoint landed — and reported the generic *"Action impossible pour le moment."* |
| **Subscription tier on `/me`** | `MeResponse` has no tier, so the app makes a second call to `GET /subscriptions/me` on every session start purely to know what to gate. |
| **No `residenceUnitAllowance` docs** | `TierInfo.residenceUnitAllowance` exists and nothing in Doc 10 defines it. It is displayed on the plans screen as "N unités de résidence" — confirm that is right. |
| **Doc 10 has no Bien Multiple section** | `ResidencesApi` is fully built and the Pro designs have a complete flow, but M10 in Doc 10 describes single listings only. The spec is ahead of the CDC. |


---

## 10. M15 findings — no action needed, but worth recording

Answered by reading the Spring source rather than asking, so these are facts and
not guesses. Recorded because the next person will hit the same questions.

- **`AvailabilityRuleRequest.startTime` / `endTime` have no format in the spec** —
  bare `type: string`, no pattern, no example. They are Java `LocalTime`, so
  Jackson emits `"08:00"` when the seconds are zero and `"08:00:30"` otherwise,
  and accepts any ISO local time. The app parses leniently and writes
  `HH:mm:ss`. **Ask:** add `format` or an `example` to the spec — this is the
  one field where a wrong guess means no agent can ever be booked.
- **A zone is either a city or a district.** `AgentZone.ofCity` / `ofDistrict`
  leave the other id null; `ZoneResponse` is not a pair. `updateMyZones` rejects
  a request with both lists empty. Undocumented in the spec, which shows two
  nullable uuids and no explanation.
- **An agent's name and photo exist twice** — on `/users/me` and on `/agents/me`,
  both writable. Only the agent record counts: `profileComplete` and
  `AgentCandidate` read it. The app writes `/agents/me` for agents. **Ask:**
  is the base profile meaningful for an agent at all? If not, saying so in the
  spec would stop the next client writing the wrong one.


---

## 11. M11 — what the designs need and the API does not have

The Pro designs for "Mes agents" (`screenshots/pro/agents/`) describe a
**staff-with-permissions** product; Doc 10 §M11 and the API describe **assigning
a certified agent to a listing for visits**. The app builds the latter. Recording
the gap so the screens are not read as a backlog.

**Blocking a useful screen — small ask:**

- **`averageRating` + `ratingCount` on `AgentCandidate`.** Both already exist on
  `AgentProfileResponse`, but a prestataire choosing between candidates sees only
  `completedVisitCount`. The choice screen is the point of M11 for them, and a
  visit count alone is a weak basis. Two fields; the card picks them up with no
  UI change.

**Would complete a designed screen:**

- **No endpoint lists individual ratings.** `POST /visites/{id}/rating` writes
  one; nothing reads them. The design's "Avis" tab has no data source.

**Product-level, not API asks — these need a CDC section before any endpoint:**

- **Permissions** (the "Droits" tab: Finance / Agents / Locataires toggles). A
  delegated-access model, with real consequences — the design's copy includes
  *"effectuer des retraits"*. Not built: switches that gate nothing would read as
  security controls while being decoration.
- **Invitation by affiliation link.** RM-M11-03 assigns by *searching existing
  active agents*; there is no invite flow, and the API has no endpoint for one.
- **Agent contact details** (email, phone on the profile card). No agent payload
  carries them.
- **Job titles** ("Concierge", "Gestionnaire des biens"). No such field.


---

## 12. Assignment payloads carry no agent photo — ✅ DONE (2026-08-11)

**Outcome:** `agentPhotoObjectKey` shipped on `AssignmentResponse` and on the
residence half of `AssignmentItem`; `averageRating` + `ratingCount` shipped on
`AgentCandidate` (§11); and `GET /search/agents/{id}` was added — a *public*
agent profile with zones and `memberSince`, deliberately carrying **no phone or
email**. All three are wired.

**Their note, and it matters:** `averageRating` is null until somebody rates,
and rating is optional (RM-M07-07), so `completedVisitCount: 12, ratingCount: 0`
is an ordinary state. The app never renders it as "0 ★" — pinned by
`agent_detail_page_test.dart`.

<details><summary>Original request</summary>



`AssignmentResponse` and `ResidenceAssignmentSummary` return `agentAccountId`
and `agentName` — **no photo key**. `AgentCandidate` and
`ResidenceApplicationSummary` both carry `photoObjectKey`, so the *candidate
picker* can show faces and the *assigned agent* list structurally cannot. There
is also no public agent-profile endpoint (`/agents/me` is self-only), so the app
cannot look it up by account id either.

**Symptom:** reported from a device — "je ne vois pas la photo de profil de mon
agent assigné". The app now shows initials, which is the best it can do.

**Ask:** `agentPhotoObjectKey` on `AssignmentResponse` and
`ResidenceAssignmentSummary`. With §11's `averageRating` / `ratingCount` on
`AgentCandidate`, that is also what an agent detail screen needs to be worth
opening — otherwise it can only ever show a name and a list of properties.

</details>

---

## 13. RM-M11-06 — removing one agent from a pool has no endpoint

**Raised 2026-08-20**, after Doc 10's 2026-08-13 revision made a property carry
several agents (RM-M11-01) and the backend switched to that behaviour.

`DELETE /api/v1/annonces/{annonceId}/agent` takes **no agent**, and
`DELETE /api/v1/residences/{residenceId}/agent` takes the whole residence back.
Both were written when a listing had exactly one agent, and their summaries
still say so ("Remove the listing's agent"). With a pool of three, the app has
no way to express *which* of them the prestataire is removing — and no way to
predict what the server would do with the request.

**Symptom:** RM-M11-06 ("le prestataire peut retirer l'assignation d'un agent à
tout moment… uniquement pour cet agent") is unimplementable past the first
agent.

**Workaround shipped:** `PropertyAgentReady.canWithdraw` offers *Retirer
l'assignation* only while the pool holds one agent. Beyond that the screen says
removal is not available yet, rather than sending a call that might revoke
somebody else's assignment. Visits already booked are cancelled by a removal
(RM-M11-06), so guessing here costs a tenant their appointment.

**Ask:** `DELETE /api/v1/annonces/{annonceId}/agent/{agentAccountId}` (or the
account id as a required query parameter), and the residence equivalent. The
assignment id would do just as well — the app holds both.

**Also worth correcting while you are there:**
`POST /annonces/{id}/agent/applications/{applicationId}/accept` is still
documented as "the other applicants are declined automatically", and the
residence one as "rival applications on those units are declined". RM-M11-07 was
revised to the opposite. If the behaviour has changed and only the prose is
stale, the app is already written for the new rule; if the auto-decline is still
live, the prestataire cannot build a pool from applications at all.

---

## 14. A prestataire's own visits are a list and nothing else

**Raised 2026-08-20**, building the prestataire's side of RM-M11-10 (he shows
his own property) on top of `GET /prestataires/me/visites`.

Two things the agent has and he does not:

**No detail endpoint.** The agent gets `GET /agents/me/visites/{id}` —
`AgentVisiteDetail` with the exact address, the client's name and phone, the
prestataire's phone, and `canConfirm`. For a prestataire visiting his own
property there is only the list, and `VisiteResponse` carries the listing title,
the time, the status and the two confirmation timestamps. **No name and no phone
for the person he is meeting.** He knows his own address, so that part does not
matter; being unable to reach the visitor on the day does — it is the same
argument that put both numbers on the agent's screen (RM-M16-01).

**Ask:** `GET /prestataires/me/visites/{id}`, shaped like `AgentVisiteDetail`
minus what he already knows.

**No cancellation.** He can `decline` a proposed time, but once it is confirmed
there is no `POST /prestataires/me/visites/{id}/cancel`. The agent has one
(RM-M16-04, up to an hour before), the client has one (RM-M07-04, up to four
hours). A prestataire whose day changes can only leave the client standing at a
gate, which is exactly what CE-M07-02 exists to prevent.

**Ask:** the prestataire equivalent of `/agents/me/visites/{id}/cancel`, with
whatever cutoff the CDC decides — Doc 10 has no rule for an owner-visitor yet,
which is itself worth a line in M07.

**Workaround shipped:** the agenda shows what the list gives — hour, property,
status, and his own presence confirmation. No contact affordance is drawn at
all, rather than an empty one.

---

## 15. M08 — the error code for a tenant with no Mboa account

**Raised 2026-08-22**, building the prestataire's side of the Contrat Mboa.

CE-M08-01 says a contract for a tenant who has no account must **not** be
created: the server sends an SMS invitation and the prestataire draws it up
again once the invitation is accepted. That is a wait, not a mistake, and the
screen has to say so in those words — "invitation envoyée", not "action
impossible".

`POST /api/v1/contracts` documents `400`, `404` and `409` without naming the
codes behind them, and `api/docs/api-error-codes.md` has nothing for M08 yet.
The app currently reads a **404 as the invitation case** and everything else as
a refusal, which is a guess: a 404 on a deleted listing would produce the wrong
sentence.

**Ask:** the `error` code for this case (`TENANT_NOT_FOUND`, or whatever it is),
and the codes for the other M08 refusals — amending an accepted contract
(RM-M08-08), signing before both accounts are verified (RM-M08-02), a second
signature on a locked contract (RM-M08-03). Each needs different words, and the
app must not branch on `message`.

---

## 16. M04 — three questions on the search

**Raised 2026-09-30**, building the tenant's search.

**1. Is the tier order applied server-side?** CA-M04-02 requires Pro+ → Pro →
Basic+ → Gratuit in 100% of searches, and `SearchResultItem` carries
`tierRank`. The app takes the results **in the order they arrive** and never
re-sorts — a second implementation of the visibility algorithm would drift from
the first. Please confirm `GET /search` orders by tier then by recency; if it
does not, the app cannot honour CA-M04-02 by itself (page 2 would need the whole
set).

**2. The "Badges requis" filter does not exist.** Doc 10's M04 criteria table
lists it (📸 Photos vérifiées / ✅ Identité vérifiée / 🏆 Prestataire de
confiance) and `GET /search` has no parameter for it. It is left out of the MVP
screen; tell us if it is coming, or the CDC should drop it.

**3. `ProviderCard.badges` is an untyped `string[]`.** The fiche has to render
them in the prestige order of RM-M05-03 (🏆 → 🔄 → ✅ → 📸), which needs the
exact values. The app will parse defensively and ignore what it does not know,
but a documented enum would let it order them correctly rather than
alphabetically.

**Also noted, no action needed:** `cityId` is optional on `GET /search` while
RM-M04-01 makes the city mandatory. The app enforces it — a search across every
city is not a product decision we want to make by accident.

---

## §17 — The dev seed's photo keys point at nothing

**Raised 2026-09-30**, chasing "the photos on the fiche don't work".

Every seeded listing carries `primaryPhotoKey: "p/1.jpg"`, and the fiche's
`photoKeys` are the same shape. The app builds the public R2 URL from
`Environment.r2PublicBaseUrl`, and that object is not in the bucket:

```
GET https://pub-f76049c2b3fc47e79f2c9a437a81c89f.r2.dev/p/1.jpg → 404
```

So the app is behaving correctly — CE-M05-02 says a missing photo is a
placeholder, never a broken frame, and that is what shows. But it means **no
photo has ever been seen in dev**, on either app, so nothing about real images
has been exercised: aspect ratios, portrait shots, the 3-photo carousel,
loading behaviour on a slow line.

Either upload a handful of real objects under the seeded keys, or seed keys
that exist. A couple of files is enough; they only have to be there.

---

## §18 — The map (M04 lot 3)

**Raised 2026-10-01**, building the map view.

**1. Does `GET /search` fuzz the coordinates, or are they exact?** RM-M04-06
hides a listing's position within about 200 m until contact is established,
and `SearchHit` has carried a comment since lot 1 saying the API does it. The
app cannot check, and the distinction is the whole rule: if the exact point is
in the response, it is already on the device and blurring it on screen protects
nothing. Please confirm — and if it is not done yet, it belongs on the server
before the map ships to real listings. The app draws a 200 m disc and says so
in words either way, which is right for a fuzzed point and misleading for an
exact one.

**2. Three of the dev seed's Douala listings are in San Francisco.** Exactly
`37.785…, -122.406…` — the iOS simulator's default position, so these were
almost certainly created through a "use my location" capture while testing. A
fourth sits in Yaoundé with a Douala city id:

| Listing | Latitude | Longitude | Where that is |
|---------|----------|-----------|---------------|
| Maison bloc c | 37.785257 | -122.406955 | San Francisco |
| Appartement Blanc | 37.785264 | -122.406892 | San Francisco |
| *(untitled)* | 37.785842 | -122.406393 | San Francisco |
| *(untitled)* | 3.910248 | 11.500119 | Yaoundé |

A camera fitted to all twelve results spans a third of the planet and opens on
the open Atlantic, which is what the map did on the first run. The app now
frames the median cluster and leaves outliers off screen, so it survives this —
but a listing in the wrong city is wrong in the list too, and `ville` and the
coordinates disagreeing is worth a server-side check on write.

**3. No bounding box on `GET /search`.** There is no `bbox`, no radius and no
"search this area", so the map draws the pages the list has already loaded.
That is the behaviour we want for the MVP — one source of truth, one set of
filters — but if a map-first search is planned, the parameter has to come from
here rather than from a second query the app invents.

---

## §19 — Planning a visit (M07)

**Raised 2026-10-02**, building the tenant's side of M07.

**1. CE-M07-03 asks for the visitor's contact details, which do not exist.**
Inside four hours the tenant cannot cancel and the CDC says to show "les
coordonnées" so they can reach the visitor directly. No phone number travels
through the API, by design — hiding it is the whole point of M12 (CA-M12-02).
The app therefore tells them to reach the visitor **through messages**. If a
number is meant to be revealed at that moment, it has to be a deliberate
decision with its own field, not a side effect.

**2. Can an `ON_REQUEST` visitor return no slots?** `BookVisiteRequest`
requires `startsAt`, so a visitor who publishes no time cannot be booked at
all. We read RM-M15-06 — "un créneau proposé à un propriétaire qui confirme à
la main" — as meaning the slot is always published and the mode only decides
what happens next (`REQUESTED` rather than `SCHEDULED`). The app treats a
visitor with an empty `slots` list as "nothing free" whatever their mode.
Please confirm; if an open-ended request is meant to be possible, `startsAt`
has to become optional and the app needs a date picker instead.

**3. Nothing says whether a visit has already been rated.** RM-M07-07 allows
one rating per visit, and `VisiteResponse` carries no flag for it. The app
hides the stars after rating, but only for the rest of that session — reopen
the app and it offers a rating the server will refuse. A boolean on
`VisiteResponse` (or the rating itself) would fix it.

**4. No seeded listing accepts visits.** Every `canPlanVisit` is false in dev,
so the whole of M07 is covered by tests and has never run against the API:
not the slots endpoint, not a booking, not a confirmation. A listing with an
assigned agent who has declared availability would make this testable.

---

## §20 — A visit's property becomes unreadable to the person visiting it

**Raised 2026-10-02**, from a real booking on a dev device.

A tenant has a visit confirmed for today at 12:30 on `Studio Bependa`
(`80c67b6e-1f34-4564-be73-348e16d72b8e`). Opening that property from the visit
gives:

```
GET /api/v1/search/annonces/80c67b6e-… → 404 ANNONCE_UNAVAILABLE
```

and it is gone from `GET /search` as well. The listing left `PUBLISHED` after
the visit was booked — reserved, rented or archived — and the public endpoint
is the only one the tenant app has.

So someone due to visit a property in an hour cannot re-read its address hints,
its amenities, or the floor it is on. The app is right to say the listing is no
longer available; it is the only thing it can know.

**What we think is needed:** a party to an open visit should keep read access
to that visit's property, whatever its publication status. Either
`GET /search/annonces/{id}` serves an unpublished listing to a caller who has a
visit on it, or `GET /visites/{id}` returns the property snapshot alongside the
visit — the way `RM-M08-05` already has a contract copy the property it carries,
for the same reason: the record has to survive the listing.

Until then the app sends the tenant to a dead end two taps from a visit that is
about to happen, and there is nothing it can do about it from here.

---

## §21 — The bookable window is seven days, and the tenant hits the wall

**Raised 2026-10-02**, from a real device.

`GET /visites/slots` takes `annonceId` and nothing else, and answers with the
next seven days. On a property whose week is taken, the tenant is told "every
slot in the next 7 days is taken" and has **no way to look further** — not a
later week, not a date of their own. The app cannot widen a window it does not
choose.

Two ways out, and they are not exclusive:

1. **A range on the endpoint** — `from` / `to`, or a `weeks` count. The app
   would then let the tenant page forward through the visitor's calendar, which
   is what anyone expects of a booking screen.
2. **An open request** — the tenant proposes a date and the visitor answers,
   which is what RM-M15-06 already describes for an owner. `BookVisiteRequest`
   takes any `startsAt` today; what we do not know is whether the server
   validates it against declared availability, and it should, or a tenant will
   book a time nobody will honour (see §19.2).

Until one of them exists, the sheet says the window is seven days and offers to
message the provider — who can open a slot. That is a workaround, not an answer:
the tenant is asking a human to do what the calendar should do.


---

## Answered — 2026-10-01 / 2026-10-02

The backend's replies are in `docs/backend/backend-response.md`. What changed
here, and what is still open:

| § | Verdict |
|---|---------|
| §16.1 tier order | ✅ Ordered server-side **before** paging. The app never re-sorts; nothing to change. |
| §16.2 "Badges requis" filter | ✅ Shipped (`badges=`). **In the app now.** |
| §16.3 untyped `badges[]` | ✅ Typed `BadgeCode`, already in prestige order. **This one had bitten us:** the values the app had guessed (`TRUSTED_PROVIDER`, `VERIFIED_IDENTITY`, `VERIFIED_PHOTOS`) were all wrong, so every badge was silently dropped on the fiche. A wrong wire value looks exactly like an empty list. |
| §17 seed photos | ⏳ Needs files in the dev R2 bucket, not code. Several listings do render real photos now. |
| §18.1 fuzzed coordinates | ✅ Now an HMAC offset of 100–200 m under a server secret, stable per listing. The 200 m disc and its wording are right. |
| §18.2 positions outside Cameroon | ✅ Refused on write, and the dev data was repaired — 85 listings and units moved back to Douala. The camera's median-cluster rule stays: it is cheap, and one bad row is always one deploy away. |
| §18.3 bounding-box search | ⏳ Agreed: not for the MVP. |
| §8 amenities filter | ✅ Shipped (`amenities=`). **In the app now.** |
| §19 / §20 / §21 | Open — raised after these answers were written. |

**Also taken up:** malformed parameters answer `400 VALIDATION_ERROR` naming
the parameter instead of `500`. The app's generic "server error" is now
hiding a message worth reading; worth a pass over the error paths.

---

## §22 — M07bis: two ratings, two endpoints, one question

**Raised 2026-10-05**, building the client's visit report.

`SubmitReviewRequest` carries an optional `agentRating`, and
`POST /visites/{id}/rating` exists on its own. Both rate the **visitor's
service** (RM-M07-07), which is a different thing from the report's `rating`
on the property.

The app sends the visitor's rating only through `POST /visites/{id}/rating`,
from the visit card, and leaves `agentRating` out of the report — one concept
should not have two write paths, and a tenant who rates from the card and then
writes a report would otherwise send it twice.

**What we need to know:** is the second one refused (`409`), ignored, or does
it overwrite? If the report's `agentRating` is the intended path, say so and
the card's stars will move into the form instead. Related to §19.3: nothing in
`VisiteResponse` says whether a rating was given, so the app cannot tell either
way after a restart.

---

## §23 — Push copy still vouvoies, and the app cannot fix it

**Raised 2026-10-11**, finishing the brand-identity pass.

Brandbook v2 §37 says *« On tutoie dans l'app et sur les réseaux »*, without
distinguishing App Mboa from App Mboa Pro. §34 reserves the premium,
vouvoyé register for documents, pitches and partners — not for product
surfaces. The 125 French strings the app owns are now tutoyées, and
`packages/mboa_l10n/test/voice_test.dart` keeps them that way.

**Notification copy is not among them.** `PushMessage.fromData` takes `title`
and `body` straight from the FCM payload (`packages/mboa_shared/.../models/
push_message.dart`), so what the user reads on the lock screen is whatever the
server composed. Today that is still the old register — the fixture we test
against is `"Votre formule Pro est active."`, which is also what §35 gives as
the example *not* to use for a confirmed payment.

**What we need:** the server-side notification templates moved to the same
register. For the one case the brandbook spells out, the copy is given
verbatim:

| Situation | Mboa says | Mboa does not say |
|---|---|---|
| Paiement confirmé | « C'est réglé. Tu recevras ta confirmation par SMS. » | « Votre transaction a été effectuée avec succès. » |

The same rule covers the rest: no *veuillez*, no *prière de*, no
*utilisateur*, no *plateforme*. The app deliberately does not rewrite these
client-side — a notification arrives while the app is terminated, so the text
has to be right when it leaves the server.

**Alternative, if the templates are expensive to change:** send a `type` and
the variables (`tier`, `amount`, `propertyTitle`) and let each app render the
copy from its own ARB. That also fixes the language: a push composed
server-side is in one language, while the app already knows which one the
reader chose.

---

## §24 — M27: Doc 10 moved after you shipped, and two things no longer line up

**Raised 2026-10-13**, starting M27.

Your 2026-08-15 answer on *Avis Résident* is implemented against as written —
the app reads `residentReviewEligible` and never re-derives it. But Doc 10's
M27 section was **revised on 2026-08-20, five days later**, and two of its
rules now contradict what shipped. Neither blocks us; both change what a user
sees, so we would rather ask than guess.

### 24.1 The one-month gate vs. "any Contrat Mboa"

You wrote: eligible when the contract is SIGNED and *"it ran for at least a
month"*; a 3-day let answers `409 TENANCY_TOO_SHORT` and should be steered to
a visit review.

Doc 10 RM-M27-01, revised 2026-08-20, says the opposite in as many words:

> Un avis résident peut être rédigé par tout utilisateur ayant un **Contrat
> Mboa signé** … **quelle que soit la périodicité** (jour, semaine ou mois).
> […] un séjour Day/Week reste un séjour réel — la personne a effectivement
> occupé le bien, contrairement à un simple visiteur.

RG-06's note carries the same revision for the weight of 3. RM-M27-02 also
says the review is *"rédigeable à tout moment à partir de la signature"*,
which leaves no room for a one-month wait.

**What we need:** either `residentReviewEligible` turns true for Day/Week
tenancies too, or Doc 10's revision is the one that is out of date. We are
following your flag either way — we are only asking which document is now
right, because a tenant of three days currently sees nothing and Doc 10 says
they should.

### 24.2 `residenceMonths` cannot express what RM-M27-02 asks for

`PropertyReview.residenceMonths` is an integer count of months. RM-M27-02:

> La durée de résidence est affichée **dans l'unité de périodicité du contrat**
> (jours, semaines ou mois) : un séjour de 3 jours affiche "3 jours", un
> contrat de 12 mois affiche "12 mois". **Aucune conversion forcée en mois.**

A 3-day tenancy is `residenceMonths: 0`, and the fiche would read "0 mois sur
place" — which is both wrong and unkind to the person who wrote the review.
The public feed has no contract to recover the real unit from.

**What we need:** a duration plus its unit on `PropertyReview` — e.g.
`residenceDuration: 3` with `residencePeriod: "DAY" | "WEEK" | "MONTH"`,
matching `RentalPeriod`. Additive; `residenceMonths` can stay for now.
Until then the app shows the duration only when it is at least one month, and
says nothing otherwise rather than saying zero.

### 24.3 `canAccept` beside `canSign`

Not M27, but it surfaced building M27's entry point. `ContractResponse` gives
`canSign` — the server's verdict, which the app renders and never works out.
There is no equivalent for accepting, and `awaiting` cannot stand in: it says
*whose* move it is and reads identically for both parties, so a screen shared
between the two apps cannot tell from it whether the reader is the one being
waited on.

The tenant's screen therefore offers *Accepter les termes* on `status == SENT`
and `awaiting ∈ {TENANT, BOTH}`, plus the knowledge that App Mboa is always
the tenant. That is the only place in M08 where the app combines two server
values instead of reading one, and it is the kind of derivation that went
wrong before.

**What we need:** `canAccept` on `ContractResponse`, computed like `canSign`.
One boolean deletes the derivation.

---

## §25 — The report reasons were drawn for listings, and reviews now use them

**Raised 2026-10-13**, wiring RM-M27-06.

`CreateSignalementRequest.reason` offers four values:

```
FRAUDULENT_LISTING · ABNORMAL_PRICE · INAPPROPRIATE_CONTENT · HARASSMENT
```

Two of them are about listings. `REVIEW` was added to `targetType` without
the reason list following, so the API currently accepts
`{targetType: REVIEW, reason: ABNORMAL_PRICE}` — a review reported for being
overpriced.

**What the app does meanwhile:** it narrows the menu per target rather than
asking a nonsensical question. A listing offers fraud, price and
inappropriate content; a review and a message offer inappropriate content and
harassment. Nothing is blocked, and the server is free to keep accepting
anything.

**What we need, eventually:** either the reason set grows a review-shaped
pair — something like `FALSE_CLAIM` and `PERSONAL_ATTACK`, which are the two
things a landlord actually disputes about a review — or the endpoint
documents which reasons are valid per target so both ends agree. The second
is cheaper and would do.

**Worth saying plainly, because the asymmetry is deliberate and sharp:** your
2026-08-15 note has one upheld report removing a review, where
RM-M23-03 takes three to suspend a listing. The app treats that affordance
accordingly — a quiet text button under the review, never a prominent one —
but it does mean a single admin decision erases somebody's account of a year
of their life. If the admin queue ever shows review reports and listing
reports in the same list with the same weight, that difference will be easy
to forget.

**Also minor:** the endpoint's summary still reads *"Report a listing or a
message"*. Reviews are missing from it.
