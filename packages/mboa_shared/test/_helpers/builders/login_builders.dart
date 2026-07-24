import 'package:mboa_shared/mboa_shared.dart';

/// Test data builders — keep fixtures readable and intent-revealing.
OtpSession buildOtpSession({
  String phoneNumber = '+237690000000',
}) {
  return OtpSession(
    phoneNumber: phoneNumber,
  );
}
