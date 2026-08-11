# Backend response — to the mobile requests

Reply to [`backend-requests.md`](backend-requests.md) (2026-08-05). Each item is
answered against the code, not from memory: everything below was verified on a
running instance against the real database unless marked otherwise.

**Shipped in this pass:** §1 (error contract), §2 (`residenceId`), §3 (answer, no
change needed), §4 (payment list), §5 (**both** status endpoint and push), §7
(notification payload).

**Also shipped after your go-ahead:** un-archiving for both listings and
residences (§9), plus the Doc 10 rules that were missing behind it (RM-M10-08,
N-14).

**Not doable yet:** §6 (dashboard) — most of the metrics have no source data.

---

## 1. Error responses — shipped, but your parser is reading the wrong key

The contract already existed and has not changed. What was missing was the
*documentation*, which is now generated from the source.

**The machine code is in `error`.** Not `code`, not `errorCode`, not
`error_code` — `ApiError.from` looks for all three and we send none of them. That
is almost certainly why everything reads as generic:

```json
{
  "timestamp": "2026-08-05T22:29:05Z",
  "status": 409,
  "error": "LISTING_LIMIT_REACHED",
  "message": "Your plan's active-listing limit is reached.",
  "path": "/api/v1/annonces/{id}/publish"
}
```

`message` is prose for a human and gets reworded — never branch on it.

**Your guessed table was wrong on three rows of four:**

| You look for | Reality |
|---|---|
| `LISTING_LIMIT` / `ANNONCE_LIMIT` / `ACTIVE_LISTING_LIMIT` | `LISTING_LIMIT_REACHED` (409) |
| `KYC_REQUIRED` | **does not exist** — no endpoint emits it |
| `PROFILE_INCOMPLETE` | correct (409) |
| `RESIDENCE_UNIT_LIMIT` | correct (409) |

**Delivered:**

- [`docs/api-error-codes.md`](docs/api-error-codes.md) — all **63 codes**, grouped
  by module, each with its HTTP status and meaning. Generated from the source, so
  it cannot drift.
- `ErrorResponse` is now a named schema in the OpenAPI document and is referenced
  from the 400/401/403/404/409/500 responses of **every** operation. Your next
  regen will have a real error type instead of guesswork.
- **New:** `VALIDATION_ERROR` now carries a `fields` array, so you can attach a
  complaint to the input that caused it instead of parsing the message:

```json
{
  "error": "VALIDATION_ERROR",
  "message": "attachmentKeys: A message carries at most 3 images.; annonceId: must not be null",
  "fields": [
    { "field": "attachmentKeys", "message": "A message carries at most 3 images." },
    { "field": "annonceId", "message": "must not be null" }
  ]
}
```

On your note about Spring's default `{"error": "Bad Request"}`: no route returns
it. Everything funnels through one `@RestControllerAdvice`, including 404s on
unknown URLs and 405s — those give `NOT_FOUND` and `METHOD_NOT_ALLOWED`.

**We kept `error` rather than renaming it to `code`.** Renaming breaks every
shipped client for no functional gain. If the name is genuinely a problem for the
generator, say so and we will add `code` as a duplicate rather than a rename.

## 2. `residenceId` on `AnnonceResponse` — shipped

`AnnonceResponse` now carries **`residenceId`**: null for a standalone listing,
the parent residence for a unit. "Biens Uniques" is one request with a client-side
`residenceId == null` filter — delete the subtraction logic and the N+1.

Verified live:

```
Studio 2            residenceId=ed2c35bf-…
Studio 1            residenceId=ed2c35bf-…
Villa standalone    residenceId=None
```

One correction: the empty `units` on the residences *list* is deliberate, not a
bug — the list builds unit counts with an aggregate query instead of loading every
unit. `residenceId` is the better fix anyway, so the individual fetches can go.

**Also added: `expiresAt`** — when a Free-tier listing auto-expires (RM-M10-04),
null on paid tiers. You can now show the J+30 countdown instead of computing it.

```
status: PUBLISHED | publishedAt: 2026-08-05T22:30:19Z | expiresAt: 2026-09-04T22:30:19Z
```

## 3. Yes — a residence unit id *is* an annonce id

No API change needed. `ResidenceService` builds `UnitSummary.id` straight from the
unit's `Annonce.id`. Verified end to end: created a residence, took a unit id from
`GET /residences/{id}`, and `GET /api/v1/annonces/{unitId}` returned **200** with
the unit and its `residenceId`.

So `getOne` / `update` / `publish` all work on a unit today. Go build the per-unit
view/edit.

Two things to know:

- **Publishing a unit deliberately skips the active-listing quota.** A residence is
  inherently many listings; the allowance is enforced at residence *creation*
  (`RESIDENCE_UNIT_LIMIT`) instead. So publishing a unit will not hit
  `LISTING_LIMIT_REACHED`.
- **`DELETE /annonces/{unitId}` removes a unit from its residence** with no guard
  and no effect on the parent. Probably what you want, but it is not protected —
  tell us if it should be.

## 4. `GET /subscriptions/payments` — shipped

Paginated, most recent first. Delete the Hive cache and the "les reçus sont liés à
cet appareil" caveat.

```json
{
  "paymentId": "152944f7-…", "tier": "PRO", "amount": 10000,
  "method": "MTN_MOMO", "status": "CONFIRMED",
  "hasReceipt": true,
  "paidAt": "2026-08-05T22:30:54Z", "createdAt": "2026-08-05T22:30:34Z"
}
```

`hasReceipt` tells you whether `GET /payments/{id}/receipt` will succeed, so you
can show or hide the download without a probe call. No provider reference is
exposed — that is an internal correlation id.

## 5. Payment status **and** push — both shipped

We disagreed with picking one, and built both.

**`GET /api/v1/subscriptions/payments/{id}`** returns the same shape as above and
is the source of truth. Poll *this* instead of `mySubscription()` — it answers the
actual question and distinguishes `FAILED` from "not yet", which the tier never
could.

**Push on settlement**, because there was none at all before — a real gap against
Doc 10's own M13 flow ("reçu PDF généré + notification prestataire"), not just a
UX shortfall. Both outcomes now notify, after commit, so the tier really is active
by the time the device hears:

```
data={type=PAYMENT_CONFIRMED, entityId=<paymentId>, deepLink=mboa://subscription}
```

Failure follows CE-M13-01 wording ("Vérifiez votre solde Mobile Money…") and uses
the same `type`, so one handler covers both — read `status` from the payment.

