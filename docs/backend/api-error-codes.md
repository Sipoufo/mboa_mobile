# API error codes

Every failing endpoint returns the same body. The **`error`** field is the stable,
machine-readable code — branch on it. `message` is prose for a human and may be
reworded at any time, so never parse or match it.

```json
{
  "timestamp": "2026-06-15T10:30:00Z",
  "status": 409,
  "error": "LISTING_LIMIT_REACHED",
  "message": "Your plan's active-listing limit is reached.",
  "path": "/api/v1/annonces/{id}/publish"
}
```

`VALIDATION_ERROR` additionally carries `fields`, one entry per rejected input:

```json
"fields": [{ "field": "attachmentKeys", "message": "A message carries at most 3 images." }]
```

The schema is published in the OpenAPI document as `ErrorResponse` and referenced
from the 4xx/5xx responses of every operation.

> Generated from the source on 2026-08-07 — 90 codes.
> Regenerate after adding a code: every `MboaException.<kind>("CODE", "message")`
> in `src/main/java` appears here.

## Codes emitted by the global handler

These can come from any endpoint, not just one module.

| Code | HTTP | When |
|---|---|---|
| `VALIDATION_ERROR` | 400 | Bean-validation rejected the request body; see `fields` |
| `UNAUTHORIZED` | 401 | Missing, expired or invalid access token |
| `ACCESS_DENIED` | 403 | Authenticated, but the role is not allowed here |
| `NOT_FOUND` | 404 | No endpoint for this URL |
| `MALFORMED_REQUEST` | 400 | Body could not be read — bad JSON, or a value that does not fit its type |
| `METHOD_NOT_ALLOWED` | 405 | Route exists but not for this HTTP method |
| `CONSTRAINT_VIOLATION` | 409 | A concurrent write lost a uniqueness race — safe to retry |
| `INTERNAL_ERROR` | 500 | Unexpected server error |

## Codes by module

### M13 — Subscriptions & payment

| Code | HTTP | Meaning |
|---|---|---|
| `INVALID_DURATION` | 400 | The grant duration must be positive. |
| `INVALID_PRICE` | 400 | The monthly price cannot be negative. |
| `INVALID_SIGNATURE` | 401 | Invalid webhook signature. |
| `INVALID_TIER` | 400 | The Free tier does not require payment. |
| `NO_RECEIPT` | 409 | No receipt is available for this payment. |
| `PAYMENT_NOT_FOUND` | 404 | Unknown payment reference. |
| `PLAN_NOT_FOUND` | 404 | Plan not configured for this tier. |

### M18 — Admin users

| Code | HTTP | Meaning |
|---|---|---|
| `ACCOUNT_DELETED` | 409 | This account has been deleted. |
| `ACCOUNT_NOT_FOUND` | 404 | Account not found. |
| `ALREADY_SUSPENDED` | 409 | This account is already suspended. |
| `NOT_SUSPENDED` | 409 | This account is not suspended. |

### M15 / M11 — Agent profile, availability & assignment

| Code | HTTP | Meaning |
|---|---|---|
| `ACCOUNT_NOT_FOUND` | 404 | Account not found. |
| `AGENT_ALREADY_ASSIGNED` | 409 | This listing already has an agent. Remove them first. |
| `AGENT_NOT_ELIGIBLE` | 400 | This agent does not cover the listing's area, or is not available. |
| `ALREADY_APPLIED` | 409 | You have already applied to this listing. |
| `ANNONCE_NOT_FOUND` | 404 | Listing not found. |
| `ANNONCE_NOT_PUBLISHED` | 409 | This listing is not published; it cannot take an agent yet. |
| `NO_PUBLISHED_UNITS` | 409 | This residence has no published unit to assign or apply to. |
| `ASSIGNMENT_NOT_FOUND` | 404 | Also: this agent has no open application on this residence, or you hold no accepted assignment on it. |
| `RESIDENCE_NOT_FOUND` | 404 | Residence not found. |
| `ASSIGNMENT_ALREADY_ANSWERED` | 409 | This application was already answered. |
| `ASSIGNMENT_NOT_ACCEPTED` | 409 | Only an accepted assignment can be resigned — an offer is declined, an application is withdrawn. |
| `ASSIGNMENT_NOT_FOUND` | 404 | Application not found. |
| `DAY_IN_THE_PAST` | 400 | You cannot block a day that has passed. |
| `INVALID_WINDOW` | 400 | A working window must end after it starts. |
| `OVERLAPPING_WINDOWS` | 400 | Two working windows on the same day overlap. |
| `AGENT_NOT_FOUND` | 404 | Agent not found — unknown, not an agent, deleted, or without a profile yet. |
| `ZONE_REQUIRED` | 400 | Choose at least one city or district you cover. |

