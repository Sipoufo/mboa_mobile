import 'package:equatable/equatable.dart';

/// An in-flight OTP challenge: the phone number being verified plus the
/// server-issued challenge id the code must be submitted against.
class OtpSession extends Equatable {
  const OtpSession({
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}