**Why not push alone:** delivery is not guaranteed, the user may deny permission,
and FCM has still never been exercised against real credentials here. Treat push
as the optimisation that ends the polling, not as the transport of record.

**A correction to something we said earlier:** `POST /subscriptions` *already*
accepts an `Idempotency-Key` header and has since M13 Slice A — a repeat returns
the same payment rather than charging twice (CE-M13-03). But **when the header is
absent the server generates a random key per request**, so a double-tap really does
create two payments today. Verified:

```
Idempotency-Key: tap-1  → 152944f7-…  PENDING
Idempotency-Key: tap-1  → 152944f7-…  PENDING   (same payment, no second charge)
```

**Please send the header.** This is the one item on either list that costs real
money. A UUID generated when the user opens the payment sheet — stable across
retries of the same intent, new for a new intent.

## 6. Dashboard metrics — not one endpoint, and mostly not possible yet

Agreed the feature is empty, but an aggregate endpoint would not fill it, because
the *events are not captured anywhere*:

| Metric | Blocked on |
|---|---|
| Contacts received | **now available** — M12 shipped, conversations per listing is a real number |
| Views (total / 7d) | RM-M05-06 view counter — M05, not built |
| Conversion views→contacts | needs views |
| Visits via agent | M16 |
| Signed contracts | M08 |
| Average ranking | M04 instrumentation, does not exist |

So: views + contacts land with M05, the rest as their modules do. Your nullable
model with "Bientôt" is the right shape — keep it, do not let us talk you into
fabricating zeroes.

## 7. Notification payload — shipped, and you diagnosed it exactly right

Before this pass every push carried **only** `{"deepLink": "mboa://…"}`. No
`type`, no `entityId` — so `PushMessage.fromData` found nothing and degraded to
the shell, which is precisely the symptom you described. That was our bug.

The payload is now, on every notification:

```json
{ "type": "MESSAGE", "entityId": "<uuid>", "deepLink": "mboa://conversations/<uuid>" }
```

`deepLink` stays for clients that prefer a URL. Verified on the wire:

```
data={type=MESSAGE,           entityId=7d2470c6-…, deepLink=mboa://conversations/7d2470c6-…}
data={type=PAYMENT_CONFIRMED, entityId=152944f7-…, deepLink=mboa://subscription}
```

Types and what `entityId` means for each:

| `type` | `entityId` | Sent when |
|---|---|---|
| `MESSAGE` | conversation id | a message arrives (either direction) |
| `PAYMENT_CONFIRMED` | payment id | a payment settles — **confirmed or failed** |
| `KYC` | account id | an identity-verification decision |
| `ANNONCE` | listing id | *reserved* — nothing emits it yet |
| `VISIT` | visit id | *reserved* — M07/M16 not built |

Exactly your five names. The enum is append-only and treated as a published
contract; renaming a constant breaks navigation in shipped clients, and there is a
test pinning the wire keys.

## 8. M10 listing fields

- **`amenities`** — agreed, Doc 10 mandates it. Queued as a closed enum so M04 can
  filter on it. Not in this pass.
- **`waterMetering` / `electricityMetering`** — not in Doc 10. We would rather not
  add speculative columns: if the designs show "Compteur Prépayé", get it into the
  CDC and it goes in without argument.
- **Title deed and price period** — agreed with your recommendation against both.
- **`photoKeys.minItems: 0`** — the rule you asked for already exists server-side.
  Drafts may have zero; `POST /annonces/{id}/publish` rejects fewer than three with
  **`INSUFFICIENT_PHOTOS`** (400). The app is not the only thing checking. It is
  the *spec* that is wrong, and it now at least documents the failure response.

## 9. Smaller things

### Un-archiving — shipped (your "Republier" button was calling the wrong endpoint)

`POST /annonces/{id}/publish` rejects anything that is not `DRAFT`, so an archived
listing returned **409 `INVALID_STATUS_TRANSITION`**. The button could not work.

Decided and built:

- **`POST /api/v1/annonces/{id}/unarchive`** → returns the listing to `DRAFT`.
  409 `INVALID_STATUS_TRANSITION` if it is not archived.
- **`POST /api/v1/residences/{id}/unarchive`** → returns every archived unit to
  `DRAFT`. Units in any other state are left alone, like the other bulk
  transitions. Without it, archiving a residence was a one-way door — the only
  way back was one call per unit.

So "Republier" is **two calls**: `unarchive`, then `publish` (or `publishAll`).

That is deliberate, not an oversight. Re-publishing goes through the normal
publish path and re-checks everything: profile complete, three photos, and the
**current** tier's limit. A listing archived when a paid plan lapsed (RM-M13-02)
therefore cannot come back on Free by going round the quota. Verified:

```
publish A2 (takes the single Free slot)   -> 200
re-publish the unarchived A1              -> 409 LISTING_LIMIT_REACHED
```

Surface this in the UI: after `unarchive`, publishing can legitimately fail with
`LISTING_LIMIT_REACHED` or `INSUFFICIENT_PHOTOS`, and the user needs to know which.

The previous publication window (`publishedAt` / `expiresAt`) is cleared on
unarchive, so a restored draft does not look already expired.

Doc 10 has been updated to match: **RM-M10-08** now defines the transition and the
lifecycle diagram has the arrow back.

### Operation ids — fixed

Every one of the **85 operations now declares an explicit `operationId`**, so
generated names no longer depend on scan order. Verified: adding a new endpoint
whose Java method collides with an existing one changed **zero** existing ids.

Before this, 14 ids carried a generated numeric suffix — `listMine_1` through
`listMine_4`, `create_1`, `reject_2` and so on — and those numbers were assigned
in scan order, which is exactly why your 2026-08-05 regen renamed one and broke
the build.

**This is a one-time break, then permanent stability.** 69 of the 85 ids change.
We also renamed ids that were unique but generic (`create`, `update`, `validate`,
`restore`, `add`, `report`), because the visit chain is about to add endpoints
that would have collided with them and started the churn again. The full mapping
is in [`docs/openapi-operation-ids.md`](docs/openapi-operation-ids.md).

Names follow `<verb><Resource>`: `createAnnonce`, `listMyFavoris`,
`markConversationRead`, `validateSignalement`. No routes, payloads or behaviour
changed — this is metadata only, confirmed by diffing the spec's paths.

### Subscription tier on `/me` — added

`MeResponse` now carries **`tier`**, so you can drop the second call to
`GET /subscriptions/me` on session start. It is null for any role other than
PRESTATAIRE (and, being null, absent from the JSON).

