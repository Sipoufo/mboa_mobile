# OpenAPI operation ids

Every endpoint declares an explicit `operationId`. Without one, springdoc derives
it from the Java method name and appends `_1`, `_2`, … to break ties **in scan
order** — so adding an unrelated endpoint could silently rename an existing one
and break a generated client's build. That happened to the Flutter app on
2026-08-05 (`listMine1` → `listMine2`).

## The rule

- Every `@Operation` carries `operationId`.
- Names are `<verb><Resource>`, camelCase: `createAnnonce`, `listMyFavoris`,
  `markConversationRead`, `validateSignalement`.
- Qualify with the resource even when the Java method name is currently unique —
  `create`, `update`, `validate`, `restore` are exactly the names a future module
  will reuse.
- **Treat published ids as append-only.** Renaming one breaks every generated
  client, the same way renaming a JSON field would.

## One-time rename (2026-08-06)

69 of 85 ids changed when the rule was introduced. Ids are stable from here.

| Endpoint | Old (generated) | New (fixed) |
|---|---|---|
| `DELETE /api/v1/annonces/{id}` | `delete_1` | `deleteAnnonce` |
| `DELETE /api/v1/favoris/{annonceId}` | `remove` | `removeFavori` |
| `DELETE /api/v1/historique` | `clear` | `clearMyHistorique` |
| `DELETE /api/v1/notifications/devices/{token}` | `unregister` | `unregisterDevice` |
| `DELETE /api/v1/residences/{id}` | `delete` | `deleteResidence` |
| `GET /api/v1/admin/kyc` | `listPending_1` | `listPendingKycSubmissions` |
| `GET /api/v1/admin/signalements` | `queue` | `listSignalements` |
| `GET /api/v1/admin/type-change-requests` | `listPending` | `listPendingTypeChangeRequests` |
| `GET /api/v1/annonces` | `listMine_3` | `listMyAnnonces` |
| `GET /api/v1/annonces/{id}` | `getOne_1` | `getMyAnnonce` |
| `GET /api/v1/conversations` | `listMine_2` | `listMyConversations` |
| `GET /api/v1/conversations/{id}/messages` | `listMessages` | `listConversationMessages` |
| `GET /api/v1/favoris` | `listMine_1` | `listMyFavoris` |
| `GET /api/v1/historique` | `listMine_4` | `listMyHistorique` |
| `GET /api/v1/kyc/me` | `myStatus` | `getMyKycStatus` |
| `GET /api/v1/locations/cities` | `cities` | `listCities` |
| `GET /api/v1/locations/cities/{cityId}/districts` | `districts` | `listDistricts` |
| `GET /api/v1/locations/countries` | `countries` | `listCountries` |
| `GET /api/v1/locations/regions` | `regions` | `listRegions` |
| `GET /api/v1/me` | `me` | `getMe` |
| `GET /api/v1/prestataires/me` | `myProfile_1` | `getMyPrestataireProfile` |
| `GET /api/v1/residences` | `listMine` | `listMyResidences` |
| `GET /api/v1/residences/{id}` | `getOne` | `getMyResidence` |
| `GET /api/v1/search` | `search` | `searchListings` |
| `GET /api/v1/search/annonces/{id}` | `annonceDetail` | `getAnnonceDetail` |
| `GET /api/v1/search/residences/{id}` | `residenceDetail` | `getResidenceDetail` |
| `GET /api/v1/subscriptions/me` | `mySubscription` | `getMySubscription` |
| `GET /api/v1/subscriptions/payments/{id}/receipt` | `receipt` | `getPaymentReceipt` |
| `GET /api/v1/subscriptions/tiers` | `tiers` | `listSubscriptionTiers` |
| `GET /api/v1/users/me` | `myProfile` | `getMyUserProfile` |
| `GET /api/v1/users/me/settings` | `mySettings` | `getMyUserSettings` |
| `PATCH /api/v1/annonces/{id}` | `update_1` | `updateAnnonce` |
| `PATCH /api/v1/prestataires/me` | `updateMyProfile_1` | `updateMyPrestataireProfile` |
| `PATCH /api/v1/residences/{id}` | `update` | `updateResidence` |
| `PATCH /api/v1/users/me` | `updateMyProfile` | `updateMyUserProfile` |
| `PATCH /api/v1/users/me/settings` | `updateMySettings` | `updateMyUserSettings` |
| `POST /api/v1/account/phone/change` | `requestChange` | `requestPhoneChange` |
| `POST /api/v1/account/phone/verify` | `confirmChange` | `confirmPhoneChange` |
| `POST /api/v1/admin/annonces/{id}/restore` | `restore` | `restoreAnnonce` |
| `POST /api/v1/admin/kyc/{id}/approve` | `approve_1` | `approveKycSubmission` |
| `POST /api/v1/admin/kyc/{id}/reject` | `reject_2` | `rejectKycSubmission` |
| `POST /api/v1/admin/signalements/{id}/reject` | `reject_1` | `rejectSignalement` |
| `POST /api/v1/admin/signalements/{id}/validate` | `validate` | `validateSignalement` |
| `POST /api/v1/admin/subscriptions` | `grant` | `grantSubscription` |
| `POST /api/v1/admin/type-change-requests/{id}/approve` | `approve` | `approveTypeChangeRequest` |
| `POST /api/v1/admin/type-change-requests/{id}/reject` | `reject` | `rejectTypeChangeRequest` |
| `POST /api/v1/annonces` | `create_1` | `createAnnonce` |
| `POST /api/v1/annonces/{id}/archive` | `archive` | `archiveAnnonce` |
| `POST /api/v1/annonces/{id}/publish` | `publish` | `publishAnnonce` |
| `POST /api/v1/annonces/{id}/rented` | `markRented` | `markAnnonceRented` |
| `POST /api/v1/annonces/{id}/reserve` | `reserve` | `reserveAnnonce` |
| `POST /api/v1/annonces/{id}/unarchive` | `unarchive` | `unarchiveAnnonce` |
| `POST /api/v1/auth/token/refresh` | `refresh` | `refreshToken` |
| `POST /api/v1/conversations` | `start` | `startConversation` |
| `POST /api/v1/conversations/{id}/messages` | `send` | `sendMessage` |
| `POST /api/v1/conversations/{id}/read` | `markRead` | `markConversationRead` |
| `POST /api/v1/favoris` | `add` | `addFavori` |
| `POST /api/v1/kyc` | `submit` | `submitKyc` |
| `POST /api/v1/media/uploads` | `createUpload` | `createMediaUpload` |
| `POST /api/v1/notifications/devices` | `register` | `registerDevice` |
| `POST /api/v1/prestataires/me/type-change` | `changeType` | `requestPrestataireTypeChange` |
| `POST /api/v1/residences` | `create` | `createResidence` |
| `POST /api/v1/residences/{id}/archive` | `archiveAll` | `archiveResidenceUnits` |
| `POST /api/v1/residences/{id}/publish` | `publishAll` | `publishResidenceUnits` |
| `POST /api/v1/residences/{id}/rented` | `rentAll` | `rentResidenceUnits` |
| `POST /api/v1/residences/{id}/reserve` | `reserveAll` | `reserveResidenceUnits` |
| `POST /api/v1/residences/{id}/unarchive` | `unarchiveAll` | `unarchiveResidenceUnits` |
| `POST /api/v1/signalements` | `report` | `createSignalement` |
| `POST /api/v1/subscriptions/webhook` | `webhook` | `paymentWebhook` |