### M10 — Listings & residences

| Code | HTTP | Meaning |
|---|---|---|
| `ALREADY_ARCHIVED` | 409 | This listing is already archived. |
| `ANNONCE_NOT_FOUND` | 404 | Listing not found. |
| `INCOMPLETE_LOCATION` | 400 | Latitude and longitude must be provided together. |
| `INSUFFICIENT_PHOTOS` | 400 | Add at least 3 photos to publish. |
| `INVALID_STATUS_TRANSITION` | 409 | Only a draft listing can be published. |
| `LISTING_LIMIT_REACHED` | 409 | Your plan's active-listing limit is reached. |
| `PRICE_CONFLICT` | 400 | `price` and the deprecated `monthlyRent` disagree — send only `price` + `rentalPeriod`. |
| `PRICE_REQUIRED` | 400 | A price is required; `monthlyRent` alone cannot carry a non-monthly period. |
| `PROFILE_INCOMPLETE` | 409 | Complete your prestataire profile before publishing. |
| `RESIDENCE_NOT_FOUND` | 404 | Residence not found. |
| `RESIDENCE_UNIT_LIMIT` | 409 | Your plan allows at most |
| `TOO_MANY_UNITS` | 400 | A residence cannot exceed |

### M01 — Authentication

| Code | HTTP | Meaning |
|---|---|---|
| `ACCOUNT_BLOCKED` | 403 | This account cannot sign in. |
| `ACCOUNT_NOT_FOUND` | 404 | Account not found. |
| `EMAIL_ALREADY_USED` | 409 | This email is already registered. |
| `INVALID_CREDENTIALS` | 401 | Invalid email or password. |
| `INVALID_ROLE` | 400 | Only AGENT or PRESTATAIRE can self-register. |
| `NO_CURRENT_PHONE` | 400 | This account has no phone number to change. |
| `NO_PASSWORD_SET` | 409 | This account does not use a password. |
| `NO_PENDING_VERIFICATION` | 400 | No code to resend. Request one first. |
| `OTP_INVALID` | 400 | Incorrect code. |
| `OTP_INVALID_OR_EXPIRED` | 400 | No valid code for this number. Request a new one. |
| `OTP_MAX_ATTEMPTS` | 400 | Too many incorrect attempts. Request a new code. |
| `PASSWORD_UNCHANGED` | 400 | The new password must differ from the current one. |
| `PHONE_ALREADY_USED` | 409 | This phone number is already registered. |
| `PHONE_UNCHANGED` | 400 | The new number is the same as the current one. |
| `REFRESH_TOKEN_EXPIRED` | 401 | Refresh token has expired. |
| `REFRESH_TOKEN_INVALID` | 401 | Invalid refresh token. |
| `REFRESH_TOKEN_REUSED` | 401 | Refresh token already used. |
| `SOCIAL_TOKEN_INVALID` | 401 | Invalid social login token. |
| `UNSUPPORTED_PROVIDER` | 400 | Unsupported social provider. |
| `USE_PASSWORD_LOGIN` | 403 | This account signs in with email and password. |

### M06 — Favourites & history

| Code | HTTP | Meaning |
|---|---|---|
| `FAVORITE_LIMIT_REACHED` | 409 | Your favourites are full. Remove one before saving another. |

### M01bis — Identity verification

| Code | HTTP | Meaning |
|---|---|---|
| `ACCOUNT_NOT_FOUND` | 404 | Account not found. |
| `KYC_ALREADY_PENDING` | 409 | A KYC submission is already under review. |
| `KYC_ALREADY_VERIFIED` | 409 | This account is already verified. |
| `KYC_NOT_PENDING` | 409 | This submission has already been reviewed. |
| `KYC_SUBMISSION_NOT_FOUND` | 404 | KYC submission not found. |

### Reference data (locations)

| Code | HTTP | Meaning |
|---|---|---|
| `UNKNOWN_CITY` | 400 | Unknown city. |
| `UNKNOWN_DISTRICT` | 400 | Unknown district. |

### Media uploads

| Code | HTTP | Meaning |
|---|---|---|
| `FILE_TOO_LARGE` | 400 | This file is too large. |
| `UNSUPPORTED_MEDIA_TYPE` | 400 | This file type is not allowed. |

### M12 — Messaging

| Code | HTTP | Meaning |
|---|---|---|
| `ANNONCE_UNAVAILABLE` | 409 | This listing is no longer available. |
| `CONTACT_NOT_ALLOWED` | 403 | You cannot contact your own listing. |
| `CONVERSATION_NOT_FOUND` | 404 | Conversation not found. |
| `CONVERSATION_READ_ONLY` | 409 | This listing is no longer available. |
| `EMPTY_MESSAGE` | 400 | A message needs text or at least one image. |
| `MESSAGE_NOT_FOUND` | 404 | Message not found. |
| `TOO_MANY_ATTACHMENTS` | 400 | A message carries at most 3 images. |

