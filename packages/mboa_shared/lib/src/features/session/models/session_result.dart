import 'package:equatable/equatable.dart';

import '../../profile/models/account_role.dart';

/// Outcome of a startup session check ([SessionRepository.resolve]).
///
/// Shared by both apps' splash features; each app maps these to its own routes.
sealed class SessionResult extends Equatable {
  const SessionResult();

  @override
  List<Object?> get props => [];
}

/// A valid session exists. [fromCache] is true when the token could not be
/// validated against the server (offline) but is trusted so the app still opens
/// — honouring the offline-first rule.
final class SessionAuthenticated extends SessionResult {
  const SessionAuthenticated({
    this.fromCache = false,
    this.role,
  });

  final bool fromCache;

  /// The account's role, read from the `/me` the check already makes.
  ///
  /// Null on the [fromCache] path, where `/me` never ran. Nullable rather than
  /// defaulted: "unknown" must not be mistaken for "an ordinary user".
  final AccountRole? role;

  @override
  List<Object?> get props => [fromCache, role];
}

/// Why the startup check decided there is no session.
///
/// Four very different situations end on the same screen, and without this
/// they are indistinguishable from the outside — "why am I asked to sign in
/// again?" has no answer you can read off a log, a crash report, or a bug
/// report from a tester.
enum NoSessionReason {
  /// Nothing in secure storage: a fresh install, or a sign-out.
  noTokens,

  /// The refresh token is past its own expiry — rejected locally, without a
  /// call, because redeeming it could only 401.
  refreshExpired,

  /// The server rejected it: `/me` answered 401 after the interceptor had
  /// already tried, and failed, to refresh.
  rejectedByServer,
}

/// No session, or the session was rejected by the server (refresh failed).
final class SessionUnauthenticated extends SessionResult {
  const SessionUnauthenticated(this.reason);

  final NoSessionReason reason;

  @override
  List<Object?> get props => [reason];
}

/// An unexpected error prevented the check (not a connectivity problem); the
/// splash can offer a retry. The UI renders a localised message.
final class SessionCheckError extends SessionResult {
  const SessionCheckError();
}
