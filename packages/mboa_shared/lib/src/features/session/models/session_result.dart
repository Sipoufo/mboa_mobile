import 'package:equatable/equatable.dart';

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
  const SessionAuthenticated({this.fromCache = false});

  final bool fromCache;

  @override
  List<Object?> get props => [fromCache];
}

/// No session, or the session was rejected by the server (refresh failed).
final class SessionUnauthenticated extends SessionResult {
  const SessionUnauthenticated();
}

/// An unexpected error prevented the check (not a connectivity problem); the
/// splash can offer a retry. The UI renders a localised message.
final class SessionCheckError extends SessionResult {
  const SessionCheckError();
}