### M02 — Prestataire profile & type change

| Code | HTTP | Meaning |
|---|---|---|
| `PRESTATAIRE_PROFILE_NOT_FOUND` | 404 | No prestataire profile to update. |
| `REASON_REQUIRED` | 400 | A justification is required to change your type before the 90-day window. |
| `TYPE_CHANGE_ALREADY_REVIEWED` | 409 | This request has already been reviewed. |
| `TYPE_CHANGE_NOT_FOUND` | 404 | Type-change request not found. |
| `TYPE_CHANGE_PENDING` | 409 | A type-change request is already under review. |
| `TYPE_CHANGE_RESTRICTED` | 409 | Changing the provider type must go through the type-change request. |
| `TYPE_NOT_SET` | 400 | Set your provider type before changing it. |
| `TYPE_UNCHANGED` | 400 | The requested type is the current one. |

### M04 / M05 — Search & fiche bien

| Code | HTTP | Meaning |
|---|---|---|
| `ANNONCE_UNAVAILABLE` | 404 | This listing is no longer available. |
| `LOCATION_REQUIRED` | 400 | A city or district is required to search. |
| `RESIDENCE_NOT_FOUND` | 404 | Residence not found. |

### M23 — Reports & moderation

| Code | HTTP | Meaning |
|---|---|---|
| `ALREADY_REPORTED` | 409 | You already have a report pending on this item. |
| `ALREADY_REVIEWED` | 409 | This report has already been reviewed. |
| `SIGNALEMENT_NOT_FOUND` | 404 | Report not found. |

### M19 — Admin listing moderation

| Code | HTTP | Meaning |
|---|---|---|
| `ANNONCE_NOT_FOUND` | 404 | Listing not found. |
| `INVALID_STATUS_TRANSITION` | 409 | Only a suspended listing can be restored. |
| `VALIDATION_ERROR` | 400 | `reason` is required when suspending — the owner is told why (CA-M19-02). |

Suspending a listing that is already suspended is **not** an error: it is a no-op
that keeps the original reason and re-notifies nobody, so the automatic
suspension (RM-M23-03) can fire on a listing an admin has already pulled.

### M02 — User profile & settings

| Code | HTTP | Meaning |
|---|---|---|
| `NOTIFICATION_MANDATORY` | 409 | This notification type cannot be disabled. |

### M07 — Visits

| Code | HTTP | Meaning |
|---|---|---|
| `AGENT_NOT_CONFIRMED` | 409 | An agent has been contacted for this listing but has not confirmed yet. |
| `ALREADY_RATED` | 409 | You have already rated this visit. |
| `CANCELLATION_TOO_LATE` | 409 | Too late to cancel online — 4h before the slot for the user, 1h for the agent. |
| `REPORT_ALREADY_SUBMITTED` | 409 | This visit already has a report (locked — RM-M16-03). |
| `REPORT_NOT_FOUND` | 404 | No report has been filed yet. |
| `TOO_FAR_FROM_PROPERTY` | 400 | You are more than 500 m away; confirm with a justification to start anyway. |
| `VISIT_ALREADY_STARTED` | 409 | This visit has already been started. |
| `VISIT_NOT_COMPLETED` | 409 | You can rate the agent once the visit has been carried out. |
| `VISIT_NOT_TODAY` | 409 | A visit can only be started on the day it is scheduled. |
| `NO_AGENT_ASSIGNED` | 409 | This listing does not have an agent yet. Contact the provider directly. |
| `SLOT_NOT_AVAILABLE` | 400 | That time is no longer available. Please pick another. |
| `VISIT_NOT_FOUND` | 404 | Visit not found. |
| `VISIT_NOT_SCHEDULED` | 409 | This visit is no longer scheduled. |
| `VISIT_SLOT_TAKEN` | 409 | That time has just been taken, or you already have a visit booked here. |

### Booking a visit: three different "you cannot book" answers

`GET /visites/slots` and `POST /visites` used to answer `NO_AGENT_ASSIGNED` for
every case, which read as a bug to an owner who had just offered their listing to
an agent. They are now distinct, and one of them is not an error at all:

| Situation | Answer |
|---|---|
| The listing has no agent, or only open applications the owner has not chosen from | `NO_AGENT_ASSIGNED` (409) |
| An agent was offered the listing and has not answered | `AGENT_NOT_CONFIRMED` (409) |
| An agent accepted but has declared no availability, or is fully booked | **`200` with an empty slot list** (CE-M07-01) — invite the user to contact the prestataire |