One caveat: the tier changes independently of the session — a payment webhook can
activate it mid-session — so treat it as fresh only as of that call. Do not cache
it for the lifetime of the session.

### Subscription tier on `/me`

Agreed, cheap, not in this pass. One caveat worth knowing: tier changes
independently of the JWT (a webhook can activate it mid-session), so a tier on
`/me` is only fresh as of that call — do not cache it for the session.

### `residenceUnitAllowance`

It is real, and it is ours: added during the M13 quota slice to cap how many units
one residence may contain per tier. **It is not in Doc 10** — the name was invented
in the backend. "N unités de résidence" on the plans screen is a correct reading of
what it does. It needs writing into the CDC.

### Doc 10 has no Bien Multiple section

You have found a governance problem, and it is the most important item on your
list even though you ranked it last. Residences are fully built — bulk lifecycle,
per-residence quota, unit allowance — against a CDC that describes single listings
only. Doc 10 is supposed to be authoritative for module numbers and RM-IDs, so
right now there is a shipped feature nobody can validate against a spec, and no
RM-IDs to cite in a bug report. Same root cause as `residenceUnitAllowance` and
the missing N-id in §5. Raised with the founder.

---

---

## Since this reply: M05 fiche bien + M23 signalements shipped

**`GET /api/v1/search/annonces/{id}`** — the public fiche. Readable with no
account (CA-M05-04). The exact address is never in the payload and the point is
fuzzed ~200m (RM-M05-02).

- **Send `X-Device-Id`.** Anonymous views are counted once per device per 24h;
  without the header an anonymous view is not counted at all. Signed-in views are
  counted by account, and the owner's own visits never count.
- **`viewCount` is absent unless the caller owns the listing** — Doc 10 shows that
  figure to the prestataire only.
- **`provider.badges` is always `[]`** until M09 computes badges and M20 lets an
  admin award them. The field is there so nothing changes when they land.
- **`canPlanVisit` is always `false`** until M11 assigns agents (RM-M05-07). Show
  "Contacter" alone for now.
- A listing that is draft / rented / archived / suspended returns **404
  `ANNONCE_UNAVAILABLE`** — that is your "Ce bien n'est plus disponible" (CE-M05-01).

**Équipements** (your §8): `amenities` now exists on listings, as the closed enum
`AIR_CONDITIONING · HOT_WATER · GENERATOR · SECURITY_GUARD · PARKING · WIFI`.
Settable on create/update, returned on the fiche.

**`POST /api/v1/signalements`** — the fiche's "Signaler" and the thread's report
action, both. `{targetType: ANNONCE|MESSAGE, targetId, reason, comment?}` with
reason in `FRAUDULENT_LISTING · ABNORMAL_PRICE · INAPPROPRIATE_CONTENT ·
HARASSMENT`. This closes **RM-M12-07**, which we had deferred out of M12.

- The reporter is told only that it was received (RM-M23-05) — never the outcome.
- A second pending report on the same target gives **409 `ALREADY_REPORTED`**;
  treat that as success in the UI, the first one is already queued.
- Reporting a message requires being in that thread, else **404**.
- Three upheld reports suspend a listing automatically, after which its fiche 404s
  and it leaves search.

### M06 favourites & history

- **`POST /api/v1/favoris`** `{annonceId}` · **`DELETE /api/v1/favoris/{annonceId}`** ·
  **`GET /api/v1/favoris`** — USER role only. Both writes are **idempotent**, so
  the heart can update optimistically and reconcile in the background (CA-M06-01)
  without a retry ever failing.
- **409 `FAVORITE_LIMIT_REACHED`** past 50 (RM-M06-02).
- **`available: false` is your "Plus disponible" badge.** A favourite whose listing
  was rented *or deleted* stays in the list for 30 days, then disappears on its own
  (RM-M06-03). When the listing was deleted outright, `annonceId` is absent — the
  card still renders from the snapshot taken when it was saved, so do not assume
  the id is there.
- **`GET /api/v1/historique`** and **`DELETE /api/v1/historique`** (reset from
  settings). Written **automatically** when a signed-in user opens a fiche — there
  is no endpoint to append to it. The same listing appears once per visit: RM-M06-05
  is explicit that history is not deduplicated. Capped at the last 30.
- Both are account-scoped, so they survive a reinstall and follow the user to a new
  phone (RM-M06-06, CA-M06-02) — no local cache needed.

## What we need from you

1. **Read `error`.** Everything in §1 depends on it.
2. **Send `Idempotency-Key`** on `POST /subscriptions` (§5). Costs real money.
3. **M12 messaging is live** and the apps do not know about it yet:
   - `POST /conversations` (**USER role only** — a prestataire gets 403),
     `GET /conversations`, `GET|POST /conversations/{id}/messages`,
     `POST /conversations/{id}/read`.
   - **Phone numbers are masked server-side** in every message body, both
     directions (RM-M12-03/CA-M12-02). The UI must not offer a call affordance or
     imply a number is coming — it never is, until a signed contract (M08).
   - **`ConversationResponse.readOnly` must disable the composer.** A thread stays
     readable when the listing is archived, rented *or deleted*; sending then
     returns 409 `CONVERSATION_READ_ONLY`.
   - Attachments: presigned upload with the new `MESSAGE_ATTACHMENT` category,
     send **object keys, not URLs**, max 3, images only.
   - A double-tapped "Contact" returns **409 `CONSTRAINT_VIOLATION`** — retry and
     you get the existing thread.
4. **Device token lifecycle** — do you re-register on FCM token rotation and delete
   on logout? Stale tokens mean pushes into the void and a deleted account's tokens
   lingering.
5. **Confirm the page envelope.** We return
   `{content, page, size, totalElements, totalPages, last}` — deliberately *not*
   Spring's raw `Page`, whose shape is unstable across versions. If anything reads
   `pageable.pageNumber` or `numberOfElements`, it will break on upgrade.
6. **Timestamps are ISO-8601 UTC**, always. Confirm nothing assumes local time.
7. **Null fields are omitted from JSON, not sent as `null`** (`non_null`
   inclusion). So a standalone listing has *no* `residenceId` key at all, a paid
   tier has no `expiresAt`, an unread message has no `readAt`. If your models
   distinguish "absent" from "null", treat both as null — this bit us while
   testing and it will bite a generated client that marks fields required.

## Verification

Everything above was exercised against a live instance on the real PostGIS
database: error shape and per-field validation, `residenceId` on both a standalone
listing and residence units, `expiresAt` on a published Free listing, unit-id ==
annonce-id, idempotent subscribe, payment status transition, payment history, and
both push payloads on the wire. 317 unit tests pass.

