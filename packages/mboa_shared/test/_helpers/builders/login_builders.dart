import 'package:mboa_shared/mboa_shared.dart';

/// Test data builders — keep fixtures readable and intent-revealing.
OtpSession buildOtpSession({
  String? phoneNumber = '+237690000000',
  String? email,
  OtpChannel channel = OtpChannel.unknown,
}) {
  return OtpSession(
    phoneNumber: email == null ? phoneNumber : null,
    email: email,
    channel: channel,
  );
}
