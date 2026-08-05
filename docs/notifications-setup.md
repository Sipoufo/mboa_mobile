# Push notifications (FCM) — setup

CDC **M03**. Firebase project: `mboa-7162d`.

Two apps need this independently (`mboa_user`, `mboa_pro`) — each has its own
bundle id, so each needs its own Firebase *app* inside the same project.

---

## 0. Credentials: what goes where

This is the part that is easy to get wrong, so it comes first.

| File | Kind | Belongs in | Committed? |
|---|---|---|---|
| `keys/fcm.json` (`"type": "service_account"`) | **Server private key** | Spring Boot backend only | **Never** |
| `google-services.json` | Android *client* config | `apps/<app>/android/app/` | Yes — it holds no secret |
| `GoogleService-Info.plist` | iOS *client* config | `apps/<app>/ios/Runner/` | Yes — it holds no secret |
| APNs auth key (`.p8`) | Apple private key | Uploaded to Firebase console | **Never** |

`FCM_CREDENTIALS_LOCATION=file:/…/keys/fcm.json` is a **backend** env var. It
authenticates the Firebase Admin SDK so the server can *send* pushes. It must
not reach the mobile app: a shipped binary is public, so anyone could extract
the key and send notifications as Mboa. The app never sends — it only receives,
and registers its device token with our own API.

The client config files look secret but aren't: they contain the project id,
sender id and an API key that is scoped and useless on its own. Firebase
documents them as safe to commit.

---

## 1. Firebase console — one-time, per app *(you)*

For **each** of `mboa_user` and `mboa_pro`:

1. Firebase console → project `mboa-7162d` → **Add app**.
2. **Android**: enter the applicationId from `apps/<app>/android/app/build.gradle`.
   Download `google-services.json` → `apps/<app>/android/app/google-services.json`.
3. **iOS**: enter the bundle id from the Xcode target.
   Download `GoogleService-Info.plist` → `apps/<app>/ios/Runner/GoogleService-Info.plist`
   (add it to the Runner target **in Xcode**, not just on disk — otherwise it
   isn't in the bundle at runtime).

## 2. Apple — one-time *(you)*

APNs is required; FCM is only a relay on iOS.

1. Apple Developer → Keys → **new key** with *Apple Push Notifications service (APNs)*
   enabled. Download the `.p8` (**one download only** — Apple never shows it again).
2. Firebase console → Project settings → Cloud Messaging → iOS app → upload the
   `.p8` with its **Key ID** and your **Team ID**.
3. Xcode → Runner target → Signing & Capabilities → add **Push Notifications**
   and **Background Modes → Remote notifications**.

Simulators cannot receive push. Device testing is required.

## 3. Flutter wiring *(me, once step 1 lands)*

1. Add `firebase_core` + `firebase_messaging` to both apps.
2. Android: Google Services Gradle plugin; confirm `minSdk >= 21`.
3. `Firebase.initializeApp()` in `main.dart`, before `runApp`.
4. A `NotificationsRepository` in `mboa_shared` (both apps need identical
   behaviour):
   - request permission (iOS + Android 13+ `POST_NOTIFICATIONS`);
   - read the FCM token, register it via
     `NotificationDevicesApi.register({token, platform})` — the generated
     endpoint already exists, `platform` is `ANDROID | IOS | WEB`;
   - listen to `onTokenRefresh` and re-register;
   - `unregister` on logout, *before* the tokens are cleared — otherwise the
     call 401s and the device keeps receiving pushes for a signed-out account.
5. Handlers for all three app states: foreground (`onMessage` → in-app toast),
   background tap (`onMessageOpenedApp`), and terminated
   (`getInitialMessage`). A top-level `@pragma('vm:entry-point')` background
   handler is required for data messages.
6. Deep-link routing per **CA-M03-02**: a notification tap must open the screen
   it refers to, not just the home. The payload needs a stable
   `{type, entityId}` contract — **needs agreeing with the backend**, and it is
   the one piece of this that can't be inferred from the generated client.
7. Per-type notification preferences, which `user_settings` already supports and
   PROJECT_STATUS lists as pending.

## 4. Registration lifecycle

Register **after** authentication, not at startup: the endpoint is
authenticated, and a token registered pre-login can't be attributed to a user.

```
login/splash → session established → request permission → get token → register
logout       → unregister (before clearing tokens) → clear
token refresh→ re-register (only while a session exists)
```

## 5. Blocked on

- `google-services.json` and `GoogleService-Info.plist` for **both** apps (§1).
- APNs key uploaded to Firebase (§2).
- The notification payload contract for deep links (§3.6).

Everything else is ready: `NotificationDevicesApi` is generated, and the
`onSessionExpired` / logout path that `unregister` has to hook into already
exists in `mboa_core`.