**Not verified locally, as always:** FCM (logging provider — the payload is
verified, delivery is not) and R2 (dev points at a dummy endpoint, so
`hasReceipt` reads false in dev even after a confirmed payment; the tier still
activates, receipt storage is best-effort by design).

---

# 2026-08-07 — agent assignments: two lists, resignation, clearer visit errors

Changes on the agent side of M11 and the booking side of M07. Nothing above is
renamed or removed; all of this is additive except where flagged.

## 1. The agent's two lists are now separate

`GET /agents/me/assignments` used to return offers received **and** applications
sent, mixed. It now returns **offers only**. Applications sent live at:

- `GET /agents/me/applications` — `listMyAgentApplications`, same page envelope
  and same `AssignmentResponse` shape.
- `DELETE /agents/me/applications/{id}` — `withdrawMyAgentApplication`, withdraw
  an application nobody has answered.

`DELETE /agents/me/assignments/{id}` (`withdrawAgentApplication`) still works and
does the same thing, so nothing breaks before you migrate.

`AssignmentResponse` gains **`initiatedBy`**: `PRESTATAIRE` (offered to the agent)
or `AGENT` (the agent applied). Status alone could not tell you — an accepted
application is indistinguishable from an accepted offer — which is what made the
mixed list unreadable.

## 2. An agent can resign an assignment they accepted

`POST /agents/me/assignments/{id}/resign` — `resignAgentAssignment`.

Only on an `ACCEPTED` assignment. Visits booked through that agent are cancelled
(`AGENT_REMOVED`) and the owner is notified, exactly as when the owner removes
the agent. Anything else answers `409 ASSIGNMENT_NOT_ACCEPTED`, with a message
pointing at the right action — an unanswered offer is `/decline`, an unanswered
application is a withdraw.

New assignment status: **`RESIGNED`** (terminal). Handle it in any exhaustive
`switch` over the status.

## 3. `/opportunities` no longer lists what you have applied to

Listings the agent has an open application on are now **absent** from the feed
rather than returned with `alreadyApplied: true` — they have their own list now.
**`alreadyApplied` is therefore always `false`.** It is still in the payload so a
generated client does not break; tell us when you have stopped reading it and we
will drop it.

## 4. "No agent is available" was one message for three situations

Booking endpoints (`GET /visites/slots`, `POST /visites`) answered
`NO_AGENT_ASSIGNED` whether the listing had no agent, had an agent who had not
answered yet, or had a working agent with nothing free. The three are now
distinct — and the third is not an error:

| Situation | Answer |
|---|---|
| No agent, or only open applications the owner has not chosen from | `409 NO_AGENT_ASSIGNED` |
| Offered to an agent, awaiting their answer | `409 AGENT_NOT_CONFIRMED` (**new code**) |
| Agent accepted, but no availability declared or fully booked | `200` + **empty list** (CE-M07-01) — invite the user to contact the prestataire |

## 5. Two smaller fixes

- Applying to a listing that is not `PUBLISHED` now answers
  `409 ANNONCE_NOT_PUBLISHED` (**new code**). The feed only ever showed published
  listings, but applying by id reached drafts.
- The push a prestataire receives when an agent applies said *"Nouvelle
  assignation — un prestataire vous propose …"*, i.e. the offer wording aimed at
  the wrong role. It now reads *"Nouvelle candidature — un agent souhaite
  s'occuper de « … »"* and deep-links to the listing's applications.

## Verification

Exercised end to end against the live PostGIS database: migration and backfill,
apply → leaves the feed → appears under `/applications` → owner accepts → origin
survives as `AGENT` → user books a visit → agent resigns → visit `CANCELLED /
AGENT_REMOVED` and the listing returns to other agents' feeds → owner re-offers →
`AGENT_NOT_CONFIRMED` on the slots endpoint → resign refused with the pointer to
`/decline`. Draft-application refusal re-checked after the fix. 439 unit tests
pass.

**Not verified locally, as always:** FCM delivery (the logging provider is used —
the push payload and wording are verified on the wire, delivery is not).

---

# 2026-08-08 — admin listing moderation (M19)

New admin-only endpoints. Nothing existing changes shape, and one field is added
to a response you already read.

## New endpoints (ADMIN role)

| Endpoint | `operationId` | What |
|---|---|---|
| `GET /admin/annonces?query=&status=` | `listAdminAnnonces` | Find a listing by title, or by its owner's phone or email. Paged, same envelope. |
| `POST /admin/annonces/{id}/suspend` | `suspendAnnonce` | Body `{"reason": "…"}` — **required**. 204. |
| `PATCH /admin/annonces/{id}` | `updateAnnonceAsAdmin` | Same body as the owner's `PATCH /annonces/{id}`. Edits a listing the admin does not own (RM-M19-05). |

`POST /admin/annonces/{id}/restore` (`restoreAnnonce`) already existed and is
unchanged, beyond now clearing the suspension reason and notifying the owner.

## `AnnonceResponse` gains `suspensionReason`

Present only when `status` is `SUSPENDED` — remember null fields are omitted, so
an absent key means "not suspended". Show it to the owner on their own listing:
until now a prestataire could see that a listing was pulled but not why.

## New notification: N16 (mandatory)

Sent to the **prestataire** when their listing is suspended, restored, or edited
by an admin. Mandatory, like N-07/N-08/N-11/N-12/N-14 — it cannot be switched off
in notification settings, so `PATCH /users/me/settings` will answer
`NOTIFICATION_MANDATORY` if you try.

Routing is `type: ANNONCE`, `entityId` the listing id, deep link
`mboa://annonces/{id}` — nothing new to handle. Titles: `Annonce suspendue` ·
`Annonce rétablie` · `Annonce modifiée`. The suspension body carries the reason,
the edit body names the fields that changed.

## Behaviour worth knowing

- Suspending an already-suspended listing is a **no-op**, not an error: the
  original reason stands and nobody is re-notified.
- A suspended listing leaves public search **immediately** (verified), and
  restoring puts it straight back.
- There is **no admin delete**. Doc 10 gives suspension as the moderation tool;
  if you need a destroy action in the console, ask and we will scope it.

## Verification

Exercised live against the real database: admin search by owner email and by
status, reason-less suspension refused, suspension recorded with the admin's id,
the listing leaving and re-entering search, the owner's three pushes on the wire,
the reason visible on the owner's own listing, an admin editing a listing they do
not own, restore clearing the trail, and a prestataire's 403 on all of it. 454
unit tests pass.

