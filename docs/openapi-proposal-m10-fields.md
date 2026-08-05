# OpenAPI proposal — M10 listing fields

**Status:** proposal, **not applied**. `tools/gac/mboa.openapi.yaml` is unchanged
and the client has **not** been regenerated.

That is deliberate. Generating a client with fields the backend doesn't know
means Spring either silently drops them — the prestataire fills in "Compteur
prépayé", the app reports success, the data is gone — or rejects with a 400.
Both are worse than the field not existing. **Apply this only in step with a
backend release.**

---

## Why these two, and not the other two

Comparing Doc 10 §M10 "Champs d'une annonce" against the generated client, the
API implements the CDC exactly, with **one omission**. The Pro mockups then add
four fields the CDC never specified. Recommendation per field:

| Field | Source | Verdict |
|---|---|---|
| **Équipements (checklist)** | **Doc 10** — mandated, missing from the API | **Add** (§1) |
| **Gestion d'eau / d'électricité** | Mockup only | **Add** (§2) — the list card displays it, so it is real data |
| Titre de propriété | Mockup only | **Don't** — an ownership document belongs with KYC / property verification, not a public listing. Doc 10 already hides `exactAddress` from users; a title deed is more sensitive still. |
| Période (prix) | Mockup only | **Defer** — Doc 10 says "Loyer **mensuel**" and the whole tier model assumes monthly. A price period changes the data model, search and comparison. Own decision, not an M10 field. |

If any of these is accepted, **write it back into Doc 10** — otherwise the spec
and the designs keep drifting and this gets relitigated every module.

---

## 1. Équipements — `amenities`

CDC calls it a *checklist*, so it must be a closed enum, not free text —
otherwise M04 can never filter on it.

```yaml
# components/schemas — new shared enum
Amenity:
  type: string
  enum:
    - PARKING
    - SECURITY          # gardiennage
    - WATER_TANK        # château / réserve d'eau
    - GENERATOR         # groupe électrogène
    - AIR_CONDITIONING
    - HOT_WATER
    - INTERNET
    - ELEVATOR
    - BALCONY
    - GARDEN
    - POOL
    - EQUIPPED_KITCHEN
```

Add to **`CreateAnnonceRequest`**, **`UpdateAnnonceRequest`**,
**`AnnonceResponse`**, **`UnitGroup`**, and **`SearchResultItem`** (M04 filters):

```yaml
        amenities:
          type: array
          uniqueItems: true
          items:
            $ref: '#/components/schemas/Amenity'
```

Optional in all cases — no `required` change.

## 2. Metering — `waterMetering` / `electricityMetering`

The Biens Uniques card renders "Compteur Prépayé" / "Compteur Simple", so this
is displayed data, not just a form input. Prepaid vs postpaid materially changes
a tenant's monthly cost, which makes it a genuine search/decision criterion.

```yaml
# components/schemas — new shared enum, used for both utilities
UtilityMetering:
  type: string
  enum:
    - PREPAID      # compteur prépayé
    - STANDARD     # compteur simple / postpayé
    - SHARED       # compteur partagé entre plusieurs logements
    - INCLUDED     # inclus dans le loyer
    - NONE         # pas de raccordement
```

Add to **`CreateAnnonceRequest`**, **`UpdateAnnonceRequest`**, and
**`AnnonceResponse`**:

```yaml
        waterMetering:
          $ref: '#/components/schemas/UtilityMetering'
        electricityMetering:
          $ref: '#/components/schemas/UtilityMetering'
```

Optional — existing listings have no value, and the UI must render an absent
value as "non renseigné" rather than guessing.

**For multi-unit:** the mockup puts these on the *residence* form, and metering
is usually a building-level property, so they belong on
**`CreateResidenceRequest`** / **`ResidenceResponse`**. But shared vs individual
meters is precisely the thing that varies *per unit* in a compound — if that
matters, they go on **`UnitGroup`** instead. **Needs a backend/product call;
don't apply this part on my say-so.**

---

## 3. Two things to confirm while you're in there

**`photoKeys.minItems` is `0`.** Doc 10 requires min 3 and CE-M10-03 gives the
exact copy ("Ajoute au moins 3 photos pour publier."). If the intent is that a
*draft* can have none and only *publish* enforces 3, that is sound — but then
the rule lives in `POST /annonces/{id}/publish`, and it should be enforced
server-side, not only in the app. Worth confirming which it is.
`maxItems: 15` already matches the CDC.

**"Bien Multiple" has no CDC module.** `ResidencesApi` is fully built and the
Pro designs have a complete flow, but Doc 10 §M10 describes single annonces
only. The API is ahead of the spec. Doc 10 needs a section for it — including
its own tier limits, since `TierInfo.residenceUnitAllowance` already exists and
nothing documents what it means.

---

## Applying this later

1. Backend ships the fields.
2. Replace `tools/gac/mboa.openapi.yaml` with their export (don't hand-merge —
   the spec is generated from their annotations).
3. `make gen-api`, then `make analyze`.
4. Expect operation ids to shift: the 2026-08-05 regen renamed `listMine1` to
   `listMine2` and broke `ProDashboardRepository`. Generated ids are not stable.
