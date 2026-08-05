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

- **`amenities`** — Doc 10 mandates an "Équipements (checklist)" field and the
  API omits it. Should be a closed enum so M04 can filter on it.
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
| **Operation ids are unstable** | The 2026-08-05 regen renamed `listMine1` → `listMine2` and broke the build. Explicit `operationId`s in the spec would stop generated names shifting when unrelated endpoints are added. |
| **Un-archiving** ⚠️ | **Confirmed broken.** `publish` rejects anything not `DRAFT`, so "Republier" returns 409 `INVALID_STATUS_TRANSITION` in the shipped app. Backend recommends `POST /annonces/{id}/unarchive` → `DRAFT`, so re-publishing re-checks the tier quota and the 3-photo rule. **Awaiting the founder's decision.** |
| **Subscription tier on `/me`** | `MeResponse` has no tier, so the app makes a second call to `GET /subscriptions/me` on every session start purely to know what to gate. |
| **No `residenceUnitAllowance` docs** | `TierInfo.residenceUnitAllowance` exists and nothing in Doc 10 defines it. It is displayed on the plans screen as "N unités de résidence" — confirm that is right. |
| **Doc 10 has no Bien Multiple section** | `ResidencesApi` is fully built and the Pro designs have a complete flow, but M10 in Doc 10 describes single listings only. The spec is ahead of the CDC. |