**Not verified locally, as always:** FCM delivery (logging provider — payload and
wording verified, delivery is not).

---

# 2026-08-09 — M16: the agent carries out the visit, reports, and is rated

The last piece of the visit chain. All additive except one behaviour change,
flagged below.

## The agent's flow

| Endpoint | `operationId` | What |
|---|---|---|
| `GET /agents/me/visites/{id}` | `getMyAgentVisite` | The visit sheet |
| `POST /agents/me/visites/{id}/start` | `startMyAgentVisite` | "Démarrer la visite" |
| `POST /agents/me/visites/{id}/report` | `submitVisiteReport` | File the report (201) |

**The sheet** (`AgentVisiteDetail`) is the only response in the API carrying a
listing's **exact address and true coordinates**, plus both counterparties' phone
numbers. Returned only to the agent that visit is assigned to — anyone else gets
404, including an admin. The public fiche is unchanged: no address, position
still fuzzed. `canStart` is true only on the day itself.

**Starting** takes `{latitude, longitude, overrideReason?}`. Within 500 m it just
starts. Beyond it you get `400 TOO_FAR_FROM_PROPERTY` with the measured distance
in the message, and re-sending with `overrideReason` succeeds — being elsewhere
is *recorded*, not refused. Also: `409 VISIT_NOT_TODAY`, `409 VISIT_ALREADY_STARTED`.

**The report** takes `{overallCondition 1-5, listingConformity, comment?,
photoKeys}` — **at least 3 photos**, `listingConformity` is `OUI` ·
`PARTIELLEMENT` · `NON`. Filing it sets the visit `COMPLETED` and is **final**:
a second attempt is `409 REPORT_ALREADY_SUBMITTED`. There is no edit endpoint and
there will not be one (RM-M16-03).

## Reading the report and rating the agent

- `GET /visites/{id}/report` — `getVisiteReport`. Readable by the **three parties
  only** (user, agent, prestataire); anyone else gets `404 VISIT_NOT_FOUND`.
  `404 REPORT_NOT_FOUND` while none is filed.
- `POST /visites/{id}/rating` — `rateVisiteAgent`, body `{"rating": 1..5}`, 204.
  Optional, **once per visit** (`409 ALREADY_RATED`), and only after the visit is
  `COMPLETED` (`409 VISIT_NOT_COMPLETED`).

`AgentProfileResponse` gains **`averageRating`** (null until someone has rated
them) and **`ratingCount`**. `completedVisitCount` finally moves — only a filed
report increments it.

## Behaviour change: the agent's cancellation window

`POST /agents/me/visites/{id}/cancel` used to be allowed at any time. It now
closes **1 hour before the slot** (RM-M16-04), answering
`409 CANCELLATION_TOO_LATE` past that — the same code the user's 4-hour cut-off
uses, so branch on the role, not the code. Doc 10's RM-M07-04 has been amended to
match.

## New notification: N17 (mandatory, admins)

72 hours after a slot with no report filed, the agent's account goes back to
**PENDING** ("En attente" — they stop being assignable, and only an admin moves
them back) and every admin gets N17. Each visit is flagged once.

## Verification

Exercised live end to end: booking, the sheet (exact address + both numbers +
user name), the public fiche still hiding it, a start refused at 2002 m and
accepted at 2002 m with a justification, a start accepted at 100 m with none, a
2-photo report rejected, the real report filed, **both** N-06 pushes on the wire,
the lock, all three parties reading it and an admin refused, `COMPLETED` +
`completedVisitCount` = 1, rating once then `ALREADY_RATED`, average 5.0 on the
profile, and the 72h sweep flagging once, flipping the agent to PENDING, alerting
the admins, and not re-alerting on the next run. 477 unit tests pass.

**Not verified locally, as always:** FCM delivery (logging provider — payloads
verified on the wire) and R2 (report photo keys are stored and length-checked,
never fetched).

---

# 2026-08-09 — fix: agent working hours were stored shifted by an hour

**No API change. Nothing to do on your side** — this is a data-correctness fix,
recorded because it would have surfaced as a mystery in production.

Working hours went into a `TIME` column, and Hibernate binds those through a UTC
calendar. An agent declaring **08:00–18:00** on a host running at UTC+1 had
**07:00–17:00** written to the database. Reads applied the inverse shift, so the
API always looked right — and would have kept looking right until the host's
offset changed, at which point every agent's declared hours would have jumped by
an hour with nobody touching them.

Working hours are now stored as literal `'HH:mm'` text. Computed slot times are
unchanged and verified: Monday 08:00–18:00 Africa/Douala still yields
`07:00Z … 16:00Z`, and hours declared under a UTC+1 JVM now read back identically
under a UTC one.

One consequence for anyone testing against the shared dev database: availability
rows created **before** this fix kept their shifted values, so an agent who had
declared 08:00 now reads 07:00 and should re-declare. There is no production data.

---

# 2026-08-09 — residence-level assignment, assignment views, visit filters

## 1. An agent can be assigned to a whole residence

A twenty-room hotel meant twenty offers, twenty answers and twenty pushes. Now:

| Endpoint | `operationId` |
|---|---|
| `POST /residences/{id}/agent` | `assignAgentToResidence` |
| `DELETE /residences/{id}/agent` | `withdrawResidenceAgentAssignment` |
| `POST /agents/me/assignments/apply/residence/{id}` | `applyToResidence` |
| `POST /agents/me/assignments/residence/{id}/accept` | `acceptResidenceAssignment` |
| `POST /agents/me/assignments/residence/{id}/decline` | `declineResidenceAssignment` |

The assignment is still recorded **per unit** — every existing per-listing
endpoint, `canPlanVisit`, and the visit chain are unchanged. `AssignmentResponse`
gains **`residenceId`**, set when the row came from a residence-level act.

Offering returns `{residenceId, residenceName, agentAccountId, offered, skipped[]}`.
**Partial success is normal**: a unit that already has an agent is listed in
`skipped` with a reason rather than failing the batch. `409 NO_PUBLISHED_UNITS`
if the residence has nothing published; `409 AGENT_ALREADY_ASSIGNED` if every
unit is already taken.

## 2. `/opportunities` groups residences

An entry is now either a standalone listing or a **whole residence**.
`AgentOpportunity` gains `residenceId`, `residenceName` and `unitCount`
(1 for a standalone listing; the count only includes units still open). For a
residence, `title` is the residence's name and `annonceId` is one of its units —
apply with `applyToResidence`, not the per-listing route.

