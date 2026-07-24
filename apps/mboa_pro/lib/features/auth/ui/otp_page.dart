import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// App-Mboa-Pro route adapter around the shared [OtpView].
@RoutePage()
class OtpPage extends StatelessWidget {
  const OtpPage({required this.session, super.key});

  final OtpSession session;

  @override
  Widget build(BuildContext context) => OtpView(session: session);
}
