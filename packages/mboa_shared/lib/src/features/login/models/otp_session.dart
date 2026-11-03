import 'package:equatable/equatable.dart';

/// Where a sign-in code went (§40 A): the screen says so, « Code envoyé sur
/// WhatsApp ». [unknown] when the server did not say.
enum OtpChannel {
  whatsapp,
  sms,
  email,
  unknown;

  static OtpChannel parse(String? raw) => switch ((raw ?? '').toUpperCase().trim()) {
        'WHATSAPP' => OtpChannel.whatsapp,
        'SMS' => OtpChannel.sms,
        'EMAIL' => OtpChannel.email,
        _ => OtpChannel.unknown,
      };
}

/// An in-flight sign-in code: who it is for — a phone number (any country,
/// E.164) or, since §40 A, an email — and where it went.
class OtpSession extends Equatable {
  const OtpSession({
    this.phoneNumber,
    this.email,
    this.channel = OtpChannel.unknown,
  }) : assert(phoneNumber != null || email != null, 'a phone number or an email');

  final String? phoneNumber;
  final String? email;
  final OtpChannel channel;

  bool get byEmail => email != null;

  /// What the code was sent to, as typed.
  String get recipient => email ?? phoneNumber!;

  OtpSession withChannel(OtpChannel channel) => OtpSession(phoneNumber: phoneNumber, email: email, channel: channel);

  @override
  List<Object?> get props => [phoneNumber, email, channel];
}