## 3. ⚠️ New `PushTarget` value: `RESIDENCE`

A residence-level offer sends **one** N-15 with `type: RESIDENCE` and
`entityId` = the residence id (deep link `mboa://agent/residences/{id}/assignment`).
`PushTarget` is append-only, but this is the first value added since you shipped
— **please make sure an unknown `type` falls back to opening the app** rather
than failing. Tell me if you'd rather I hold this back until a client release.

## 4. Filters

- `GET /agents/me/assignments?status=` and `/agents/me/applications?status=` —
  repeatable (`?status=PENDING&status=ACCEPTED`); omitting it means all.
- **New** `GET /annonces/agent/assignments?status=` — `listMyAnnonceAssignments`,
  every assignment across a prestataire's listings. Nothing offered this before.
- `GET /visites` and `GET /agents/me/visites` take `?status=`, `?from=`, `?to=`
  (ISO-8601 instants). Same "omit means all" rule.
- **New** `GET /agents/me/visites/today` — `listMyAgentVisitesToday`, the agent's
  round for today in the business zone, soonest first. Not paged.

## Verification

Live against the real database with a 5-room hotel: one feed card showing
`unitCount: 5`, one offer call creating 5 rows and **1** push, one accept
answering all 5, `canPlanVisit` true on every unit, a visit booked on room 1 and
cancelled `AGENT_REMOVED` by the residence-level withdrawal, the residence
returning to the other agent's feed, an offer to a second agent reporting
`offered: 4, skipped: [Chambre 1]`, and every filter above. 499 unit tests pass.

**Doc 10 now has a residence section** (M10bis) — the feature had been shipped
without one.

---

# 2026-08-09 — listings are priced per period, not always per month

Real lets here are quoted per month, per quarter and per year. A prestataire
advertising 600 000 F/an had to write 50 000 and explain in the description.

**Nothing you read today breaks.** `monthlyRent` is still on every response it
was on, and still accepted on create/update.

## The model

```
price + rentalPeriod   →  what the prestataire set, what you display
monthlyRent            →  the same price normalised to one month
```

`rentalPeriod` is `MONTH` · `QUARTER` · `YEAR`. **Display `price` +
`rentalPeriod`** ("900 000 F / an"), not `monthlyRent`.

`monthlyRent` is now **derived**: it exists so that listings quoted over
different periods can be compared. `rentMin`/`rentMax`, the result ordering and a
residence card's `fromMonthlyRent` all work on it — verified live: 75 000 F/month,
225 000 F/quarter and 900 000 F/year all appear together in a
`rentMin=60000&rentMax=90000` search. It is integer-divided and **approximate for
QUARTER and YEAR** — never show it as the rent, never compute from it.

Added to: listing, search result, public fiche, residence unit, favourite,
history entry, agent opportunity.

## Sending a price

Create and update take `price` + `rentalPeriod` (period defaults to `MONTH`).
`CreateResidenceRequest.UnitGroup` takes the pair too.

**`monthlyRent` is still accepted** and means a monthly price, so no client has
to change on our schedule. Two rules:
- sending `monthlyRent` with a `rentalPeriod` other than `MONTH` → `400 PRICE_REQUIRED`;
- sending both `price` and `monthlyRent` with different values → `400 PRICE_CONFLICT`
  (guessing which one the owner meant would advertise a price they never typed).

## New search filter

`GET /search?rentalPeriods=YEAR` — repeatable, omit for all. Pairs with the
existing rent band, which still compares monthly equivalents.

## Favourites and history

Their snapshots carry `price` + `rentalPeriod` now. They only stored the monthly
figure, so a saved 540 000 F/an listing would have shown "45 000 F" — wrong in a
way nobody would have noticed for months.

## Verification

Live: three listings of identical real cost quoted per month, quarter and year —
all three in one rent band, each findable by its own `rentalPeriods` filter, the
fiche carrying the pair, the deprecated field still creating a monthly listing, a
disagreeing pair refused, and a favourited yearly listing snapshotting
`900 000 / YEAR`. Existing listings migrated as `MONTH` with `price ==
monthlyRent`. 518 unit tests pass.

---

# 2026-08-10 — residence assignment parity, batch acts, grouped lists

**Contains one breaking change**, agreed with the founder because these endpoints
are days old and not yet wired.

## ⚠️ Breaking: three lists return a different item

`listMyAgentAssignments` · `listMyAgentApplications` · `listMyAnnonceAssignments`
now page over `AssignmentItem`, not `AssignmentResponse`:

```json
{ "type": "LISTING" | "RESIDENCE",
  "assignment": { …AssignmentResponse… },
  "residence":  { "residenceId": "…", "residenceName": "Hôtel Akwa",
                  "agentAccountId": "…", "agentName": "Awa N",
                  "status": "PENDING", "initiatedBy": "PRESTATAIRE",
                  "unitCount": 20, "createdAt": "…", "respondedAt": null } }
```

Exactly one of `assignment` / `residence` is set — **the same shape
`SearchResult` already uses**, so it is a pattern you have implemented before.

Why: offering a 20-room hotel is one act, and it was showing as 20 rows. Grouping
happens **before paging**, so a batch is never split across two pages or counted
twice — which client-side grouping cannot guarantee.

Grouping key is (residence, agent, status). A batch whose units diverge (one
withdrawn on its own) appears as two entries with exact counts. In the history,
two separate episodes ending the same way merge into one entry with a summed
count; the actionable states (APPLIED, PENDING, ACCEPTED) are never affected,
since only one can exist per residence and agent at a time.

## New: the owner's side of a residence

This was missing entirely — an agent could apply to a whole residence, but the
owner then saw one application per unit with no way to answer them together.

| Endpoint | `operationId` |
|---|---|
| `GET /residences/{id}/agent/candidates?query=` | `listResidenceAgentCandidates` |
| `GET /residences/{id}/agent/applications` | `listResidenceApplications` |
| `POST /residences/{id}/agent/applications/{agentAccountId}/accept` | `acceptResidenceApplication` |
| `POST /residences/{id}/agent/applications/{agentAccountId}/decline` | `declineResidenceApplication` |
| `GET /residences/{id}/agent?status=` | `listResidenceAssignments` |

- Applications come back **grouped per agent** with their `unitCount`.
- Accept/decline take the **agent id**, not an application id — the owner is
  choosing an agent for the residence.