## Added since (append-only)

New ids only — nothing above was renamed.

| Date | Endpoint | `operationId` |
|---|---|---|
| 2026-08-07 | `GET /api/v1/agents/me/applications` | `listMyAgentApplications` |
| 2026-08-07 | `DELETE /api/v1/agents/me/applications/{id}` | `withdrawMyAgentApplication` |
| 2026-08-07 | `POST /api/v1/agents/me/assignments/{id}/resign` | `resignAgentAssignment` |

`GET /api/v1/agents/me/assignments` (`listMyAgentAssignments`) keeps its id and
its shape, but now returns **offers received only**; applications the agent sent
moved to `/agents/me/applications`. `DELETE /agents/me/assignments/{id}`
(`withdrawAgentApplication`) still withdraws an application and is unchanged —
`withdrawMyAgentApplication` is the same action under the resource it belongs to.
| 2026-08-08 | `GET /api/v1/admin/annonces` | `listAdminAnnonces` |
| 2026-08-08 | `POST /api/v1/admin/annonces/{id}/suspend` | `suspendAnnonce` |
| 2026-08-08 | `PATCH /api/v1/admin/annonces/{id}` | `updateAnnonceAsAdmin` |
| 2026-08-09 | `GET /api/v1/agents/me/visites/{id}` | `getMyAgentVisite` |
| 2026-08-09 | `POST /api/v1/agents/me/visites/{id}/start` | `startMyAgentVisite` |
| 2026-08-09 | `POST /api/v1/agents/me/visites/{id}/report` | `submitVisiteReport` |
| 2026-08-09 | `GET /api/v1/visites/{id}/report` | `getVisiteReport` |
| 2026-08-09 | `POST /api/v1/visites/{id}/rating` | `rateVisiteAgent` |
| 2026-08-09 | `POST /api/v1/residences/{residenceId}/agent` | `assignAgentToResidence` |
| 2026-08-09 | `DELETE /api/v1/residences/{residenceId}/agent` | `withdrawResidenceAgentAssignment` |
| 2026-08-09 | `POST /api/v1/agents/me/assignments/apply/residence/{residenceId}` | `applyToResidence` |
| 2026-08-09 | `POST /api/v1/agents/me/assignments/residence/{residenceId}/accept` | `acceptResidenceAssignment` |
| 2026-08-09 | `POST /api/v1/agents/me/assignments/residence/{residenceId}/decline` | `declineResidenceAssignment` |
| 2026-08-09 | `GET /api/v1/annonces/agent/assignments` | `listMyAnnonceAssignments` |
| 2026-08-09 | `GET /api/v1/agents/me/visites/today` | `listMyAgentVisitesToday` |
| 2026-08-10 | `GET /api/v1/residences/{id}/agent/candidates` | `listResidenceAgentCandidates` |
| 2026-08-10 | `GET /api/v1/residences/{id}/agent/applications` | `listResidenceApplications` |
| 2026-08-10 | `POST /api/v1/residences/{id}/agent/applications/{agentId}/accept` | `acceptResidenceApplication` |
| 2026-08-10 | `POST /api/v1/residences/{id}/agent/applications/{agentId}/decline` | `declineResidenceApplication` |
| 2026-08-10 | `GET /api/v1/residences/{id}/agent` | `listResidenceAssignments` |
| 2026-08-10 | `POST /api/v1/agents/me/assignments/residence/{id}/resign` | `resignResidenceAssignment` |
| 2026-08-10 | `DELETE /api/v1/agents/me/applications/residence/{id}` | `withdrawResidenceApplication` |

`GET /api/v1/agents/me/assignments/opportunities` (`listAgentOpportunities`)
keeps its id; its item shape became the `OpportunityItem` union on 2026-08-10.
| 2026-08-11 | `GET /api/v1/search/agents/{id}` | `getAgentPublicProfile` |

`GET /api/v1/visites/slots` (`listBookableSlots`) keeps its id; it returned a
bare array until 2026-08-10 and now returns `{slots, reason}`.
`GET /api/v1/annonces` (`listMyAnnonces`) keeps its id and its shape; from
2026-08-10 it excludes residence units unless asked.