- Accepting covers every unit that agent applied to and is still free, declines
  the rival applications on those units, and returns
  `{residenceId, residenceName, agentAccountId, offered, skipped[]}` — a unit
  taken since they applied is reported, not fatal.
- `listResidenceAssignments` is the per-unit view (which room has whom), with a
  repeatable `status` filter.

## New: batch acts for the agent

- `POST /agents/me/assignments/residence/{id}/resign` — resigning a 20-room
  residence was 20 calls.
- `DELETE /agents/me/applications/residence/{id}` — same for withdrawing.

## Small: one batch-result shape

Every residence batch operation now returns `{"count": n}`. It previously said
`{"answered": n}` even when resigning.

## Verification

Live with a 5-room hotel and two agents: both applied → owner saw **2** entries
of 5, not 10 → each agent's own list showed **1** entry → owner accepted one in a
single call → their 5 accepted and the rival's 5 declined automatically → the
per-unit filter showed 5 ACCEPTED / 5 DECLINED → the agent resigned all 5 in one
call → withdraw and decline paths likewise → the prestataire's grouped view
turned 20 rows into 3 entries. 527 unit tests pass.

---

# 2026-08-10 — residences are first-class in the opportunity feed

**Breaking, same window as the last one** — `listAgentOpportunities` keeps its id
and changes its item shape. Mobile has not wired it.

## `GET /agents/me/assignments/opportunities`

Returns `OpportunityItem`, the third list to use the union you already implement
for `SearchResult`:

```json
{ "type": "LISTING",
  "listing": { "annonceId", "title", "primaryPhotoKey",
               "price", "rentalPeriod", "monthlyRent", "city", "district" } }

{ "type": "RESIDENCE",
  "residence": { "residenceId", "residenceName", "primaryPhotoKey",
                 "city", "district",
                 "unitCount": 80,
                 "breakdown": [ { "propertyType": "ROOM", "count": 50 },
                                { "propertyType": "STUDIO", "count": 20 },
                                { "propertyType": "APARTMENT", "count": 10 } ],
                 "fromPrice": 500000, "fromRentalPeriod": "YEAR",
                 "fromMonthlyRent": 41666 } }
```

Branch on `type`. The unused side is **absent**, not null — null fields are
omitted, as always.

### A residence entry has no `annonceId`, deliberately

It used to carry one arbitrary unit out of eighty, which made
`applyToAnnonce(annonceId)` the obvious call — and that assigns **one room**
instead of the hotel. There is now nothing to reach for but
`applyToResidence(residenceId)`.

### `fromPrice` — display it, don't compare on it

The cheapest still-open unit, chosen on the **monthly equivalent** and reported
in the period it is actually quoted in. A residence with rooms at 45 000/month
and studios at 500 000/year says **"from 500 000 F/an"**, because the studio is
the cheaper let at 41 666/month. Sort and filter on `fromMonthlyRent`, show
`fromPrice` + `fromRentalPeriod`.

### `breakdown`
Still-open units only, grouped by property type — a taken room is in neither the
count nor the breakdown.

### `alreadyApplied` is gone
It had been permanently `false` since applied-to listings left this feed.

## While we were in here: why a residence may not appear

Two real cases, both correct, both easy to mistake for a bug:

- **the owner's account is not `ACTIVE`** — RM-M11-08 keeps unverified owners'
  listings out of the pool entirely;
- **every unit already has a live assignment** — a partially-taken residence
  still appears, with only its free units counted.

## Verification

Live: the existing 80-unit `Cite blanc` as one entry with its breakdown
(50 rooms / 20 studios / 10 apartments), a purpose-built mixed-period residence
proving the `fromPrice` choice, a standalone listing unaffected, and the two
exclusions above confirmed against the database. 532 unit tests pass.

---

# 2026-08-10 — an accepted application is an assignment

**Behaviour change, no shape change.** `listMyAgentAssignments` returns the same
`AssignmentItem` page; what changed is *which rows are in it*.

## The bug

An agent applied for an apartment, the landlord approved it — and it appeared in
neither `/agents/me/assignments` nor `?status=ACCEPTED`. Confirmed and fixed.

The two lists were split by **origin**: assignments meant "offers you received",
applications meant "requests you sent", and a row kept its origin for life. So an
accepted application stayed filed under how it started rather than what it
became, and an agent's actual work was invisible in the list named after it.

## The fix

| Endpoint | Returns |
|---|---|
| `GET /agents/me/assignments` | **everything the agent holds**, filterable by `?status=` and the new repeatable `?initiatedBy=` (`PRESTATAIRE` \| `AGENT`) |
| `GET /agents/me/applications` | unchanged behaviour — now literally `?initiatedBy=AGENT` |

Every screen is a filter on the one list:

- **"My properties"** → `/assignments?status=ACCEPTED`
- **"Offers awaiting me"** → `/assignments?status=PENDING`
- **"Applications pending"** → `/applications?status=APPLIED`
- the old offers-only behaviour → `/assignments?initiatedBy=PRESTATAIRE`

`initiatedBy` is still on every entry, so you can still label "you applied for
this" versus "you were offered this". It no longer decides where the row lives.

A row can appear in both lists — `/applications` is explicitly a filtered subset
of `/assignments`, not a disjoint set.

## Verification

Live, replaying the report: the approved apartment now appears in `/assignments`
and in `?status=ACCEPTED`; a residence batch accepted from an application shows
grouped with `unitCount: 3`; an offer still arrives under `?status=PENDING`;
`?initiatedBy=PRESTATAIRE` reproduces the old view exactly. The regression is
now a unit test. 535 tests pass.

---

# 2026-08-10 — listings without units, and slots that say why they're empty

Two reports, one slice. **One shape change** on `listBookableSlots`, confirmed
not yet wired.

## 1. `GET /annonces` returns standalone listings by default

An 80-room hotel filled this page with 80 rows and appeared again under
`/residences`, which is where units are managed.

| Call | Returns |
|---|---|
| `GET /annonces` | **standalone listings only** (new default) |
| `GET /annonces?includeResidenceUnits=true` | the old behaviour |
| `GET /annonces?residenceId={id}` | that residence's units, paged |

Unchanged: `getMyAnnonce`, publish / archive / edit on a single unit. A unit is
still reachable and editable by id — only the *list* narrowed.

## 2. ⚠️ `GET /visites/slots` returns an object, not an array

```json
{ "slots": [ … ],
  "reason": null | "AGENT_NO_AVAILABILITY" | "ALL_DAYS_BLOCKED" | "FULLY_BOOKED" }
```

`reason` is null whenever `slots` is non-empty. An empty list used to be the
whole answer, so four different situations looked identical and the only possible
message was "contact the provider" — unhelpful when the truth is **the agent
never set their working hours**, which the prestataire can actually chase.

That was the reported case exactly: an agent with 81 accepted units and zero
availability rules. It now answers `AGENT_NO_AVAILABILITY`.

Suggested copy: *"L'agent n'a pas encore renseigné ses disponibilités"* ·
*"L'agent est absent cette semaine"* · *"Tous les créneaux sont réservés"*.

## 3. `canPlanVisit` now means "bookable", not merely "assigned"

The fiche's CTA required an accepted agent. It now also requires that agent to
have declared a weekly availability — otherwise the button opened an empty
screen, which is the platform making a promise on the prestataire's behalf and
breaking it.

**A listing can lose the CTA** if its agent clears their hours. That is correct.

**Deliberate limit:** `canPlanVisit` answers *"is this listing open to visits"*,
not *"are there slots this week"*. An agent on leave keeps the CTA and the slots
call explains the gap with `ALL_DAYS_BLOCKED` — computing a week of slots on
every fiche render would be far more expensive than it is worth.

## Verification

Live end to end: `/annonces` in all three modes (1 standalone / 4 with units / 3
for one residence); a residence unit whose agent has no hours answering
`AGENT_NO_AVAILABILITY` with `canPlanVisit: false`; both flipping to 133 slots
and `true` once hours were set; and a fully-blocked week answering
`ALL_DAYS_BLOCKED`. 541 unit tests pass.

---

# 2026-08-11 — fix: `/visites/slots` could hang the whole API

**No API change. Nothing to do on your side** — but worth knowing it happened,
because the symptom was "the app is slow" rather than an error.

An agent whose availability ended between **23:31 and 23:59** — for example the
natural "available any time", 00:00–23:59 — made every `/visites/slots` call on
their listings loop for ever. The slot walk stepped a `LocalTime`, which wraps
silently at midnight: 23:30 + 30 minutes is 00:00, whose visit still ended before
23:59, so the condition held and the walk restarted from midnight. Each call
pinned a CPU core; a few calls exhausted the request pool and the API stopped
answering. `POST /visites` used the same path.

The walk now steps over instants, which cannot wrap. Same results, same shape:
verified on 00:00–23:59 with 120-minute visits — **31 ms**, 308 slots over the
7-day horizon, and booking one of them still works.

If you saw the API freeze while testing visits, that was this.

---

# 2026-08-11 — `DAY` and `WEEK` rental periods

Additive: `RentalPeriod` is now `DAY` · `WEEK` · `MONTH` · `QUARTER` · `YEAR`.
Nothing changes for existing listings — the long periods normalise to exactly
the same monthly equivalents as before.

## What to display

`price` + `rentalPeriod`, as always: **"15 000 F / jour"**, "50 000 F / semaine".

## What to expect from search

`monthlyRent` normalises on a **flat 30-day month**, so a daily listing lands
high:

| Quoted | Monthly equivalent |
|---|---|
| 15 000 / day | 450 000 |
| 50 000 / week | 214 285 |
| 90 000 / month | 90 000 |

Verified live: a `rentMin=50000&rentMax=150000` search returns the monthly
listing and **not** the daily one; `rentMin=400000&rentMax=500000` returns the
daily one. That is deliberate — renting by the day genuinely costs more by the
month.

**Consequence for the apps:** a short-stay listing will not surface in an
ordinary price search. `?rentalPeriods=DAY` (and `WEEK`) is how it is found —
worth a "court séjour" entry point, or daily inventory will feel missing.

## What this is not

A booking system. The platform holds no occupancy calendar, takes no
reservation and touches no money — a daily-priced listing is still an
intermediation listing, and the dates are agreed between user and prestataire
exactly as for a monthly let. Short-stay booking remains a separate product if
it is ever wanted.

## One for M08

Doc 10 now says contract duration is expressed **in the listing's own period**
(3 days, 2 weeks, 12 months). "Durée en mois" cannot state a three-day let.

## Verification

Daily, weekly and monthly listings created and published; both search bands
behaving as above; each period filter returning its own listing; the daily
fiche showing `15000 DAY` with `monthlyRent 450000`. 552 unit tests pass.

---

# 2026-08-11 — three mobile requests: showing the agent

All additive. Nothing existing changes shape.

## 1. `agentPhotoObjectKey`

Added to `AssignmentResponse` and to the `residence` half of `AssignmentItem`.
Both already carried `agentName` from the same profile row, so this costs no
extra query — the assigned-agent list simply had no face to show.

## 2. `averageRating` + `ratingCount` on `AgentCandidate`

The candidate search returned `completedVisitCount` and dropped the rating on
the floor; both have existed on the profile since M16.

**`averageRating` is `null` until someone rates them**, and rating is optional
(RM-M07-07) — so `completedVisitCount: 12, ratingCount: 0` is a normal state.
Please don't render that as "0 ★"; it libels a perfectly good agent.

## 3. `GET /api/v1/search/agents/{id}` — `getAgentPublicProfile`

**Public**, like a listing's fiche — verified with no `Authorization` header.
It sits under `/search/**` beside `/search/annonces/{id}`; `/agents/{id}` would
have sat next to `/agents/me/**` and invited routing confusion.

```json
{ "accountId", "firstName", "lastName", "photoObjectKey",
  "completedVisitCount": 12, "averageRating": 4.75, "ratingCount": 4,
  "zones": [ { "city": "Douala" }, { "city": "Douala", "district": "Akwa" } ],
  "memberSince": "2026-08-11T21:45:26Z" }
```

`district` is absent when the agent covers a whole city.

**No phone, no email, nothing from KYC** — the same rule the provider card
follows. An agent's number reaches only the people who need it: the visit sheet
gives the agent the *user's* number on the day, not the other way round.

**A suspended or pending agent still resolves.** They are named on every visit
they carried out, and 404-ing would dead-link that history; the payload makes no
claim that they are currently working. Only a deleted account is withheld
(`404 AGENT_NOT_FOUND`), along with a non-agent id.

**No `badges: []`.** Agent badges are M20; I have just removed one permanently
false field (`alreadyApplied`) and won't add another before it can be filled.

## Verification

Live: the profile fetched unauthenticated with 12 visits and 4.75★ from 4
ratings, no contact details in the payload, 404 on an unknown id; the candidate
list carrying the rating; and the photo key on both a single assignment and a
grouped residence batch. 561 unit tests pass.
